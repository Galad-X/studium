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

abstract class Comment implements _i1.SerializableModel {
  Comment._({
    this.id,
    required this.postId,
    required this.authorId,
    this.parentCommentId,
    required this.body,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment({
    int? id,
    required int postId,
    required int authorId,
    int? parentCommentId,
    required String body,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CommentImpl;

  factory Comment.fromJson(Map<String, dynamic> jsonSerialization) {
    return Comment(
      id: jsonSerialization['id'] as int?,
      postId: jsonSerialization['postId'] as int,
      authorId: jsonSerialization['authorId'] as int,
      parentCommentId: jsonSerialization['parentCommentId'] as int?,
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

  int postId;

  int authorId;

  int? parentCommentId;

  String body;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Comment copyWith({
    int? id,
    int? postId,
    int? authorId,
    int? parentCommentId,
    String? body,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Comment',
      if (id != null) 'id': id,
      'postId': postId,
      'authorId': authorId,
      if (parentCommentId != null) 'parentCommentId': parentCommentId,
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

class _CommentImpl extends Comment {
  _CommentImpl({
    int? id,
    required int postId,
    required int authorId,
    int? parentCommentId,
    required String body,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         postId: postId,
         authorId: authorId,
         parentCommentId: parentCommentId,
         body: body,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Comment]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Comment copyWith({
    Object? id = _Undefined,
    int? postId,
    int? authorId,
    Object? parentCommentId = _Undefined,
    String? body,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Comment(
      id: id is int? ? id : this.id,
      postId: postId ?? this.postId,
      authorId: authorId ?? this.authorId,
      parentCommentId: parentCommentId is int?
          ? parentCommentId
          : this.parentCommentId,
      body: body ?? this.body,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
