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

abstract class DiscussionPost implements _i1.SerializableModel {
  DiscussionPost._({
    this.id,
    required this.roomId,
    required this.authorId,
    this.acceptedCommentId,
    required this.body,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory DiscussionPost({
    int? id,
    required int roomId,
    required int authorId,
    int? acceptedCommentId,
    required String body,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DiscussionPostImpl;

  factory DiscussionPost.fromJson(Map<String, dynamic> jsonSerialization) {
    return DiscussionPost(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      authorId: jsonSerialization['authorId'] as int,
      acceptedCommentId: jsonSerialization['acceptedCommentId'] as int?,
      body: jsonSerialization['body'] as String,
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

  int roomId;

  int authorId;

  int? acceptedCommentId;

  String body;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [DiscussionPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DiscussionPost copyWith({
    int? id,
    int? roomId,
    int? authorId,
    int? acceptedCommentId,
    String? body,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'DiscussionPost',
      if (id != null) 'id': id,
      'roomId': roomId,
      'authorId': authorId,
      if (acceptedCommentId != null) 'acceptedCommentId': acceptedCommentId,
      'body': body,
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

class _DiscussionPostImpl extends DiscussionPost {
  _DiscussionPostImpl({
    int? id,
    required int roomId,
    required int authorId,
    int? acceptedCommentId,
    required String body,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         roomId: roomId,
         authorId: authorId,
         acceptedCommentId: acceptedCommentId,
         body: body,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [DiscussionPost]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DiscussionPost copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? authorId,
    Object? acceptedCommentId = _Undefined,
    String? body,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return DiscussionPost(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      authorId: authorId ?? this.authorId,
      acceptedCommentId: acceptedCommentId is int?
          ? acceptedCommentId
          : this.acceptedCommentId,
      body: body ?? this.body,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
