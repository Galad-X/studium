import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/backend_telemetry.dart';
import '../util/configuration_secrets.dart';
import '../services/payment_refund_service.dart';
import '../services/payment_settlement_service.dart';

class BillingWebhookEndpoint extends Endpoint {
  @override
  bool get requireLogin => false;

  Future<bool> handleWebhook(
    Session session,
    String gateway,
    String eventId,
    String eventType,
    String payload,
    String signature,
  ) async {
    if (!{'stripe', 'paystack'}.contains(gateway) ||
        eventId.trim().isEmpty ||
        eventType.trim().isEmpty ||
        payload.length > 1000000 ||
        !_isValidSignature(session, gateway, payload, signature)) {
      throw Exception('Invalid webhook request.');
    }
    final event = await session.db.transaction((transaction) async {
      final existing = await PaymentWebhookEvent.db.findFirstRow(
        session,
        where: (t) =>
            t.gateway.equals(gateway) & t.eventId.equals(eventId.trim()),
        transaction: transaction,
      );
      if (existing != null) return existing;
      return PaymentWebhookEvent.db.insertRow(
        session,
        PaymentWebhookEvent(
          gateway: gateway,
          eventId: eventId.trim(),
          eventType: eventType.trim(),
          payload: payload,
          status: 'received',
          receivedAt: DateTime.now(),
        ),
        transaction: transaction,
      );
    });
    if (event.status == 'processed') return true;
    try {
      final data = jsonDecode(payload) as Map<String, dynamic>;
      final subscriptionId = _subscriptionId(data);
      if (subscriptionId != null) {
        final subscription = await Subscription.db.findFirstRow(
          session,
          where: (t) => t.subscriptionId.equals(subscriptionId),
        );
        if (subscription != null) {
          final isRefund = eventType.contains('refund');
          final isChargeback = eventType.contains('chargeback');
          final isCancelled = eventType.contains('cancel') ||
              eventType.contains('disabled') ||
              eventType.contains('deleted') ||
              isChargeback;
          final isFailed =
              eventType.contains('failed') || eventType.contains('past_due');
          final existingTransaction = await PaymentTransaction.db.findFirstRow(
            session,
            where: (t) =>
                t.gateway.equals(gateway) &
                t.transactionId.equals(event.eventId),
          );
          final chargedAmount = _amount(data);
          final chargedCurrency = _currency(data);
          final settlement = PaymentSettlementService.fromPayload(
            data,
            chargedAmount: chargedAmount,
            chargedCurrency: chargedCurrency,
          );
          var refundRevokesEntitlement = isChargeback;
          if (existingTransaction == null) {
            var transactionStatus = isRefund
                ? 'refunded'
                : isCancelled
                    ? 'canceled'
                    : isFailed
                        ? 'failed'
                        : 'success';
            if (isRefund) {
              final priorTransactions = await PaymentTransaction.db.find(
                session,
                where: (t) => t.subscriptionId.equals(subscription.id!),
              );
              final chargedAmount = priorTransactions
                  .where((item) => item.status == 'success')
                  .fold<double>(0, (total, item) => total + item.amount);
              final refundedAmount = priorTransactions
                  .where((item) =>
                      item.status == 'partial_refunded' ||
                      item.status == 'refunded')
                  .fold<double>(0, (total, item) => total + item.amount);
              transactionStatus = PaymentRefundService.transactionStatus(
                chargedAmount: chargedAmount,
                refundedAmount: refundedAmount,
                refundAmount: _amount(data),
              );
              refundRevokesEntitlement =
                  PaymentRefundService.revokesEntitlement(transactionStatus);
            }
            await PaymentTransaction.db.insertRow(
              session,
              PaymentTransaction(
                subscriptionId: subscription.id!,
                userId: subscription.userId,
                amount: chargedAmount,
                currency: chargedCurrency,
                settlementAmount: settlement.amount,
                settlementCurrency: settlement.currency,
                exchangeRate: settlement.exchangeRate,
                settlementSource: settlement.source,
                status: transactionStatus,
                gateway: gateway,
                transactionId: event.eventId,
                createdAt: DateTime.now(),
              ),
            );
          }
          final shouldCancel = isCancelled || refundRevokesEntitlement;
          subscription.status = shouldCancel
              ? 'canceled'
              : isFailed
                  ? 'past_due'
                  : 'active';
          if (shouldCancel) subscription.endDate = DateTime.now();
          await Subscription.db.updateRow(session, subscription);
          final profile = await UserProfile.db.findFirstRow(
            session,
            where: (t) => t.userId.equals(subscription.userId),
          );
          if (profile != null && shouldCancel) {
            await UserProfile.db.updateRow(
              session,
              profile.copyWith(role: 'free', subscriptionId: null),
            );
          } else if (profile != null && !isFailed) {
            await UserProfile.db.updateRow(
              session,
              profile.copyWith(
                role: 'premium',
                subscriptionId: subscription.subscriptionId,
              ),
            );
          }
        }
      }
      event.status = 'processed';
      event.errorMessage = null;
      event.processedAt = DateTime.now();
      await PaymentWebhookEvent.db.updateRow(session, event);
      BackendTelemetry.event(
        session,
        'billing_webhook_processed',
        fields: {'gateway': gateway, 'eventType': eventType},
      );
      return true;
    } catch (error) {
      event.status = 'failed';
      event.errorMessage = error.toString().substring(
            0,
            error.toString().length.clamp(0, 2000),
          );
      event.processedAt = DateTime.now();
      await PaymentWebhookEvent.db.updateRow(session, event);
      BackendTelemetry.event(
        session,
        'billing_webhook_failed',
        outcome: 'failed',
        fields: {'gateway': gateway, 'eventType': eventType},
      );
      rethrow;
    }
  }

  double _amount(Map<String, dynamic> data) {
    final raw = data['amount'] ??
        (data['data'] as Map<String, dynamic>?)?['amount'] ??
        (data['data'] as Map<String, dynamic>?)?['amount_total'];
    final value = raw is num ? raw.toDouble() : double.tryParse('$raw');
    return value == null ? 0 : value / 100;
  }

  String? _currency(Map<String, dynamic> data) {
    final raw = data['currency'] ??
        (data['data'] as Map<String, dynamic>?)?['currency'] ??
        (data['data'] as Map<String, dynamic>?)?['currency_code'];
    final value = raw?.toString().trim().toUpperCase();
    if (value == null || !RegExp(r'^[A-Z]{3}$').hasMatch(value)) return null;
    return value;
  }

  bool _isValidSignature(
    Session session,
    String gateway,
    String payload,
    String signature,
  ) {
    final secretName =
        gateway == 'stripe' ? 'stripeWebhookSecret' : 'paystackWebhookSecret';
    final secret = ConfigurationSecrets.read(session, secretName);
    if (secret == null || secret.isEmpty) return false;
    if (gateway == 'paystack') {
      final expected = Hmac(sha512, utf8.encode(secret))
          .convert(utf8.encode(payload))
          .toString();
      return _constantTimeEquals(expected, signature.trim());
    }
    final parts = {
      for (final part in signature.split(','))
        if (part.contains('='))
          part.substring(0, part.indexOf('=')):
              part.substring(part.indexOf('=') + 1),
    };
    final timestamp = int.tryParse(parts['t'] ?? '');
    final timestampSignature = parts['v1'];
    if (timestamp == null || timestampSignature == null) return false;
    if (DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000 - timestamp >
        300) {
      return false;
    }
    final signedPayload = '$timestamp.$payload';
    final expected = Hmac(sha256, utf8.encode(secret))
        .convert(utf8.encode(signedPayload))
        .toString();
    return _constantTimeEquals(expected, timestampSignature);
  }

  bool _constantTimeEquals(String left, String right) {
    final a = Uint8List.fromList(utf8.encode(left));
    final b = Uint8List.fromList(utf8.encode(right));
    var difference = a.length ^ b.length;
    final length = a.length < b.length ? a.length : b.length;
    for (var i = 0; i < length; i++) {
      difference |= a[i] ^ b[i];
    }
    return difference == 0;
  }

  String? _subscriptionId(Map<String, dynamic> data) {
    final candidates = [
      data['subscriptionId'],
      data['subscription_code'],
      (data['data'] as Map<String, dynamic>?)?['subscription_code'],
      (data['data'] as Map<String, dynamic>?)?['subscription_id'],
      (data['object'] as Map<String, dynamic>?)?['id'],
    ];
    return candidates
        .whereType<String>()
        .firstWhere(
          (value) => value.isNotEmpty,
          orElse: () => '',
        )
        .ifEmpty;
  }
}

extension on String {
  String? get ifEmpty => isEmpty ? null : this;
}
