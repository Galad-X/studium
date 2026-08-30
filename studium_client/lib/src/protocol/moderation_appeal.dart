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

abstract class ModerationAppeal implements _i1.SerializableModel {
  ModerationAppeal._({
    this.id,
    required this.reportId,
    required this.appellantId,
    required this.reason,
    required this.status,
    this.reviewerId,
    this.reviewNotes,
    required this.createdAt,
    this.reviewedAt,
  });

  factory ModerationAppeal({
    int? id,
    required int reportId,
    required int appellantId,
    required String reason,
    required String status,
    int? reviewerId,
    String? reviewNotes,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) = _ModerationAppealImpl;

  factory ModerationAppeal.fromJson(Map<String, dynamic> jsonSerialization) {
    return ModerationAppeal(
      id: jsonSerialization['id'] as int?,
      reportId: jsonSerialization['reportId'] as int,
      appellantId: jsonSerialization['appellantId'] as int,
      reason: jsonSerialization['reason'] as String,
      status: jsonSerialization['status'] as String,
      reviewerId: jsonSerialization['reviewerId'] as int?,
      reviewNotes: jsonSerialization['reviewNotes'] as String?,
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

  int reportId;

  int appellantId;

  String reason;

  String status;

  int? reviewerId;

  String? reviewNotes;

  DateTime createdAt;

  DateTime? reviewedAt;

  /// Returns a shallow copy of this [ModerationAppeal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ModerationAppeal copyWith({
    int? id,
    int? reportId,
    int? appellantId,
    String? reason,
    String? status,
    int? reviewerId,
    String? reviewNotes,
    DateTime? createdAt,
    DateTime? reviewedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ModerationAppeal',
      if (id != null) 'id': id,
      'reportId': reportId,
      'appellantId': appellantId,
      'reason': reason,
      'status': status,
      if (reviewerId != null) 'reviewerId': reviewerId,
      if (reviewNotes != null) 'reviewNotes': reviewNotes,
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

class _ModerationAppealImpl extends ModerationAppeal {
  _ModerationAppealImpl({
    int? id,
    required int reportId,
    required int appellantId,
    required String reason,
    required String status,
    int? reviewerId,
    String? reviewNotes,
    required DateTime createdAt,
    DateTime? reviewedAt,
  }) : super._(
          id: id,
          reportId: reportId,
          appellantId: appellantId,
          reason: reason,
          status: status,
          reviewerId: reviewerId,
          reviewNotes: reviewNotes,
          createdAt: createdAt,
          reviewedAt: reviewedAt,
        );

  /// Returns a shallow copy of this [ModerationAppeal]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ModerationAppeal copyWith({
    Object? id = _Undefined,
    int? reportId,
    int? appellantId,
    String? reason,
    String? status,
    Object? reviewerId = _Undefined,
    Object? reviewNotes = _Undefined,
    DateTime? createdAt,
    Object? reviewedAt = _Undefined,
  }) {
    return ModerationAppeal(
      id: id is int? ? id : this.id,
      reportId: reportId ?? this.reportId,
      appellantId: appellantId ?? this.appellantId,
      reason: reason ?? this.reason,
      status: status ?? this.status,
      reviewerId: reviewerId is int? ? reviewerId : this.reviewerId,
      reviewNotes: reviewNotes is String? ? reviewNotes : this.reviewNotes,
      createdAt: createdAt ?? this.createdAt,
      reviewedAt: reviewedAt is DateTime? ? reviewedAt : this.reviewedAt,
    );
  }
}
