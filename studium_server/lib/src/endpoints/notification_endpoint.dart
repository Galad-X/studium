// NOTIFICATION ENDPOINT
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class NotificationEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<List<Notification>> getNotifications(Session session,
      {bool isRead = false}) async {
   final authInfo = await session.authenticated;
    final userId = authInfo?.userId;
    if (authInfo?.userId == null) throw Exception('User not authenticated');

    return await Notification.db.find(session,
        where: (t) => t.userId.equals(userId) & t.isRead.equals(isRead));
  }

  Future<bool> markNotificationRead(Session session, int notificationId) async {
    final authInfo = await session.authenticated;
    final userId = authInfo?.userId;
    if (authInfo?.userId == null) throw Exception('User not authenticated');

    final notification =
        await Notification.db.findById(session, notificationId);
    if (notification == null || notification.userId != userId) {
      throw Exception('Notification not found or unauthorized');
    }

    await Notification.db
        .updateRow(session, notification.copyWith(isRead: true));
    return true;
  }
}
