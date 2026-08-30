import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/collaboration_service.dart';
import 'collaboration_provider.dart';

enum PushPermissionState { unknown, denied, enabled }

class TypingState {
  const TypingState({this.userIds = const {}});
  final Set<int> userIds;
}

class TypingController extends StateNotifier<TypingState> {
  TypingController() : super(const TypingState());
  Timer? _stopTimer;

  void setTyping(int userId, bool typing) {
    final ids = {...state.userIds};
    if (typing) {
      ids.add(userId);
      _stopTimer?.cancel();
      _stopTimer =
          Timer(const Duration(seconds: 3), () => setTyping(userId, false));
    } else {
      ids.remove(userId);
    }
    state = TypingState(userIds: ids);
  }

  @override
  void dispose() {
    _stopTimer?.cancel();
    super.dispose();
  }
}

final typingProvider = StateNotifierProvider.autoDispose
    .family<TypingController, TypingState, int>(
        (ref, roomId) => TypingController());

class ReadReceiptState {
  const ReadReceiptState({this.readMessageIds = const {}});
  final Set<int> readMessageIds;
}

class ReadReceiptController extends StateNotifier<ReadReceiptState> {
  ReadReceiptController([this._service]) : super(const ReadReceiptState());
  final CollaborationService? _service;

  void markRead(int messageId) => state = ReadReceiptState(
        readMessageIds: {...state.readMessageIds, messageId},
      );

  Future<void> markReadRemotely(int messageId) async {
    markRead(messageId);
    await _service?.markConversationRead(_conversationId, messageId);
  }

  late final int _conversationId;

  void setConversationId(int conversationId) =>
      _conversationId = conversationId;
}

final readReceiptProvider = StateNotifierProvider.autoDispose
    .family<ReadReceiptController, ReadReceiptState, int>(
        (ref, conversationId) {
  final controller =
      ReadReceiptController(ref.read(collaborationServiceProvider));
  controller.setConversationId(conversationId);
  return controller;
});

class PushNotificationController extends StateNotifier<PushPermissionState> {
  PushNotificationController() : super(PushPermissionState.unknown);
  void setPermission(PushPermissionState value) => state = value;
}

final pushNotificationProvider = StateNotifierProvider.autoDispose
    .family<PushNotificationController, PushPermissionState, String>(
        (ref, scope) => PushNotificationController());

class WhiteboardState {
  const WhiteboardState({this.strokes = const []});
  final List<List<OffsetPoint>> strokes;
}

class OffsetPoint {
  const OffsetPoint(this.x, this.y);
  final double x;
  final double y;
}

class WhiteboardController extends StateNotifier<WhiteboardState> {
  WhiteboardController() : super(const WhiteboardState());
  void addStroke(List<OffsetPoint> stroke) {
    if (stroke.isEmpty) return;
    state =
        WhiteboardState(strokes: [...state.strokes, List.unmodifiable(stroke)]);
  }

  void undo() {
    if (state.strokes.isEmpty) return;
    state = WhiteboardState(
        strokes: state.strokes.sublist(0, state.strokes.length - 1));
  }

  void clear() => state = const WhiteboardState();
}

final whiteboardProvider = StateNotifierProvider.autoDispose
    .family<WhiteboardController, WhiteboardState, int>(
        (ref, roomId) => WhiteboardController());
