import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/backend_telemetry.dart';
import '../util/email_sender.dart';

class EmailDeliveryService {
  static Future<EmailDelivery> enqueue(
    Session session, {
    required String recipient,
    required String subject,
    required String htmlBody,
    String? dedupeKey,
    int maxAttempts = 3,
  }) async {
    final normalizedRecipient = recipient.trim();
    final normalizedSubject = subject.trim();
    if (normalizedRecipient.isEmpty ||
        normalizedSubject.isEmpty ||
        htmlBody.trim().isEmpty ||
        maxAttempts < 1) {
      throw ArgumentError('Invalid email delivery data.');
    }
    final normalizedKey = dedupeKey?.trim();
    if (normalizedKey != null && normalizedKey.isEmpty) {
      throw ArgumentError('Email dedupe key cannot be empty.');
    }
    if (normalizedKey != null) {
      final existing = await EmailDelivery.db.findFirstRow(
        session,
        where: (t) => t.dedupeKey.equals(normalizedKey),
      );
      if (existing != null) return existing;
    }
    final now = DateTime.now().toUtc();
    return EmailDelivery.db.insertRow(
      session,
      EmailDelivery(
        recipient: normalizedRecipient,
        subject: normalizedSubject,
        htmlBody: htmlBody,
        dedupeKey: normalizedKey,
        status: 'pending',
        attempts: 0,
        maxAttempts: maxAttempts,
        availableAt: now,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  static Future<EmailDelivery?> claim(
    Session session,
    int deliveryId,
    String lockToken,
  ) async {
    if (lockToken.trim().isEmpty) return null;
    return session.db.transaction((transaction) async {
      final delivery = await EmailDelivery.db.findById(
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
        'email_delivery_claimed',
        fields: {'deliveryId': deliveryId, 'attempt': delivery.attempts},
      );
      return EmailDelivery.db.updateRow(
        session,
        delivery,
        transaction: transaction,
      );
    });
  }

  static Future<EmailDelivery> deliver(
    Session session,
    EmailDelivery delivery, {
    Future<void> Function(Session session, EmailDelivery delivery)? sender,
  }) async {
    try {
      await (sender ?? _send)(session, delivery);
      delivery.status = 'sent';
      delivery.sentAt = DateTime.now().toUtc();
      delivery.lockedAt = null;
      delivery.lockToken = null;
      delivery.lastError = null;
      delivery.updatedAt = DateTime.now().toUtc();
      BackendTelemetry.event(
        session,
        'email_delivery_sent',
        fields: {'deliveryId': delivery.id},
      );
    } catch (error) {
      return fail(session, delivery, error);
    }
    return EmailDelivery.db.updateRow(session, delivery);
  }

  static Future<void> _send(
    Session session,
    EmailDelivery delivery,
  ) {
    return EmailSender.sendEmail(
      session: session,
      to: delivery.recipient,
      subject: delivery.subject,
      htmlBody: delivery.htmlBody,
    );
  }

  static Future<EmailDelivery> fail(
    Session session,
    EmailDelivery delivery,
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
      'email_delivery_failed',
      outcome: delivery.status,
      fields: {'deliveryId': delivery.id},
    );
    return EmailDelivery.db.updateRow(session, delivery);
  }

  static Future<int> recoverStale(
    Session session, {
    Duration staleAfter = const Duration(minutes: 15),
    int limit = 100,
  }) async {
    if (staleAfter.isNegative || limit < 1) {
      throw ArgumentError('Invalid stale-email recovery configuration.');
    }
    final cutoff = DateTime.now().toUtc().subtract(staleAfter);
    final deliveries = await EmailDelivery.db.find(
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
      await EmailDelivery.db.updateRow(session, delivery);
      recovered++;
    }
    BackendTelemetry.event(
      session,
      'email_delivery_stale_recovered',
      fields: {'count': recovered},
    );
    return recovered;
  }
}
