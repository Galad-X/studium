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

abstract class ApiRateLimitBucket implements _i1.SerializableModel {
  ApiRateLimitBucket._({
    this.id,
    required this.scopeKey,
    required this.windowStart,
    required this.requestCount,
    required this.updatedAt,
  });

  factory ApiRateLimitBucket({
    int? id,
    required String scopeKey,
    required DateTime windowStart,
    required int requestCount,
    required DateTime updatedAt,
  }) = _ApiRateLimitBucketImpl;

  factory ApiRateLimitBucket.fromJson(Map<String, dynamic> jsonSerialization) {
    return ApiRateLimitBucket(
      id: jsonSerialization['id'] as int?,
      scopeKey: jsonSerialization['scopeKey'] as String,
      windowStart: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['windowStart'],
      ),
      requestCount: jsonSerialization['requestCount'] as int,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String scopeKey;

  DateTime windowStart;

  int requestCount;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ApiRateLimitBucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ApiRateLimitBucket copyWith({
    int? id,
    String? scopeKey,
    DateTime? windowStart,
    int? requestCount,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ApiRateLimitBucket',
      if (id != null) 'id': id,
      'scopeKey': scopeKey,
      'windowStart': windowStart.toJson(),
      'requestCount': requestCount,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ApiRateLimitBucketImpl extends ApiRateLimitBucket {
  _ApiRateLimitBucketImpl({
    int? id,
    required String scopeKey,
    required DateTime windowStart,
    required int requestCount,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         scopeKey: scopeKey,
         windowStart: windowStart,
         requestCount: requestCount,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ApiRateLimitBucket]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ApiRateLimitBucket copyWith({
    Object? id = _Undefined,
    String? scopeKey,
    DateTime? windowStart,
    int? requestCount,
    DateTime? updatedAt,
  }) {
    return ApiRateLimitBucket(
      id: id is int? ? id : this.id,
      scopeKey: scopeKey ?? this.scopeKey,
      windowStart: windowStart ?? this.windowStart,
      requestCount: requestCount ?? this.requestCount,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
