import 'package:flutter_test/flutter_test.dart';
import 'package:studium_flutter/core/routing/notification_deep_link.dart';

void main() {
  test('notification types resolve only to supported in-app destinations', () {
    expect(notificationDeepLink('room_post', 12), '/collaboration/rooms/12');
    expect(notificationDeepLink('challenge_team', 3),
        '/collaboration/challenges/3');
    expect(notificationDeepLink('institution_membership', 1),
        '/collaboration/institutions');
    expect(notificationDeepLink('moderation_appeal', 1), '/moderation/appeals');
    expect(notificationDeepLink('unknown', 1), isNull);
    expect(notificationDeepLink('room_chat', null), isNull);
  });
}
