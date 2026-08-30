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

abstract class ModerationLog implements _i1.SerializableModel {
  ModerationLog._({
    this.id,
    required this.reportId,
    required this.moderatorId,
    required this.action,
    required this.targetType,
    required this.targetId,
    this.note,
    required this.createdAt,
  });

  factory ModerationLog({
    int? id,
    required int reportId,
    required int moderatorId,
    required String action,
    required String targetType,
    required int targetId,
    String? note,
    required DateTime createdAt,
  }) = _ModerationLogImpl;

  factory ModerationLog.fromJson(Map<String, dynamic> jsonSerialization) {
    return ModerationLog(
      id: jsonSerialization['id'] as int?,
      reportId: jsonSerialization['reportId'] as int,
      moderatorId: jsonSerialization['moderatorId'] as int,
      action: jsonSerialization['action'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      note: jsonSerialization['note'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int reportId;

  int moderatorId;

  String action;

  String targetType;

  int targetId;

  String? note;

  DateTime createdAt;

  /// Returns a shallow copy of this [ModerationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ModerationLog copyWith({
    int? id,
    int? reportId,
    int? moderatorId,
    String? action,
    String? targetType,
    int? targetId,
    String? note,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ModerationLog',
      if (id != null) 'id': id,
      'reportId': reportId,
      'moderatorId': moderatorId,
      'action': action,
      'targetType': targetType,
      'targetId': targetId,
      if (note != null) 'note': note,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ModerationLogImpl extends ModerationLog {
  _ModerationLogImpl({
    int? id,
    required int reportId,
    required int moderatorId,
    required String action,
    required String targetType,
    required int targetId,
    String? note,
    required DateTime createdAt,
  }) : super._(
          id: id,
          reportId: reportId,
          moderatorId: moderatorId,
          action: action,
          targetType: targetType,
          targetId: targetId,
          note: note,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ModerationLog]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ModerationLog copyWith({
    Object? id = _Undefined,
    int? reportId,
    int? moderatorId,
    String? action,
    String? targetType,
    int? targetId,
    Object? note = _Undefined,
    DateTime? createdAt,
  }) {
    return ModerationLog(
      id: id is int? ? id : this.id,
      reportId: reportId ?? this.reportId,
      moderatorId: moderatorId ?? this.moderatorId,
      action: action ?? this.action,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      note: note is String? ? note : this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
