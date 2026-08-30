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

abstract class DiscussionReaction implements _i1.SerializableModel {
  DiscussionReaction._({
    this.id,
    required this.postId,
    required this.userId,
    required this.reaction,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DiscussionReaction({
    int? id,
    required int postId,
    required int userId,
    required String reaction,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DiscussionReactionImpl;

  factory DiscussionReaction.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscussionReaction(
      id: jsonSerialization['id'] as int?,
      postId: jsonSerialization['postId'] as int,
      userId: jsonSerialization['userId'] as int,
      reaction: jsonSerialization['reaction'] as String,
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

  int postId;

  int userId;

  String reaction;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DiscussionReaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscussionReaction copyWith({
    int? id,
    int? postId,
    int? userId,
    String? reaction,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscussionReaction',
      if (id != null) 'id': id,
      'postId': postId,
      'userId': userId,
      'reaction': reaction,
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

class _DiscussionReactionImpl extends DiscussionReaction {
  _DiscussionReactionImpl({
    int? id,
    required int postId,
    required int userId,
    required String reaction,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         postId: postId,
         userId: userId,
         reaction: reaction,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DiscussionReaction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscussionReaction copyWith({
    Object? id = _Undefined,
    int? postId,
    int? userId,
    String? reaction,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DiscussionReaction(
      id: id is int? ? id : this.id,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      reaction: reaction ?? this.reaction,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
