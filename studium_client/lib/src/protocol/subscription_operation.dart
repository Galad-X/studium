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

abstract class SubscriptionOperation implements _i1.SerializableModel {
  SubscriptionOperation._({
    this.id,
    required this.userId,
    required this.gateway,
    required this.idempotencyKey,
    required this.status,
    this.subscriptionId,
    this.errorMessage,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SubscriptionOperation({
    int? id,
    required int userId,
    required String gateway,
    required String idempotencyKey,
    required String status,
    int? subscriptionId,
    String? errorMessage,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _SubscriptionOperationImpl;

  factory SubscriptionOperation.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return SubscriptionOperation(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      gateway: jsonSerialization['gateway'] as String,
      idempotencyKey: jsonSerialization['idempotencyKey'] as String,
      status: jsonSerialization['status'] as String,
      subscriptionId: jsonSerialization['subscriptionId'] as int?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String gateway;

  String idempotencyKey;

  String status;

  int? subscriptionId;

  String? errorMessage;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [SubscriptionOperation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  SubscriptionOperation copyWith({
    int? id,
    int? userId,
    String? gateway,
    String? idempotencyKey,
    String? status,
    int? subscriptionId,
    String? errorMessage,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'SubscriptionOperation',
      if (id != null) 'id': id,
      'userId': userId,
      'gateway': gateway,
      'idempotencyKey': idempotencyKey,
      'status': status,
      if (subscriptionId != null) 'subscriptionId': subscriptionId,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'createdAt': createdAt.toJson(),
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SubscriptionOperationImpl extends SubscriptionOperation {
  _SubscriptionOperationImpl({
    int? id,
    required int userId,
    required String gateway,
    required String idempotencyKey,
    required String status,
    int? subscriptionId,
    String? errorMessage,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          gateway: gateway,
          idempotencyKey: idempotencyKey,
          status: status,
          subscriptionId: subscriptionId,
          errorMessage: errorMessage,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [SubscriptionOperation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  SubscriptionOperation copyWith({
    Object? id = _Undefined,
    int? userId,
    String? gateway,
    String? idempotencyKey,
    String? status,
    Object? subscriptionId = _Undefined,
    Object? errorMessage = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return SubscriptionOperation(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      gateway: gateway ?? this.gateway,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      status: status ?? this.status,
      subscriptionId:
          subscriptionId is int? ? subscriptionId : this.subscriptionId,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
