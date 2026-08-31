import 'package:flutter_test/flutter_test.dart';
import 'package:studium_client/studium_client.dart';
import 'package:studium_flutter/features/collaboration/providers/collaboration_interaction_providers.dart';
import 'package:studium_flutter/features/collaboration/services/collaboration_service.dart';

void main() {
  test('typing state and whiteboard editing transitions are deterministic', () {
    final typing = TypingController();
    addTearDown(typing.dispose);
    typing.setTyping(4, true);
    expect(typing.state.userIds, contains(4));
    typing.setTyping(4, false);
    expect(typing.state.userIds, isEmpty);

    final whiteboard = WhiteboardController(
      CollaborationService(Client('http://127.0.0.1:1')),
      1,
    );
    addTearDown(whiteboard.dispose);
    whiteboard.addStroke([const OffsetPoint(1, 2), const OffsetPoint(3, 4)]);
    expect(whiteboard.state.strokes, hasLength(1));
    whiteboard.undo();
    expect(whiteboard.state.strokes, isEmpty);
    whiteboard.clear();
    expect(whiteboard.state.strokes, isEmpty);
  });
}
