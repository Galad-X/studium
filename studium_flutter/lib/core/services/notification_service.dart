import 'package:studium_client/studium_client.dart';

class NotificationService {
  final Client _client;
  NotificationService(this._client);

  Future<List<Notification>> getNotifications() async {
    try {
      // Fetch both read and unread for the list screen
      return await _client.notification.getNotifications(isRead: false);
    } catch (e) {
      throw Exception('Failed to load notifications.');
    }
  }

  Future<bool> markAsRead(int notificationId) async {
    try {
      return await _client.notification.markNotificationRead(notificationId);
    } catch (e) {
      return false;
    }
  }
}
