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

abstract class CollaborationPresence implements _i1.SerializableModel {
  CollaborationPresence._({
    this.id,
    required this.userId,
    required this.scopeType,
    required this.scopeId,
    required this.state,
    required this.lastSeenAt,
  });

  factory CollaborationPresence({
    int? id,
    required int userId,
    required String scopeType,
    required int scopeId,
    required String state,
    required DateTime lastSeenAt,
  }) = _CollaborationPresenceImpl;

  factory CollaborationPresence.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CollaborationPresence(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      scopeType: jsonSerialization['scopeType'] as String,
      scopeId: jsonSerialization['scopeId'] as int,
      state: jsonSerialization['state'] as String,
      lastSeenAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastSeenAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String scopeType;

  int scopeId;

  String state;

  DateTime lastSeenAt;

  /// Returns a shallow copy of this [CollaborationPresence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CollaborationPresence copyWith({
    int? id,
    int? userId,
    String? scopeType,
    int? scopeId,
    String? state,
    DateTime? lastSeenAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CollaborationPresence',
      if (id != null) 'id': id,
      'userId': userId,
      'scopeType': scopeType,
      'scopeId': scopeId,
      'state': state,
      'lastSeenAt': lastSeenAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CollaborationPresenceImpl extends CollaborationPresence {
  _CollaborationPresenceImpl({
    int? id,
    required int userId,
    required String scopeType,
    required int scopeId,
    required String state,
    required DateTime lastSeenAt,
  }) : super._(
         id: id,
         userId: userId,
         scopeType: scopeType,
         scopeId: scopeId,
         state: state,
         lastSeenAt: lastSeenAt,
       );

  /// Returns a shallow copy of this [CollaborationPresence]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CollaborationPresence copyWith({
    Object? id = _Undefined,
    int? userId,
    String? scopeType,
    int? scopeId,
    String? state,
    DateTime? lastSeenAt,
  }) {
    return CollaborationPresence(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      scopeType: scopeType ?? this.scopeType,
      scopeId: scopeId ?? this.scopeId,
      state: state ?? this.state,
      lastSeenAt: lastSeenAt ?? this.lastSeenAt,
    );
  }
}
