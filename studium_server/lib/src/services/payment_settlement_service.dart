/// Normalizes optional gateway settlement data while preserving its provenance.
/// Gateways may report a settlement amount in a different currency from the
/// customer charge; the server never invents an exchange rate.
class PaymentSettlementService {
  static PaymentSettlementData fromPayload(
    Map<String, dynamic> payload, {
    required double chargedAmount,
    required String? chargedCurrency,
  }) {
    final rawSettlement = payload['settlement'] ??
        (payload['data'] as Map<String, dynamic>?)?['settlement'];
    final settlement =
        rawSettlement is Map<String, dynamic> ? rawSettlement : payload;
    final rawAmount = settlement['settlementAmount'] ??
        settlement['settlement_amount'] ??
        settlement['settledAmount'] ??
        settlement['settled_amount'] ??
        (rawSettlement is Map<String, dynamic> ? settlement['amount'] : null);
    final rawCurrency = settlement['settlementCurrency'] ??
        settlement['settlement_currency'] ??
        settlement['settledCurrency'] ??
        settlement['settled_currency'] ??
        (rawSettlement is Map<String, dynamic> ? settlement['currency'] : null);
    final rawRate = settlement['exchangeRate'] ??
        settlement['exchange_rate'] ??
        settlement['fxRate'] ??
        settlement['fx_rate'];
    final settlementCurrency = _currency(rawCurrency);
    // Payment gateways report monetary amounts in minor units (for example,
    // cents or kobo), while Studium stores major units in the ledger.
    final rawSettlementAmount = _number(rawAmount);
    final settlementAmount =
        rawSettlementAmount == null ? null : rawSettlementAmount / 100;
    final exchangeRate = _number(rawRate);
    if (settlementAmount == null &&
        settlementCurrency == null &&
        exchangeRate == null) {
      return const PaymentSettlementData();
    }
    if (settlementAmount == null ||
        settlementCurrency == null ||
        settlementAmount < 0) {
      throw FormatException('Settlement amount and currency are invalid.');
    }
    final normalizedRate =
        exchangeRate ?? (settlementCurrency == chargedCurrency ? 1 : null);
    if (normalizedRate == null || normalizedRate <= 0) {
      throw FormatException(
        'An exchange rate is required when settlement currency differs.',
      );
    }
    final expectedAmount = chargedAmount * normalizedRate;
    final tolerance = expectedAmount.abs() * 0.02 + 0.01;
    if ((settlementAmount - expectedAmount).abs() > tolerance) {
      throw FormatException('Settlement amount does not match exchange rate.');
    }
    return PaymentSettlementData(
      amount: settlementAmount,
      currency: settlementCurrency,
      exchangeRate: normalizedRate,
      source: rawSettlement is Map<String, dynamic>
          ? 'gateway.settlement'
          : 'gateway.payload',
    );
  }

  static double? _number(dynamic value) {
    if (value is num) return value.toDouble();
    return value == null ? null : double.tryParse(value.toString());
  }

  static String? _currency(dynamic value) {
    final normalized = value?.toString().trim().toUpperCase();
    return normalized != null && RegExp(r'^[A-Z]{3}$').hasMatch(normalized)
        ? normalized
        : null;
  }
}

class PaymentSettlementData {
  final double? amount;
  final String? currency;
  final double? exchangeRate;
  final String? source;

  const PaymentSettlementData({
    this.amount,
    this.currency,
    this.exchangeRate,
    this.source,
  });
}
