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

abstract class CollaborativeDocument implements _i1.SerializableModel {
  CollaborativeDocument._({
    this.id,
    required this.roomId,
    required this.ownerId,
    required this.title,
    required this.body,
    required this.version,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CollaborativeDocument({
    int? id,
    required int roomId,
    required int ownerId,
    required String title,
    required String body,
    required int version,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _CollaborativeDocumentImpl;

  factory CollaborativeDocument.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CollaborativeDocument(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      ownerId: jsonSerialization['ownerId'] as int,
      title: jsonSerialization['title'] as String,
      body: jsonSerialization['body'] as String,
      version: jsonSerialization['version'] as int,
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

  String title;

  String body;

  int version;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [CollaborativeDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CollaborativeDocument copyWith({
    int? id,
    int? roomId,
    int? ownerId,
    String? title,
    String? body,
    int? version,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CollaborativeDocument',
      if (id != null) 'id': id,
      'roomId': roomId,
      'ownerId': ownerId,
      'title': title,
      'body': body,
      'version': version,
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

class _CollaborativeDocumentImpl extends CollaborativeDocument {
  _CollaborativeDocumentImpl({
    int? id,
    required int roomId,
    required int ownerId,
    required String title,
    required String body,
    required int version,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         roomId: roomId,
         ownerId: ownerId,
         title: title,
         body: body,
         version: version,
         status: status,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [CollaborativeDocument]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CollaborativeDocument copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? ownerId,
    String? title,
    String? body,
    int? version,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return CollaborativeDocument(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      body: body ?? this.body,
      version: version ?? this.version,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
