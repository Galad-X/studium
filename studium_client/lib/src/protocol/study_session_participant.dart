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

abstract class StudySessionParticipant implements _i1.SerializableModel {
  StudySessionParticipant._({
    this.id,
    required this.sessionId,
    required this.userId,
    required this.status,
    required this.joinedAt,
  });

  factory StudySessionParticipant({
    int? id,
    required int sessionId,
    required int userId,
    required String status,
    required DateTime joinedAt,
  }) = _StudySessionParticipantImpl;

  factory StudySessionParticipant.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return StudySessionParticipant(
      id: jsonSerialization['id'] as int?,
      sessionId: jsonSerialization['sessionId'] as int,
      userId: jsonSerialization['userId'] as int,
      status: jsonSerialization['status'] as String,
      joinedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int sessionId;

  int userId;

  String status;

  DateTime joinedAt;

  /// Returns a shallow copy of this [StudySessionParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudySessionParticipant copyWith({
    int? id,
    int? sessionId,
    int? userId,
    String? status,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudySessionParticipant',
      if (id != null) 'id': id,
      'sessionId': sessionId,
      'userId': userId,
      'status': status,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudySessionParticipantImpl extends StudySessionParticipant {
  _StudySessionParticipantImpl({
    int? id,
    required int sessionId,
    required int userId,
    required String status,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         sessionId: sessionId,
         userId: userId,
         status: status,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [StudySessionParticipant]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudySessionParticipant copyWith({
    Object? id = _Undefined,
    int? sessionId,
    int? userId,
    String? status,
    DateTime? joinedAt,
  }) {
    return StudySessionParticipant(
      id: id is int? ? id : this.id,
      sessionId: sessionId ?? this.sessionId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
