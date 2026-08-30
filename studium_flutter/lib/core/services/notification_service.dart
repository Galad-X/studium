import 'package:studium_client/studium_client.dart';

class NotificationService {
  final Client _client;
  NotificationService(this._client);

  Future<List<Notification>> getNotifications(
      {int page = 0, int limit = 50}) async {
    try {
      // Fetch both read and unread for the list screen
      return await _client.notification.getNotifications(
        isRead: false,
        page: page,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Failed to load notifications.');
    }
  }

  Future<int> markAllNotificationsRead() async {
    return await _client.notification.markAllNotificationsRead();
  }

  Future<PushDevice> registerPushDevice(String token, String platform) =>
      _client.notification.registerPushDevice(token, platform);

  Future<bool> unregisterPushDevice(String token) =>
      _client.notification.unregisterPushDevice(token);

  Future<bool> markAsRead(int notificationId) async {
    try {
      return await _client.notification.markNotificationRead(notificationId);
    } catch (e) {
      return false;
    }
  }
}
