import 'package:flutter/foundation.dart';
import 'package:studium_client/studium_client.dart';

class PaymentService {
  final Client _client;
  PaymentService(this._client);

  Future<Subscription> createSubscription({
    required String gateway,
    required String paymentToken,
  }) async {
    try {
      return await _client.subscription
          .createSubscription(gateway, paymentToken);
    } catch (e) {
      debugPrint('Subscription creation failed: $e');
      throw Exception(
          'Failed to process subscription. Please check your payment details or try again later.');
    }
  }

  Future<bool> cancelSubscription() async {
    try {
      // This calls the endpoint we created earlier.
      return await _client.subscription.cancelSubscription();
    } catch (e) {
      debugPrint('Subscription cancellation failed: $e');
      throw Exception(
          'Failed to cancel your subscription. Please try again or contact support.');
    }
  }
}
