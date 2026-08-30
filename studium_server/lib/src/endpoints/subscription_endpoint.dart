// SUBSCRIPTION ENDPOINT
import 'package:serverpod/server.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'dart:convert';
import '../generated/protocol.dart';
import '../util/endpoint_utils.dart';

class SubscriptionEndpoint extends Endpoint with EndpointUtils {
  @override
  bool get requireLogin => true;

  static const _stripeApiUrl = 'https://api.stripe.com/v1';
  static const _paystackApiUrl = 'https://api.paystack.co';

  Future<Subscription> createSubscription(
      Session session, String gateway, String paymentToken,
      [String? idempotencyKey]) async {
    final userId = await getAuthenticatedUserId(session);

    if (!{'stripe', 'paystack'}.contains(gateway)) {
      throw Exception('Invalid payment gateway specified');
    }
    final userProfile = await UserProfile.db
        .findFirstRow(session, where: (t) => t.userId.equals(userId));
    final userInfo = await UserInfo.db
        .findFirstRow(session, where: (t) => t.id.equals(userId));

    if (userProfile == null || userInfo == null) {
      throw Exception('User profile not found');
    }

    final normalizedKey = idempotencyKey?.trim();
    SubscriptionOperation? operation;
    if (normalizedKey != null && normalizedKey.isNotEmpty) {
      if (normalizedKey.length < 16 || normalizedKey.length > 200) {
        throw Exception(
            'Idempotency key must be between 16 and 200 characters.');
      }
      operation = await session.db.transaction((transaction) async {
        final existing = await SubscriptionOperation.db.findFirstRow(
          session,
          where: (t) =>
              t.userId.equals(userId) &
              t.gateway.equals(gateway) &
              t.idempotencyKey.equals(normalizedKey),
          transaction: transaction,
        );
        if (existing != null) {
          if (existing.status == 'completed' &&
              existing.subscriptionId != null) {
            return existing;
          }
          if (existing.status == 'processing') {
            throw Exception('This subscription request is already processing.');
          }
          existing.status = 'processing';
          existing.errorMessage = null;
          existing.updatedAt = DateTime.now();
          return SubscriptionOperation.db.updateRow(
            session,
            existing,
            transaction: transaction,
          );
        }
        final now = DateTime.now();
        return SubscriptionOperation.db.insertRow(
          session,
          SubscriptionOperation(
            userId: userId,
            gateway: gateway,
            idempotencyKey: normalizedKey,
            status: 'processing',
            createdAt: now,
            updatedAt: now,
          ),
          transaction: transaction,
        );
      });
      final completedOperation = operation;
      if (completedOperation != null &&
          completedOperation.subscriptionId != null &&
          completedOperation.status == 'completed') {
        final existingSubscription = await Subscription.db.findById(
          session,
          completedOperation.subscriptionId!,
        );
        if (existingSubscription != null) return existingSubscription;
        throw Exception('Idempotent subscription record is incomplete.');
      }
    }

    String subscriptionId = '';
    String? gatewayToken;
    DateTime? endDate;

    try {
      switch (gateway) {
        case 'stripe':
          final stripeResult = await _createStripeSubscription(
              session, userProfile, paymentToken);
          subscriptionId = stripeResult['subscriptionId']!;
          endDate = stripeResult['endDate'];
          break;
        case 'paystack':
          final paystackResult = await _createPaystackSubscription(
              session, userProfile, paymentToken);
          subscriptionId = paystackResult['subscriptionId']!;
          gatewayToken = paystackResult['gatewayToken'];
          endDate = paystackResult['endDate'];
          break;
      }
    } catch (error) {
      if (operation != null) {
        operation.status = 'failed';
        operation.errorMessage = error
            .toString()
            .substring(0, error.toString().length.clamp(0, 2000));
        operation.updatedAt = DateTime.now();
        await SubscriptionOperation.db.updateRow(session, operation);
      }
      rethrow;
    }

    final subscription = Subscription(
      userId: userId,
      gateway: gateway,
      subscriptionId: subscriptionId,
      gatewayToken: gatewayToken,
      // Gateway callbacks are the source of truth for entitlement activation.
      status: 'pending',
      startDate: DateTime.now(),
      endDate: endDate,
    );

    final created = await Subscription.db.insertRow(session, subscription);
    if (operation != null) {
      operation.status = 'completed';
      operation.subscriptionId = created.id;
      operation.updatedAt = DateTime.now();
      await SubscriptionOperation.db.updateRow(session, operation);
    }
    return created;
  }

  /// Creates a Stripe subscription.
  Future<Map<String, dynamic>> _createStripeSubscription(
      Session session, UserProfile userProfile, String paymentMethodId) async {
    final stripeApiKey = await getApiKey(session, 'stripe');
    final stripePriceId = await getApiKey(session, 'stripePriceId');

    // 1. Get or create a Stripe Customer
    var stripeCustomerId = userProfile.stripeCustomerId;
    if (stripeCustomerId == null) {
      final userInfo = await UserInfo.db
          .findFirstRow(session, where: (t) => t.id.equals(userProfile.userId));
      final customer = await _createStripeCustomer(
          session, stripeApiKey, userInfo!.email, userProfile.name);
      stripeCustomerId = customer['id'];

      // Save the new customer ID to the user's profile
      await UserProfile.db.updateRow(
          session, userProfile.copyWith(stripeCustomerId: stripeCustomerId));
    }

    // 2. Attach PaymentMethod to the Customer
    await http.post(
      Uri.parse('$_stripeApiUrl/payment_methods/$paymentMethodId/attach'),
      headers: {
        'Authorization': 'Bearer $stripeApiKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {'customer': stripeCustomerId},
    );

    // 3. Set the new PaymentMethod as the default for the customer
    await http.post(
      Uri.parse('$_stripeApiUrl/customers/$stripeCustomerId'),
      headers: {
        'Authorization': 'Bearer $stripeApiKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {'invoice_settings[default_payment_method]': paymentMethodId},
    );

    // 4. Create the subscription
    final response = await http.post(
      Uri.parse('$_stripeApiUrl/subscriptions'),
      headers: {
        'Authorization': 'Bearer $stripeApiKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        'customer': stripeCustomerId,
        'items[0][price]': stripePriceId,
        'expand[]': 'latest_invoice.payment_intent',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Stripe subscription creation error: ${response.body}');
    }

    final responseData = jsonDecode(response.body);
    return {
      'subscriptionId': responseData['id'],
      'endDate': DateTime.fromMillisecondsSinceEpoch(
          responseData['current_period_end'] * 1000),
    };
  }

  /// Helper to create a Stripe Customer.
  Future<Map<String, dynamic>> _createStripeCustomer(
      Session session, String apiKey, String? email, String? name) async {
    final response = await http.post(
      Uri.parse('$_stripeApiUrl/customers'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/x-www-form-urlencoded'
      },
      body: {
        if (email != null) 'email': email,
        if (name != null) 'name': name,
        'description': 'Studium AI Customer',
      },
    );
    if (response.statusCode != 200) {
      throw Exception('Stripe customer creation error: ${response.body}');
    }
    return jsonDecode(response.body);
  }

  /// Creates a Paystack subscription.
  Future<Map<String, dynamic>> _createPaystackSubscription(Session session,
      UserProfile userProfile, String authorizationCode) async {
    final paystackApiKey = await getApiKey(session, 'paystack');
    final paystackPlanCode = await getApiKey(session, 'paystackPlanCode');

    // 1. Get or create a Paystack Customer
    var paystackCustomerCode = userProfile.paystackCustomerCode;
    if (paystackCustomerCode == null) {
      final userInfo = await UserInfo.db
          .findFirstRow(session, where: (t) => t.id.equals(userProfile.userId));
      final customer = await _createPaystackCustomer(
          session, paystackApiKey, userInfo!.email, userProfile.name);
      paystackCustomerCode = customer['data']['customer_code'];

      // Save the new customer code to the user's profile
      await UserProfile.db.updateRow(session,
          userProfile.copyWith(paystackCustomerCode: paystackCustomerCode));
    }

    // 2. Create the subscription using the authorization code from the frontend
    final response = await http.post(
      Uri.parse('$_paystackApiUrl/subscription'),
      headers: {
        'Authorization': 'Bearer $paystackApiKey',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'customer': paystackCustomerCode,
        'plan': paystackPlanCode,
        'authorization': authorizationCode,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Paystack subscription creation error: ${response.body}');
    }

    final responseData = jsonDecode(response.body)['data'];
    return {
      'subscriptionId': responseData['subscription_code'],
      'gatewayToken': responseData[
          'email_token'], // Important for managing the subscription
      'endDate': DateTime.parse(responseData['next_payment_date']),
    };
  }

  /// Helper to create a Paystack Customer.
  Future<Map<String, dynamic>> _createPaystackCustomer(
      Session session, String apiKey, String? email, String? name) async {
    final response = await http.post(
      Uri.parse('$_paystackApiUrl/customer'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json'
      },
      body: jsonEncode({
        'email': email,
        if (name != null) 'first_name': name.split(' ').first,
        if (name != null && name.split(' ').length > 1)
          'last_name': name.split(' ').sublist(1).join(' '),
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Paystack customer creation error: ${response.body}');
    }
    return jsonDecode(response.body);
  }

  /// Cancels the user's active subscription.
  Future<bool> cancelSubscription(Session session) async {
    final userId = await getAuthenticatedUserId(session);
    var userProfile = await UserProfile.db
        .findFirstRow(session, where: (t) => t.userId.equals(userId));

    if (userProfile == null || userProfile.subscriptionId == null) {
      throw Exception('No active subscription found for this user.');
    }

    var subscription = await Subscription.db.findFirstRow(session,
        where: (t) => t.subscriptionId.equals(userProfile!.subscriptionId));
    if (subscription == null) throw Exception('Subscription record not found.');

    if (subscription.gateway == 'stripe') {
      final stripeApiKey = await getApiKey(session, 'stripe');
      final response = await http.delete(
        Uri.parse(
            '$_stripeApiUrl/subscriptions/${subscription.subscriptionId}'),
        headers: {'Authorization': 'Bearer $stripeApiKey'},
      );

      if (response.statusCode != 200) {
        throw Exception('Stripe cancellation error: ${response.body}');
      }
    } else if (subscription.gateway == 'paystack') {
      final paystackApiKey = await getApiKey(session, 'paystack');
      // Paystack requires the subscription code and an email_token to disable
      if (subscription.gatewayToken == null) {
        throw Exception(
            'Paystack subscription token is missing. Cannot cancel.');
      }
      final response = await http.post(
        Uri.parse('$_paystackApiUrl/subscription/disable'),
        headers: {
          'Authorization': 'Bearer $paystackApiKey',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          'code': subscription.subscriptionId,
          'token': subscription.gatewayToken,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception('Paystack cancellation error: ${response.body}');
      }
    }

    // Update local records
    subscription =
        subscription.copyWith(status: 'canceled', endDate: DateTime.now());
    await Subscription.db.updateRow(session, subscription);

    userProfile = userProfile.copyWith(role: 'free', subscriptionId: null);
    await UserProfile.db.updateRow(session, userProfile);

    return true;
  }

  Future<Subscription?> getSubscriptionStatus(Session session) async {
    final userId = await getAuthenticatedUserId(session);
    return await Subscription.db.findFirstRow(session,
        where: (t) =>
            t.userId.equals(userId) & t.status.inSet({'active', 'pending'}));
  }
}
