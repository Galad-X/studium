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

abstract class PushDelivery implements _i1.SerializableModel {
  PushDelivery._({
    this.id,
    required this.userId,
    required this.title,
    required this.message,
    this.type,
    this.relatedId,
    required this.status,
    required this.attempts,
    required this.maxAttempts,
    required this.availableAt,
    this.lockedAt,
    this.lockToken,
    this.lastError,
    this.sentAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PushDelivery({
    int? id,
    required int userId,
    required String title,
    required String message,
    String? type,
    int? relatedId,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PushDeliveryImpl;

  factory PushDelivery.fromJson(Map<String, dynamic> jsonSerialization) {
    return PushDelivery(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      message: jsonSerialization['message'] as String,
      type: jsonSerialization['type'] as String?,
      relatedId: jsonSerialization['relatedId'] as int?,
      status: jsonSerialization['status'] as String,
      attempts: jsonSerialization['attempts'] as int,
      maxAttempts: jsonSerialization['maxAttempts'] as int,
      availableAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['availableAt'],
      ),
      lockedAt: jsonSerialization['lockedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lockedAt']),
      lockToken: jsonSerialization['lockToken'] as String?,
      lastError: jsonSerialization['lastError'] as String?,
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
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

  String title;

  String message;

  String? type;

  int? relatedId;

  String status;

  int attempts;

  int maxAttempts;

  DateTime availableAt;

  DateTime? lockedAt;

  String? lockToken;

  String? lastError;

  DateTime? sentAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [PushDelivery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PushDelivery copyWith({
    int? id,
    int? userId,
    String? title,
    String? message,
    String? type,
    int? relatedId,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PushDelivery',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'message': message,
      if (type != null) 'type': type,
      if (relatedId != null) 'relatedId': relatedId,
      'status': status,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'availableAt': availableAt.toJson(),
      if (lockedAt != null) 'lockedAt': lockedAt?.toJson(),
      if (lockToken != null) 'lockToken': lockToken,
      if (lastError != null) 'lastError': lastError,
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
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

class _PushDeliveryImpl extends PushDelivery {
  _PushDeliveryImpl({
    int? id,
    required int userId,
    required String title,
    required String message,
    String? type,
    int? relatedId,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         title: title,
         message: message,
         type: type,
         relatedId: relatedId,
         status: status,
         attempts: attempts,
         maxAttempts: maxAttempts,
         availableAt: availableAt,
         lockedAt: lockedAt,
         lockToken: lockToken,
         lastError: lastError,
         sentAt: sentAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [PushDelivery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PushDelivery copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    String? message,
    Object? type = _Undefined,
    Object? relatedId = _Undefined,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    Object? lockedAt = _Undefined,
    Object? lockToken = _Undefined,
    Object? lastError = _Undefined,
    Object? sentAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PushDelivery(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type is String? ? type : this.type,
      relatedId: relatedId is int? ? relatedId : this.relatedId,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      availableAt: availableAt ?? this.availableAt,
      lockedAt: lockedAt is DateTime? ? lockedAt : this.lockedAt,
      lockToken: lockToken is String? ? lockToken : this.lockToken,
      lastError: lastError is String? ? lastError : this.lastError,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
