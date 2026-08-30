import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/backend_telemetry.dart';

class PushDeliveryService {
  static Future<PushDelivery> enqueue(
    Session session, {
    required int userId,
    required String title,
    required String message,
    String? type,
    int? relatedId,
    int maxAttempts = 3,
  }) {
    if (userId < 1 ||
        title.trim().isEmpty ||
        message.trim().isEmpty ||
        maxAttempts < 1) {
      throw ArgumentError('Invalid push delivery data.');
    }
    final now = DateTime.now().toUtc();
    return PushDelivery.db.insertRow(
      session,
      PushDelivery(
        userId: userId,
        title: title.trim(),
        message: message.trim(),
        type: type?.trim(),
        relatedId: relatedId,
        status: 'pending',
        attempts: 0,
        maxAttempts: maxAttempts,
        availableAt: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  static Future<PushDelivery?> claim(
    Session session,
    int deliveryId,
    String lockToken,
  ) async {
    if (lockToken.trim().isEmpty) return null;
    return session.db.transaction((transaction) async {
      final delivery = await PushDelivery.db.findById(
        session,
        deliveryId,
        transaction: transaction,
      );
      final now = DateTime.now().toUtc();
      if (delivery == null ||
          delivery.status != 'pending' ||
          delivery.availableAt.isAfter(now) ||
          delivery.attempts >= delivery.maxAttempts) {
        return null;
      }
      delivery.status = 'processing';
      delivery.attempts += 1;
      delivery.lockedAt = now;
      delivery.lockToken = lockToken;
      delivery.updatedAt = now;
      BackendTelemetry.event(
        session,
        'push_delivery_claimed',
        fields: {'deliveryId': deliveryId, 'attempt': delivery.attempts},
      );
      return PushDelivery.db.updateRow(
        session,
        delivery,
        transaction: transaction,
      );
    });
  }

  static Future<PushDelivery> deliver(
    Session session,
    PushDelivery delivery, {
    required Future<void> Function(Session session, PushDelivery delivery)
        sender,
  }) async {
    try {
      await sender(session, delivery);
      delivery.status = 'sent';
      delivery.sentAt = DateTime.now().toUtc();
      delivery.lockedAt = null;
      delivery.lockToken = null;
      delivery.lastError = null;
      delivery.updatedAt = DateTime.now().toUtc();
      BackendTelemetry.event(
        session,
        'push_delivery_sent',
        fields: {'deliveryId': delivery.id},
      );
    } catch (error) {
      return fail(session, delivery, error);
    }
    return PushDelivery.db.updateRow(session, delivery);
  }

  static Future<PushDelivery> fail(
    Session session,
    PushDelivery delivery,
    Object error,
  ) async {
    final message = error.toString();
    delivery.status =
        delivery.attempts >= delivery.maxAttempts ? 'dead_letter' : 'pending';
    delivery.availableAt = DateTime.now().toUtc().add(
          Duration(seconds: 30 * delivery.attempts),
        );
    delivery.lockedAt = null;
    delivery.lockToken = null;
    delivery.lastError = message.substring(0, message.length.clamp(0, 2000));
    delivery.updatedAt = DateTime.now().toUtc();
    BackendTelemetry.event(
      session,
      'push_delivery_failed',
      outcome: delivery.status,
      fields: {'deliveryId': delivery.id},
    );
    return PushDelivery.db.updateRow(session, delivery);
  }

  static Future<int> recoverStale(
    Session session, {
    Duration staleAfter = const Duration(minutes: 15),
    int limit = 100,
  }) async {
    if (staleAfter.isNegative || limit < 1) {
      throw ArgumentError('Invalid stale-push recovery configuration.');
    }
    final cutoff = DateTime.now().toUtc().subtract(staleAfter);
    final deliveries = await PushDelivery.db.find(
      session,
      where: (t) => t.status.equals('processing'),
      orderBy: (t) => t.lockedAt,
      limit: limit.clamp(1, 500),
    );
    var recovered = 0;
    for (final delivery in deliveries) {
      final lockedAt = delivery.lockedAt;
      if (lockedAt == null || lockedAt.isAfter(cutoff)) continue;
      delivery.status =
          delivery.attempts >= delivery.maxAttempts ? 'dead_letter' : 'pending';
      delivery.availableAt = DateTime.now().toUtc();
      delivery.lockedAt = null;
      delivery.lockToken = null;
      delivery.updatedAt = DateTime.now().toUtc();
      await PushDelivery.db.updateRow(session, delivery);
      recovered++;
    }
    BackendTelemetry.event(
      session,
      'push_delivery_stale_recovered',
      fields: {'count': recovered},
    );
    return recovered;
  }
}
