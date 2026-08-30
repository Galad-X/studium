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

abstract class Subscription implements _i1.SerializableModel {
  Subscription._({
    this.id,
    required this.userId,
    required this.gateway,
    required this.subscriptionId,
    this.gatewayToken,
    required this.status,
    required this.startDate,
    this.endDate,
  });

  factory Subscription({
    int? id,
    required int userId,
    required String gateway,
    required String subscriptionId,
    String? gatewayToken,
    required String status,
    required DateTime startDate,
    DateTime? endDate,
  }) = _SubscriptionImpl;

  factory Subscription.fromJson(Map<String, dynamic> jsonSerialization) {
    return Subscription(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      gateway: jsonSerialization['gateway'] as String,
      subscriptionId: jsonSerialization['subscriptionId'] as String,
      gatewayToken: jsonSerialization['gatewayToken'] as String?,
      status: jsonSerialization['status'] as String,
      startDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startDate'],
      ),
      endDate: jsonSerialization['endDate'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endDate']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String gateway;

  String subscriptionId;

  String? gatewayToken;

  String status;

  DateTime startDate;

  DateTime? endDate;

  /// Returns a shallow copy of this [Subscription]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Subscription copyWith({
    int? id,
    int? userId,
    String? gateway,
    String? subscriptionId,
    String? gatewayToken,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Subscription',
      if (id != null) 'id': id,
      'userId': userId,
      'gateway': gateway,
      'subscriptionId': subscriptionId,
      if (gatewayToken != null) 'gatewayToken': gatewayToken,
      'status': status,
      'startDate': startDate.toJson(),
      if (endDate != null) 'endDate': endDate?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubscriptionImpl extends Subscription {
  _SubscriptionImpl({
    int? id,
    required int userId,
    required String gateway,
    required String subscriptionId,
    String? gatewayToken,
    required String status,
    required DateTime startDate,
    DateTime? endDate,
  }) : super._(
          id: id,
          userId: userId,
          gateway: gateway,
          subscriptionId: subscriptionId,
          gatewayToken: gatewayToken,
          status: status,
          startDate: startDate,
          endDate: endDate,
        );

  /// Returns a shallow copy of this [Subscription]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Subscription copyWith({
    Object? id = _Undefined,
    int? userId,
    String? gateway,
    String? subscriptionId,
    Object? gatewayToken = _Undefined,
    String? status,
    DateTime? startDate,
    Object? endDate = _Undefined,
  }) {
    return Subscription(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      gateway: gateway ?? this.gateway,
      subscriptionId: subscriptionId ?? this.subscriptionId,
      gatewayToken: gatewayToken is String? ? gatewayToken : this.gatewayToken,
      status: status ?? this.status,
      startDate: startDate ?? this.startDate,
      endDate: endDate is DateTime? ? endDate : this.endDate,
    );
  }
}
