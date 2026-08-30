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

abstract class AuditEvent implements _i1.SerializableModel {
  AuditEvent._({
    this.id,
    required this.actorId,
    this.institutionId,
    required this.action,
    required this.targetType,
    required this.targetId,
    this.metadata,
    required this.createdAt,
  });

  factory AuditEvent({
    int? id,
    required int actorId,
    int? institutionId,
    required String action,
    required String targetType,
    required int targetId,
    String? metadata,
    required DateTime createdAt,
  }) = _AuditEventImpl;

  factory AuditEvent.fromJson(Map<String, dynamic> jsonSerialization) {
    return AuditEvent(
      id: jsonSerialization['id'] as int?,
      actorId: jsonSerialization['actorId'] as int,
      institutionId: jsonSerialization['institutionId'] as int?,
      action: jsonSerialization['action'] as String,
      targetType: jsonSerialization['targetType'] as String,
      targetId: jsonSerialization['targetId'] as int,
      metadata: jsonSerialization['metadata'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int actorId;

  int? institutionId;

  String action;

  String targetType;

  int targetId;

  String? metadata;

  DateTime createdAt;

  /// Returns a shallow copy of this [AuditEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AuditEvent copyWith({
    int? id,
    int? actorId,
    int? institutionId,
    String? action,
    String? targetType,
    int? targetId,
    String? metadata,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AuditEvent',
      if (id != null) 'id': id,
      'actorId': actorId,
      if (institutionId != null) 'institutionId': institutionId,
      'action': action,
      'targetType': targetType,
      'targetId': targetId,
      if (metadata != null) 'metadata': metadata,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AuditEventImpl extends AuditEvent {
  _AuditEventImpl({
    int? id,
    required int actorId,
    int? institutionId,
    required String action,
    required String targetType,
    required int targetId,
    String? metadata,
    required DateTime createdAt,
  }) : super._(
         id: id,
         actorId: actorId,
         institutionId: institutionId,
         action: action,
         targetType: targetType,
         targetId: targetId,
         metadata: metadata,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [AuditEvent]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AuditEvent copyWith({
    Object? id = _Undefined,
    int? actorId,
    Object? institutionId = _Undefined,
    String? action,
    String? targetType,
    int? targetId,
    Object? metadata = _Undefined,
    DateTime? createdAt,
  }) {
    return AuditEvent(
      id: id is int? ? id : this.id,
      actorId: actorId ?? this.actorId,
      institutionId: institutionId is int? ? institutionId : this.institutionId,
      action: action ?? this.action,
      targetType: targetType ?? this.targetType,
      targetId: targetId ?? this.targetId,
      metadata: metadata is String? ? metadata : this.metadata,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
