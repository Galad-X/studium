import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/providers/service_providers.dart';

// This provider will fetch and manage the list of notifications
final notificationProvider =
    FutureProvider.autoDispose<List<Notification>>((ref) {
  return ref.watch(notificationServiceProvider).getNotifications();
});

// A separate provider to just get the COUNT of unread notifications for the badge
final unreadNotificationCountProvider = Provider<AsyncValue<int>>((ref) {
  // We watch the main provider and transform its result into a count
  return ref.watch(notificationProvider).whenData((notifications) {
    return notifications.where((n) => !n.isRead).length;
  });
});
