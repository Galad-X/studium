import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../profile/providers/profile_provider.dart';

/// Client-side feature information used to explain limits before a request is
/// sent. The backend remains authoritative for entitlement enforcement.
class CollaborationEntitlements {
  const CollaborationEntitlements({required this.isPremium});

  final bool isPremium;

  int get dailyRoomAiLimit => isPremium ? 100 : 5;
  bool get hasAdvancedKnowledgeBase => isPremium;
}

final collaborationEntitlementsProvider =
    FutureProvider.autoDispose<CollaborationEntitlements>((ref) async {
  final profile = await ref.watch(profileProvider.future);
  return CollaborationEntitlements(
      isPremium: profile.profile.role == 'premium');
});

class CollaborationUsageState {
  const CollaborationUsageState({this.dayKey = '', this.roomAiRequests = 0});

  final String dayKey;
  final int roomAiRequests;

  CollaborationUsageState copyWith({String? dayKey, int? roomAiRequests}) =>
      CollaborationUsageState(
        dayKey: dayKey ?? this.dayKey,
        roomAiRequests: roomAiRequests ?? this.roomAiRequests,
      );
}

class CollaborationUsageController
    extends StateNotifier<CollaborationUsageState> {
  CollaborationUsageController() : super(const CollaborationUsageState());

  bool consumeRoomAiRequest({required int limit, DateTime? now}) {
    final date = now ?? DateTime.now();
    final key = '${date.year}-${date.month}-${date.day}';
    if (state.dayKey != key) {
      state = CollaborationUsageState(dayKey: key, roomAiRequests: 1);
      return true;
    }
    if (state.roomAiRequests >= limit) return false;
    state = state.copyWith(roomAiRequests: state.roomAiRequests + 1);
    return true;
  }
}

final collaborationUsageProvider = StateNotifierProvider.autoDispose<
    CollaborationUsageController, CollaborationUsageState>(
  (ref) => CollaborationUsageController(),
);
