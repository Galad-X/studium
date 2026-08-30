import 'package:flutter_test/flutter_test.dart';
import 'package:studium_flutter/features/collaboration/providers/collaboration_entitlements_provider.dart';

void main() {
  test('free and premium collaboration limits are explicit', () {
    expect(
      const CollaborationEntitlements(isPremium: false).dailyRoomAiLimit,
      5,
    );
    expect(
      const CollaborationEntitlements(isPremium: true).dailyRoomAiLimit,
      100,
    );
  });

  test('room AI usage resets by day and stops at the configured limit', () {
    final controller = CollaborationUsageController();
    final dayOne = DateTime(2026, 8, 30);

    expect(controller.consumeRoomAiRequest(limit: 2, now: dayOne), isTrue);
    expect(controller.consumeRoomAiRequest(limit: 2, now: dayOne), isTrue);
    expect(controller.consumeRoomAiRequest(limit: 2, now: dayOne), isFalse);
    expect(
      controller.consumeRoomAiRequest(
        limit: 2,
        now: dayOne.add(const Duration(days: 1)),
      ),
      isTrue,
    );

    controller.dispose();
  });
}
