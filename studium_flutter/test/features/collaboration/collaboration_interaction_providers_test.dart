import 'package:flutter_test/flutter_test.dart';
import 'package:studium_client/studium_client.dart';
import 'package:studium_flutter/features/collaboration/providers/collaboration_interaction_providers.dart';
import 'package:studium_flutter/features/collaboration/services/collaboration_service.dart';

void main() {
  test('typing state can start and stop', () {
    final controller = TypingController();
    controller.setTyping(7, true);
    expect(controller.state.userIds, contains(7));
    controller.setTyping(7, false);
    expect(controller.state.userIds, isNot(contains(7)));
    controller.dispose();
  });

  test('read receipts accumulate message ids', () {
    final controller = ReadReceiptController();
    controller.markRead(11);
    controller.markRead(12);
    expect(controller.state.readMessageIds, {11, 12});
    controller.dispose();
  });

  test('whiteboard supports stroke, undo, and clear', () {
    final controller = WhiteboardController(
      CollaborationService(Client('http://127.0.0.1:1')),
      1,
    );
    controller.addStroke(const [OffsetPoint(1, 2), OffsetPoint(3, 4)]);
    expect(controller.state.strokes, hasLength(1));
    controller.undo();
    expect(controller.state.strokes, isEmpty);
    controller.addStroke(const [OffsetPoint(1, 2)]);
    controller.clear();
    expect(controller.state.strokes, isEmpty);
    controller.dispose();
  });
}
