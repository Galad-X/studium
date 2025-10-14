// lib/src/features/subscription/services/subscription_service.dart
import 'package:flutter/foundation.dart';
import 'package:studium_client/studium_client.dart';

/// A service to interact with the backend subscription endpoints.
class SubscriptionService {
  final Client _client;
  SubscriptionService(this._client);

  /// Calls the backend to create a new subscription.
  Future<Subscription> createSubscription({
    required String gateway,
    required String paymentToken,
  }) async {
    try {
      return await _client.subscription
          .createSubscription(gateway, paymentToken);
    } catch (e) {
      debugPrint('Subscription creation failed: $e');
      // Re-throw the exception to be handled by the Notifier.
      // This allows the UI to show a specific error message.
      rethrow;
    }
  }

  /// Calls the backend to cancel the user's active subscription.
  Future<bool> cancelSubscription() async {
    try {
      return await _client.subscription.cancelSubscription();
    } catch (e) {
      debugPrint('Subscription cancellation failed: $e');
      rethrow;
    }
  }
}
