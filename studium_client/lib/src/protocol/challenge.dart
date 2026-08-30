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
import 'package:studium_client/src/protocol/protocol.dart' as _i2;

abstract class Challenge implements _i1.SerializableModel {
  Challenge._({
    this.id,
    this.roomId,
    required this.ownerId,
    required this.title,
    required this.problemStatement,
    required this.field,
    required this.tags,
    required this.difficulty,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Challenge({
    int? id,
    int? roomId,
    required int ownerId,
    required String title,
    required String problemStatement,
    required String field,
    required List<String> tags,
    required String difficulty,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ChallengeImpl;

  factory Challenge.fromJson(Map<String, dynamic> jsonSerialization) {
    return Challenge(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int?,
      ownerId: jsonSerialization['ownerId'] as int,
      title: jsonSerialization['title'] as String,
      problemStatement: jsonSerialization['problemStatement'] as String,
      field: jsonSerialization['field'] as String,
      tags: _i2.Protocol().deserialize<List<String>>(jsonSerialization['tags']),
      difficulty: jsonSerialization['difficulty'] as String,
      status: jsonSerialization['status'] as String,
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

  int? roomId;

  int ownerId;

  String title;

  String problemStatement;

  String field;

  List<String> tags;

  String difficulty;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Challenge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Challenge copyWith({
    int? id,
    int? roomId,
    int? ownerId,
    String? title,
    String? problemStatement,
    String? field,
    List<String>? tags,
    String? difficulty,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Challenge',
      if (id != null) 'id': id,
      if (roomId != null) 'roomId': roomId,
      'ownerId': ownerId,
      'title': title,
      'problemStatement': problemStatement,
      'field': field,
      'tags': tags.toJson(),
      'difficulty': difficulty,
      'status': status,
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

class _ChallengeImpl extends Challenge {
  _ChallengeImpl({
    int? id,
    int? roomId,
    required int ownerId,
    required String title,
    required String problemStatement,
    required String field,
    required List<String> tags,
    required String difficulty,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          roomId: roomId,
          ownerId: ownerId,
          title: title,
          problemStatement: problemStatement,
          field: field,
          tags: tags,
          difficulty: difficulty,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Challenge]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Challenge copyWith({
    Object? id = _Undefined,
    Object? roomId = _Undefined,
    int? ownerId,
    String? title,
    String? problemStatement,
    String? field,
    List<String>? tags,
    String? difficulty,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Challenge(
      id: id is int? ? id : this.id,
      roomId: roomId is int? ? roomId : this.roomId,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      problemStatement: problemStatement ?? this.problemStatement,
      field: field ?? this.field,
      tags: tags ?? this.tags.map((e0) => e0).toList(),
      difficulty: difficulty ?? this.difficulty,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
