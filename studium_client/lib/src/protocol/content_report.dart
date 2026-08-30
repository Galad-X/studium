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

abstract class ContentReport implements _i1.SerializableModel {
  ContentReport._({
    this.id,
    required this.reporterId,
    required this.contentType,
    required this.contentId,
    required this.reason,
    this.details,
    required this.status,
    required this.createdAt,
    this.resolvedAt,
  });

  factory ContentReport({
    int? id,
    required int reporterId,
    required String contentType,
    required int contentId,
    required String reason,
    String? details,
    required String status,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) = _ContentReportImpl;

  factory ContentReport.fromJson(Map<String, dynamic> jsonSerialization) {
    return ContentReport(
      id: jsonSerialization['id'] as int?,
      reporterId: jsonSerialization['reporterId'] as int,
      contentType: jsonSerialization['contentType'] as String,
      contentId: jsonSerialization['contentId'] as int,
      reason: jsonSerialization['reason'] as String,
      details: jsonSerialization['details'] as String?,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      resolvedAt: jsonSerialization['resolvedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['resolvedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int reporterId;

  String contentType;

  int contentId;

  String reason;

  String? details;

  String status;

  DateTime createdAt;

  DateTime? resolvedAt;

  /// Returns a shallow copy of this [ContentReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ContentReport copyWith({
    int? id,
    int? reporterId,
    String? contentType,
    int? contentId,
    String? reason,
    String? details,
    String? status,
    DateTime? createdAt,
    DateTime? resolvedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ContentReport',
      if (id != null) 'id': id,
      'reporterId': reporterId,
      'contentType': contentType,
      'contentId': contentId,
      'reason': reason,
      if (details != null) 'details': details,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (resolvedAt != null) 'resolvedAt': resolvedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ContentReportImpl extends ContentReport {
  _ContentReportImpl({
    int? id,
    required int reporterId,
    required String contentType,
    required int contentId,
    required String reason,
    String? details,
    required String status,
    required DateTime createdAt,
    DateTime? resolvedAt,
  }) : super._(
          id: id,
          reporterId: reporterId,
          contentType: contentType,
          contentId: contentId,
          reason: reason,
          details: details,
          status: status,
          createdAt: createdAt,
          resolvedAt: resolvedAt,
        );

  /// Returns a shallow copy of this [ContentReport]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ContentReport copyWith({
    Object? id = _Undefined,
    int? reporterId,
    String? contentType,
    int? contentId,
    String? reason,
    Object? details = _Undefined,
    String? status,
    DateTime? createdAt,
    Object? resolvedAt = _Undefined,
  }) {
    return ContentReport(
      id: id is int? ? id : this.id,
      reporterId: reporterId ?? this.reporterId,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      reason: reason ?? this.reason,
      details: details is String? ? details : this.details,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      resolvedAt: resolvedAt is DateTime? ? resolvedAt : this.resolvedAt,
    );
  }
}
