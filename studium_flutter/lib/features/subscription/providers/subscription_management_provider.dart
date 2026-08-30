import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/service_providers.dart';

enum CancellationStatus { initial, loading, success, error }

class SubscriptionManagementState {
  final CancellationStatus status;
  final String? errorMessage;

  SubscriptionManagementState({
    this.status = CancellationStatus.initial,
    this.errorMessage,
  });
}

class SubscriptionManagementNotifier
    extends StateNotifier<SubscriptionManagementState> {
  final Ref _ref;
  SubscriptionManagementNotifier(this._ref)
      : super(SubscriptionManagementState());

  Future<void> cancelSubscription() async {
    state = SubscriptionManagementState(status: CancellationStatus.loading);
    try {
      final success =
          await _ref.read(subscriptionServiceProvider).cancelSubscription();
      if (success) {
        state = SubscriptionManagementState(status: CancellationStatus.success);
      } else {
        throw Exception("Cancellation was not successful on the server.");
      }
    } catch (e) {
      state = SubscriptionManagementState(
          status: CancellationStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> retryCancellation() => cancelSubscription();
}

final subscriptionManagementProvider = StateNotifierProvider.autoDispose<
    SubscriptionManagementNotifier, SubscriptionManagementState>((ref) {
  return SubscriptionManagementNotifier(ref);
});
