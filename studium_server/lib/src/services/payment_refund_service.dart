class PaymentRefundService {
  static String transactionStatus({
    required double chargedAmount,
    required double refundedAmount,
    required double refundAmount,
  }) {
    if (chargedAmount <= 0 || refundAmount <= 0 || refundedAmount < 0) {
      throw ArgumentError('Payment amounts must be positive.');
    }
    if (refundedAmount + refundAmount > chargedAmount + 0.000001) {
      throw StateError('Refund exceeds the captured payment amount.');
    }
    return refundedAmount + refundAmount >= chargedAmount - 0.000001
        ? 'refunded'
        : 'partial_refunded';
  }

  static bool revokesEntitlement(String transactionStatus) =>
      transactionStatus == 'refunded';
}
