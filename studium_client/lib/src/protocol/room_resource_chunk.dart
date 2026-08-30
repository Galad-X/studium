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

abstract class RoomResourceChunk implements _i1.SerializableModel {
  RoomResourceChunk._({
    this.id,
    required this.roomResourceId,
    required this.chunkIndex,
    required this.content,
    required this.tokenCount,
    this.embedding,
    required this.createdAt,
  });

  factory RoomResourceChunk({
    int? id,
    required int roomResourceId,
    required int chunkIndex,
    required String content,
    required int tokenCount,
    String? embedding,
    required DateTime createdAt,
  }) = _RoomResourceChunkImpl;

  factory RoomResourceChunk.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomResourceChunk(
      id: jsonSerialization['id'] as int?,
      roomResourceId: jsonSerialization['roomResourceId'] as int,
      chunkIndex: jsonSerialization['chunkIndex'] as int,
      content: jsonSerialization['content'] as String,
      tokenCount: jsonSerialization['tokenCount'] as int,
      embedding: jsonSerialization['embedding'] as String?,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomResourceId;

  int chunkIndex;

  String content;

  int tokenCount;

  String? embedding;

  DateTime createdAt;

  /// Returns a shallow copy of this [RoomResourceChunk]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoomResourceChunk copyWith({
    int? id,
    int? roomResourceId,
    int? chunkIndex,
    String? content,
    int? tokenCount,
    String? embedding,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomResourceChunk',
      if (id != null) 'id': id,
      'roomResourceId': roomResourceId,
      'chunkIndex': chunkIndex,
      'content': content,
      'tokenCount': tokenCount,
      if (embedding != null) 'embedding': embedding,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomResourceChunkImpl extends RoomResourceChunk {
  _RoomResourceChunkImpl({
    int? id,
    required int roomResourceId,
    required int chunkIndex,
    required String content,
    required int tokenCount,
    String? embedding,
    required DateTime createdAt,
  }) : super._(
          id: id,
          roomResourceId: roomResourceId,
          chunkIndex: chunkIndex,
          content: content,
          tokenCount: tokenCount,
          embedding: embedding,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [RoomResourceChunk]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoomResourceChunk copyWith({
    Object? id = _Undefined,
    int? roomResourceId,
    int? chunkIndex,
    String? content,
    int? tokenCount,
    Object? embedding = _Undefined,
    DateTime? createdAt,
  }) {
    return RoomResourceChunk(
      id: id is int? ? id : this.id,
      roomResourceId: roomResourceId ?? this.roomResourceId,
      chunkIndex: chunkIndex ?? this.chunkIndex,
      content: content ?? this.content,
      tokenCount: tokenCount ?? this.tokenCount,
      embedding: embedding is String? ? embedding : this.embedding,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
