import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/service_providers.dart';

enum SubscriptionStatus { initial, loading, success, error }

class SubscriptionState {
  final SubscriptionStatus status;
  final String? errorMessage;

  SubscriptionState(
      {this.status = SubscriptionStatus.initial, this.errorMessage});
}

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final Ref _ref;
  SubscriptionNotifier(this._ref) : super(SubscriptionState());

  Future<void> createSubscription(String paymentMethodToken) async {
    state = SubscriptionState(status: SubscriptionStatus.loading);
    try {
      await _ref.read(subscriptionServiceProvider).createSubscription(
            gateway: 'stripe',
            paymentToken:
               paymentMethodToken, 
          );
      state = SubscriptionState(status: SubscriptionStatus.success);
    } catch (e) {
      state = SubscriptionState(
          status: SubscriptionStatus.error, errorMessage: e.toString());
    }
  }
}

final subscriptionProvider =
    StateNotifierProvider.autoDispose<SubscriptionNotifier, SubscriptionState>(
        (ref) {
  return SubscriptionNotifier(ref);
});
