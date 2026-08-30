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

abstract class VerificationRequest implements _i1.SerializableModel {
  VerificationRequest._({
    this.id,
    required this.membershipId,
    required this.method,
    this.evidenceUrl,
    required this.status,
    this.reviewerId,
    required this.createdAt,
    this.reviewedAt,
  });

  factory VerificationRequest({
    int? id,
    required int membershipId,
    required String method,
    String? evidenceUrl,
    required String status,
    int? reviewerId,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) = _VerificationRequestImpl;

  factory VerificationRequest.fromJson(Map<String, dynamic> jsonSerialization) {
    return VerificationRequest(
      id: jsonSerialization['id'] as int?,
      membershipId: jsonSerialization['membershipId'] as int,
      method: jsonSerialization['method'] as String,
      evidenceUrl: jsonSerialization['evidenceUrl'] as String?,
      status: jsonSerialization['status'] as String,
      reviewerId: jsonSerialization['reviewerId'] as int?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      reviewedAt: jsonSerialization['reviewedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['reviewedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int membershipId;

  String method;

  String? evidenceUrl;

  String status;

  int? reviewerId;

  DateTime createdAt;

  DateTime? reviewedAt;

  /// Returns a shallow copy of this [VerificationRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  VerificationRequest copyWith({
    int? id,
    int? membershipId,
    String? method,
    String? evidenceUrl,
    String? status,
    int? reviewerId,
    DateTime? createdAt,
    DateTime? reviewedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'VerificationRequest',
      if (id != null) 'id': id,
      'membershipId': membershipId,
      'method': method,
      if (evidenceUrl != null) 'evidenceUrl': evidenceUrl,
      'status': status,
      if (reviewerId != null) 'reviewerId': reviewerId,
      'createdAt': createdAt.toJson(),
      if (reviewedAt != null) 'reviewedAt': reviewedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _VerificationRequestImpl extends VerificationRequest {
  _VerificationRequestImpl({
    int? id,
    required int membershipId,
    required String method,
    String? evidenceUrl,
    required String status,
    int? reviewerId,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) : super._(
          id: id,
          membershipId: membershipId,
          method: method,
          evidenceUrl: evidenceUrl,
          status: status,
          reviewerId: reviewerId,
          createdAt: createdAt,
          reviewedAt: reviewedAt,
        );

  /// Returns a shallow copy of this [VerificationRequest]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  VerificationRequest copyWith({
    Object? id = _Undefined,
    int? membershipId,
    String? method,
    Object? evidenceUrl = _Undefined,
    String? status,
    Object? reviewerId = _Undefined,
    DateTime? createdAt,
    Object? reviewedAt = _Undefined,
  }) {
    return VerificationRequest(
      id: id is int? ? id : this.id,
      membershipId: membershipId ?? this.membershipId,
      method: method ?? this.method,
      evidenceUrl: evidenceUrl is String? ? evidenceUrl : this.evidenceUrl,
      status: status ?? this.status,
      reviewerId: reviewerId is int? ? reviewerId : this.reviewerId,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
    );
  }
}
