import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/server.dart';

import '../generated/protocol.dart';
import '../util/backend_telemetry.dart';
import '../util/configuration_secrets.dart';
import 'push_delivery_service.dart';

/// Delivers durable notifications to registered devices through Firebase Cloud
/// Messaging. Delivery is best-effort: the database notification is created
/// first and remains the source of truth if a provider is unavailable.
class PushNotificationService {
  static const _endpoint = 'https://fcm.googleapis.com/fcm/send';

  static Future<void> dispatch(
    Session session, {
    required int userId,
    required String title,
    required String message,
    String? type,
    int? relatedId,
  }) async {
    final delivery = await PushDeliveryService.enqueue(
      session,
      userId: userId,
      title: title,
      message: message,
      type: type,
      relatedId: relatedId,
    );
    final claimed = await PushDeliveryService.claim(
      session,
      delivery.id!,
      'inline-push-${delivery.id}',
    );
    if (claimed == null) return;
    try {
      await PushDeliveryService.deliver(
        session,
        claimed,
        sender: _dispatch,
      );
    } catch (error) {
      session.log('Push delivery failed for user $userId: $error');
      BackendTelemetry.event(
        session,
        'push_delivery_failed',
        outcome: 'failed',
        fields: {'userId': userId, if (type != null) 'type': type},
      );
    }
  }

  static Future<void> _dispatch(Session session, PushDelivery delivery) async {
    final serverKey = ConfigurationSecrets.read(session, 'fcmServerKey');
    if (serverKey == null ||
        serverKey.trim().isEmpty ||
        serverKey == 'replace-me') {
      throw StateError('Push provider is not configured.');
    }

    final devices = await PushDevice.db.find(
      session,
      where: (t) => t.userId.equals(delivery.userId) & t.active.equals(true),
      limit: 100,
    );
    if (devices.isEmpty) return;

    final response = await http
        .post(
          Uri.parse(_endpoint),
          headers: {
            'authorization': 'key ${serverKey.trim()}',
            'content-type': 'application/json',
          },
          body: jsonEncode({
            'registration_ids': devices.map((device) => device.token).toList(),
            'notification': {
              'title': delivery.title,
              'body': delivery.message,
            },
            'data': {
              if (delivery.type != null) 'type': delivery.type,
              if (delivery.relatedId != null) 'relatedId': delivery.relatedId,
            },
          }),
        )
        .timeout(const Duration(seconds: 10));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      session.log(
        'Push provider rejected notification for user ${delivery.userId}: '
        '${response.statusCode}',
      );
      BackendTelemetry.event(
        session,
        'push_delivery_rejected',
        outcome: 'rejected',
        fields: {
          'userId': delivery.userId,
          'statusCode': response.statusCode,
        },
      );
      return;
    }

    final payload = jsonDecode(response.body);
    if (payload is! Map<String, dynamic>) return;
    final results = payload['results'];
    if (results is! List) return;

    BackendTelemetry.event(
      session,
      'push_delivery_completed',
      fields: {'userId': delivery.userId, 'deviceCount': devices.length},
    );

    for (var index = 0;
        index < results.length && index < devices.length;
        index++) {
      final result = results[index];
      if (result is! Map<String, dynamic>) continue;
      final error = result['error'];
      if (error == 'InvalidRegistration' || error == 'NotRegistered') {
        final device = devices[index];
        device.active = false;
        device.updatedAt = DateTime.now();
        await PushDevice.db.updateRow(session, device);
      }
    }
  }
}
