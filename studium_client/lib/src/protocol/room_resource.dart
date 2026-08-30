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

abstract class RoomResource implements _i1.SerializableModel {
  RoomResource._({
    this.id,
    required this.roomId,
    required this.ownerId,
    required this.resourceType,
    required this.title,
    this.uri,
    this.content,
    this.citation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory RoomResource({
    int? id,
    required int roomId,
    required int ownerId,
    required String resourceType,
    required String title,
    String? uri,
    String? content,
    String? citation,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _RoomResourceImpl;

  factory RoomResource.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomResource(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      ownerId: jsonSerialization['ownerId'] as int,
      resourceType: jsonSerialization['resourceType'] as String,
      title: jsonSerialization['title'] as String,
      uri: jsonSerialization['uri'] as String?,
      content: jsonSerialization['content'] as String?,
      citation: jsonSerialization['citation'] as String?,
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

  int ownerId;

  String resourceType;

  String title;

  String? uri;

  String? content;

  String? citation;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [RoomResource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoomResource copyWith({
    int? id,
    int? roomId,
    int? ownerId,
    String? resourceType,
    String? title,
    String? uri,
    String? content,
    String? citation,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomResource',
      if (id != null) 'id': id,
      'roomId': roomId,
      'ownerId': ownerId,
      'resourceType': resourceType,
      'title': title,
      if (uri != null) 'uri': uri,
      if (content != null) 'content': content,
      if (citation != null) 'citation': citation,
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

class _RoomResourceImpl extends RoomResource {
  _RoomResourceImpl({
    int? id,
    required int roomId,
    required int ownerId,
    required String resourceType,
    required String title,
    String? uri,
    String? content,
    String? citation,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          roomId: roomId,
          ownerId: ownerId,
          resourceType: resourceType,
          title: title,
          uri: uri,
          content: content,
          citation: citation,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [RoomResource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoomResource copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? ownerId,
    String? resourceType,
    String? title,
    Object? uri = _Undefined,
    Object? content = _Undefined,
    Object? citation = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return RoomResource(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      ownerId: ownerId ?? this.ownerId,
      resourceType: resourceType ?? this.resourceType,
      title: title ?? this.title,
      uri: uri is String? ? uri : this.uri,
      content: content is String? ? content : this.content,
      citation: citation is String? ? citation : this.citation,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
