import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/service_providers.dart';

enum SubscriptionStatus { initial, loading, success, error }

class SubscriptionState {
  final SubscriptionStatus status;
  final String? errorMessage;
  final String? lastPaymentMethodToken;

  SubscriptionState(
      {this.status = SubscriptionStatus.initial,
      this.errorMessage,
      this.lastPaymentMethodToken});
}

class SubscriptionNotifier extends StateNotifier<SubscriptionState> {
  final Ref _ref;
  SubscriptionNotifier(this._ref) : super(SubscriptionState());

  Future<void> createSubscription(String paymentMethodToken) async {
    state = SubscriptionState(
      status: SubscriptionStatus.loading,
      lastPaymentMethodToken: paymentMethodToken,
    );
    try {
      await _ref.read(subscriptionServiceProvider).createSubscription(
            gateway: 'stripe',
            paymentToken: paymentMethodToken,
          );
      state = SubscriptionState(
        status: SubscriptionStatus.success,
        lastPaymentMethodToken: paymentMethodToken,
      );
    } catch (e) {
      state = SubscriptionState(
        status: SubscriptionStatus.error,
        errorMessage: e.toString(),
        lastPaymentMethodToken: paymentMethodToken,
      );
    }
  }

  Future<void> retryLastSubscription() async {
    final token = state.lastPaymentMethodToken;
    if (token == null || token.isEmpty) return;
    await createSubscription(token);
  }
}

final subscriptionProvider =
    StateNotifierProvider.autoDispose<SubscriptionNotifier, SubscriptionState>(
        (ref) {
  return SubscriptionNotifier(ref);
});
