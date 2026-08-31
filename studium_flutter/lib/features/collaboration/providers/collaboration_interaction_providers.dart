import 'dart:async';
import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/providers/service_providers.dart';
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
  PushNotificationController(this._service)
      : super(PushPermissionState.unknown);

  final NotificationService _service;
  String? _registeredToken;

  void setPermission(PushPermissionState value) => state = value;

  /// Called by the platform notification adapter after it obtains a token.
  /// FCM/APNs setup can plug into this stable backend registration boundary.
  Future<void> registerToken(String token, String platform) async {
    final normalized = token.trim();
    if (normalized.isEmpty) {
      state = PushPermissionState.denied;
      return;
    }
    await _service.registerPushDevice(normalized, platform);
    _registeredToken = normalized;
    state = PushPermissionState.enabled;
  }

  Future<void> unregisterToken() async {
    final token = _registeredToken;
    if (token != null) await _service.unregisterPushDevice(token);
    _registeredToken = null;
    state = PushPermissionState.denied;
  }
}

final pushNotificationProvider = StateNotifierProvider.autoDispose
    .family<PushNotificationController, PushPermissionState, String>(
        (ref, scope) =>
            PushNotificationController(ref.read(notificationServiceProvider)));

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
  WhiteboardController(this._service, this.roomId)
      : super(const WhiteboardState());
  final CollaborationService _service;
  final int roomId;
  int _version = 0;

  Future<void> load() async {
    final remote = await _service.getRoomWhiteboard(roomId);
    if (remote == null) return;
    final decoded = jsonDecode(remote.strokesJson) as List<dynamic>;
    _version = remote.version;
    state = WhiteboardState(
      strokes: decoded
          .map((stroke) => (stroke as List<dynamic>)
              .map((point) => OffsetPoint(
                    ((point as Map<String, dynamic>)['x'] as num).toDouble(),
                    (point['y'] as num).toDouble(),
                  ))
              .toList())
          .toList(),
    );
  }

  Future<void> persist() async {
    final payload = jsonEncode(state.strokes
        .map((stroke) => stroke.map((point) => {'x': point.x, 'y': point.y}))
        .toList());
    final saved = await _service.saveRoomWhiteboard(roomId, _version, payload);
    _version = saved.version;
  }

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
    .family<WhiteboardController, WhiteboardState, int>((ref, roomId) {
  final controller = WhiteboardController(
    ref.read(collaborationServiceProvider),
    roomId,
  );
  unawaited(controller.load());
  return controller;
});
