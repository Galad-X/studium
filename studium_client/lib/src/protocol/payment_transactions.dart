/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class PaymentTransaction implements _i1.SerializableModel {
  PaymentTransaction._({
    this.id,
    required this.subscriptionId,
    required this.userId,
    required this.amount,
    this.currency,
    this.settlementAmount,
    this.settlementCurrency,
    this.exchangeRate,
    this.settlementSource,
    required this.status,
    required this.gateway,
    required this.transactionId,
    required this.createdAt,
  });

  factory PaymentTransaction({
    int? id,
    required int subscriptionId,
    required int userId,
    required double amount,
    String? currency,
    double? settlementAmount,
    String? settlementCurrency,
    double? exchangeRate,
    String? settlementSource,
    required String status,
    required String gateway,
    required String transactionId,
    required DateTime createdAt,
  }) = _PaymentTransactionImpl;

  factory PaymentTransaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return PaymentTransaction(
      id: jsonSerialization['id'] as int?,
      subscriptionId: jsonSerialization['subscriptionId'] as int,
      userId: jsonSerialization['userId'] as int,
      amount: (jsonSerialization['amount'] as num).toDouble(),
      currency: jsonSerialization['currency'] as String?,
      settlementAmount:
          (jsonSerialization['settlementAmount'] as num?)?.toDouble(),
      settlementCurrency: jsonSerialization['settlementCurrency'] as String?,
      exchangeRate: (jsonSerialization['exchangeRate'] as num?)?.toDouble(),
      settlementSource: jsonSerialization['settlementSource'] as String?,
      status: jsonSerialization['status'] as String,
      gateway: jsonSerialization['gateway'] as String,
      transactionId: jsonSerialization['transactionId'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int subscriptionId;

  int userId;

  double amount;

  String? currency;

  double? settlementAmount;

  String? settlementCurrency;

  double? exchangeRate;

  String? settlementSource;

  String status;

  String gateway;

  String transactionId;

  DateTime createdAt;

  /// Returns a shallow copy of this [PaymentTransaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PaymentTransaction copyWith({
    int? id,
    int? subscriptionId,
    int? userId,
    double? amount,
    String? currency,
    double? settlementAmount,
    String? settlementCurrency,
    double? exchangeRate,
    String? settlementSource,
    String? status,
    String? gateway,
    String? transactionId,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PaymentTransaction',
      if (id != null) 'id': id,
      'subscriptionId': subscriptionId,
      'userId': userId,
      'amount': amount,
      if (currency != null) 'currency': currency,
      if (settlementAmount != null) 'settlementAmount': settlementAmount,
      if (settlementCurrency != null) 'settlementCurrency': settlementCurrency,
      if (exchangeRate != null) 'exchangeRate': exchangeRate,
      if (settlementSource != null) 'settlementSource': settlementSource,
      'status': status,
      'gateway': gateway,
      'transactionId': transactionId,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _PaymentTransactionImpl extends PaymentTransaction {
  _PaymentTransactionImpl({
    int? id,
    required int subscriptionId,
    required int userId,
    required double amount,
    String? currency,
    double? settlementAmount,
    String? settlementCurrency,
    double? exchangeRate,
    String? settlementSource,
    required String status,
    required String gateway,
    required String transactionId,
    required DateTime createdAt,
  }) : super._(
          id: id,
          subscriptionId: subscriptionId,
          userId: userId,
          amount: amount,
          currency: currency,
          settlementAmount: settlementAmount,
          settlementCurrency: settlementCurrency,
          exchangeRate: exchangeRate,
          settlementSource: settlementSource,
          status: status,
          gateway: gateway,
          transactionId: transactionId,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [PaymentTransaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PaymentTransaction copyWith({
    Object? id = _Undefined,
    int? subscriptionId,
    int? userId,
    double? amount,
    Object? currency = _Undefined,
    Object? settlementAmount = _Undefined,
    Object? settlementCurrency = _Undefined,
    Object? exchangeRate = _Undefined,
    Object? settlementSource = _Undefined,
    String? status,
    String? gateway,
    String? transactionId,
    DateTime? createdAt,
  }) {
    return PaymentTransaction(
      id: id is int? ? id : this.id,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      currency: currency is String? ? currency : this.currency,
      settlementAmount: settlementAmount is double?
          ? settlementAmount
          : this.settlementAmount,
      settlementCurrency: settlementCurrency is String?
          ? settlementCurrency
          : this.settlementCurrency,
      exchangeRate: exchangeRate is double? ? exchangeRate : this.exchangeRate,
      settlementSource: settlementSource is String?
          ? settlementSource
          : this.settlementSource,
      status: status ?? this.status,
      gateway: gateway ?? this.gateway,
      transactionId: transactionId ?? this.transactionId,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
