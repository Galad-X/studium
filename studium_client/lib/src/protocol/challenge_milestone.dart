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

abstract class ChallengeMilestone implements _i1.SerializableModel {
  ChallengeMilestone._({
    this.id,
    required this.teamId,
    required this.title,
    this.description,
    required this.status,
    this.dueAt,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ChallengeMilestone({
    int? id,
    required int teamId,
    required String title,
    String? description,
    required String status,
    DateTime? dueAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChallengeMilestoneImpl;

  factory ChallengeMilestone.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeMilestone(
      id: jsonSerialization['id'] as int?,
      teamId: jsonSerialization['teamId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      status: jsonSerialization['status'] as String,
      dueAt: jsonSerialization['dueAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['dueAt']),
      completedAt: jsonSerialization['completedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['completedAt'],
            ),
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

  int teamId;

  String title;

  String? description;

  String status;

  DateTime? dueAt;

  DateTime? completedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ChallengeMilestone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChallengeMilestone copyWith({
    int? id,
    int? teamId,
    String? title,
    String? description,
    String? status,
    DateTime? dueAt,
    DateTime? completedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeMilestone',
      if (id != null) 'id': id,
      'teamId': teamId,
      'title': title,
      if (description != null) 'description': description,
      'status': status,
      if (dueAt != null) 'dueAt': dueAt?.toJson(),
      if (completedAt != null) 'completedAt': completedAt?.toJson(),
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

class _ChallengeMilestoneImpl extends ChallengeMilestone {
  _ChallengeMilestoneImpl({
    int? id,
    required int teamId,
    required String title,
    String? description,
    required String status,
    DateTime? dueAt,
    DateTime? completedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          teamId: teamId,
          title: title,
          description: description,
          status: status,
          dueAt: dueAt,
          completedAt: completedAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ChallengeMilestone]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChallengeMilestone copyWith({
    Object? id = _Undefined,
    int? teamId,
    String? title,
    Object? description = _Undefined,
    String? status,
    Object? dueAt = _Undefined,
    Object? completedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ChallengeMilestone(
      id: id is int? ? id : this.id,
      teamId: teamId ?? this.teamId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      status: status ?? this.status,
      dueAt: dueAt is DateTime? ? dueAt : this.dueAt,
      completedAt: completedAt is DateTime? ? completedAt : this.completedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
