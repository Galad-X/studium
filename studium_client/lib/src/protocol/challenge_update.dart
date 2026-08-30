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

abstract class ChallengeProgressUpdate implements _i1.SerializableModel {
  ChallengeProgressUpdate._({
    this.id,
    required this.teamId,
    required this.authorId,
    required this.body,
    required this.status,
    required this.createdAt,
  });

  factory ChallengeProgressUpdate({
    int? id,
    required int teamId,
    required int authorId,
    required String body,
    required String status,
    required DateTime createdAt,
  }) = _ChallengeProgressUpdateImpl;

  factory ChallengeProgressUpdate.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ChallengeProgressUpdate(
      id: jsonSerialization['id'] as int?,
      teamId: jsonSerialization['teamId'] as int,
      authorId: jsonSerialization['authorId'] as int,
      body: jsonSerialization['body'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int teamId;

  int authorId;

  String body;

  String status;

  DateTime createdAt;

  /// Returns a shallow copy of this [ChallengeProgressUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChallengeProgressUpdate copyWith({
    int? id,
    int? teamId,
    int? authorId,
    String? body,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeProgressUpdate',
      if (id != null) 'id': id,
      'teamId': teamId,
      'authorId': authorId,
      'body': body,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeProgressUpdateImpl extends ChallengeProgressUpdate {
  _ChallengeProgressUpdateImpl({
    int? id,
    required int teamId,
    required int authorId,
    required String body,
    required String status,
    required DateTime createdAt,
  }) : super._(
          id: id,
          teamId: teamId,
          authorId: authorId,
          body: body,
          status: status,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ChallengeProgressUpdate]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChallengeProgressUpdate copyWith({
    Object? id = _Undefined,
    int? teamId,
    int? authorId,
    String? body,
    String? status,
    DateTime? createdAt,
  }) {
    return ChallengeProgressUpdate(
      id: id is int? ? id : this.id,
      teamId: teamId ?? this.teamId,
      authorId: authorId ?? this.authorId,
      body: body ?? this.body,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
