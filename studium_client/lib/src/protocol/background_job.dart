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

abstract class BackgroundJob implements _i1.SerializableModel {
  BackgroundJob._({
    this.id,
    required this.jobType,
    required this.payload,
    required this.status,
    required this.attempts,
    required this.maxAttempts,
    required this.availableAt,
    this.lockedAt,
    this.lockToken,
    this.lastError,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BackgroundJob({
    int? id,
    required String jobType,
    required String payload,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BackgroundJobImpl;

  factory BackgroundJob.fromJson(Map<String, dynamic> jsonSerialization) {
    return BackgroundJob(
      id: jsonSerialization['id'] as int?,
      jobType: jsonSerialization['jobType'] as String,
      payload: jsonSerialization['payload'] as String,
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

  String jobType;

  String payload;

  String status;

  int attempts;

  int maxAttempts;

  DateTime availableAt;

  DateTime? lockedAt;

  String? lockToken;

  String? lastError;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [BackgroundJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  BackgroundJob copyWith({
    int? id,
    String? jobType,
    String? payload,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'BackgroundJob',
      if (id != null) 'id': id,
      'jobType': jobType,
      'payload': payload,
      'status': status,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'availableAt': availableAt.toJson(),
      if (lockedAt != null) 'lockedAt': lockedAt?.toJson(),
      if (lockToken != null) 'lockToken': lockToken,
      if (lastError != null) 'lastError': lastError,
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

class _BackgroundJobImpl extends BackgroundJob {
  _BackgroundJobImpl({
    int? id,
    required String jobType,
    required String payload,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          jobType: jobType,
          payload: payload,
          status: status,
          attempts: attempts,
          maxAttempts: maxAttempts,
          availableAt: availableAt,
          lockedAt: lockedAt,
          lockToken: lockToken,
          lastError: lastError,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [BackgroundJob]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  BackgroundJob copyWith({
    Object? id = _Undefined,
    String? jobType,
    String? payload,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    Object? lockedAt = _Undefined,
    Object? lockToken = _Undefined,
    Object? lastError = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BackgroundJob(
      id: id is int? ? id : this.id,
      jobType: jobType ?? this.jobType,
      payload: payload ?? this.payload,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      availableAt: availableAt ?? this.availableAt,
      lockedAt: lockedAt is DateTime? ? lockedAt : this.lockedAt,
      lockToken: lockToken is String? ? lockToken : this.lockToken,
      lastError: lastError is String? ? lastError : this.lastError,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
