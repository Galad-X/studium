// NOTIFICATION ENDPOINT
import 'package:serverpod/server.dart';
import '../generated/protocol.dart';

class NotificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<Notification>> getNotifications(
    Session session, {
    bool isRead = false,
    int page = 0,
    int limit = 50,
  }) async {
    final authInfo = session.authenticated;
    final userId = int.tryParse(authInfo?.userIdentifier ?? '');
    if (userId == null) throw Exception('User not authenticated');

    final safeLimit = limit < 1 ? 1 : (limit > 100 ? 100 : limit);
    return await Notification.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isRead.equals(isRead),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<bool> markNotificationRead(Session session, int notificationId) async {
    final authInfo = session.authenticated;
    final userId = int.tryParse(authInfo?.userIdentifier ?? '');
    if (userId == null) throw Exception('User not authenticated');

    final notification =
        await Notification.db.findById(session, notificationId);
    if (notification == null || notification.userId != userId) {
      throw Exception('Notification not found or unauthorized');
    }

    await Notification.db
        .updateRow(session, notification.copyWith(isRead: true));
    return true;
  }

  Future<int> markAllNotificationsRead(Session session) async {
    final authInfo = session.authenticated;
    final userId = int.tryParse(authInfo?.userIdentifier ?? '');
    if (userId == null) throw Exception('User not authenticated');
    final unread = await Notification.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.isRead.equals(false),
      limit: 500,
    );
    for (final notification in unread) {
      notification.isRead = true;
      await Notification.db.updateRow(session, notification);
    }
    return unread.length;
  }

  Future<PushDevice> registerPushDevice(
    Session session,
    String token,
    String platform,
  ) async {
    final authInfo = session.authenticated;
    final userId = int.tryParse(authInfo?.userIdentifier ?? '');
    if (userId == null) throw Exception('User not authenticated');
    final normalizedToken = token.trim();
    if (normalizedToken.length < 20 || normalizedToken.length > 4096) {
      throw Exception('Push token is invalid.');
    }
    if (!{'android', 'ios', 'web', 'windows', 'macos', 'linux'}
        .contains(platform)) {
      throw Exception('Unsupported push platform.');
    }
    final existing = await PushDevice.db.findFirstRow(
      session,
      where: (t) => t.token.equals(normalizedToken),
    );
    final now = DateTime.now();
    if (existing != null) {
      if (existing.userId != userId) {
        throw Exception('Push token belongs to another account.');
      }
      existing.platform = platform;
      existing.active = true;
      existing.updatedAt = now;
      return PushDevice.db.updateRow(session, existing);
    }
    return PushDevice.db.insertRow(
      session,
      PushDevice(
        userId: userId,
        token: normalizedToken,
        platform: platform,
        active: true,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<bool> unregisterPushDevice(Session session, String token) async {
    final authInfo = session.authenticated;
    final userId = int.tryParse(authInfo?.userIdentifier ?? '');
    if (userId == null) throw Exception('User not authenticated');
    final device = await PushDevice.db.findFirstRow(
      session,
      where: (t) => t.token.equals(token.trim()) & t.userId.equals(userId),
    );
    if (device == null) return false;
    device.active = false;
    device.updatedAt = DateTime.now();
    await PushDevice.db.updateRow(session, device);
    return true;
  }
}
