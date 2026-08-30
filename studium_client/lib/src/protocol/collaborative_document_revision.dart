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

abstract class CollaborativeDocumentRevision implements _i1.SerializableModel {
  CollaborativeDocumentRevision._({
    this.id,
    required this.documentId,
    required this.editorId,
    required this.version,
    required this.body,
    required this.createdAt,
  });

  factory CollaborativeDocumentRevision({
    int? id,
    required int documentId,
    required int editorId,
    required int version,
    required String body,
    required DateTime createdAt,
  }) = _CollaborativeDocumentRevisionImpl;

  factory CollaborativeDocumentRevision.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return CollaborativeDocumentRevision(
      id: jsonSerialization['id'] as int?,
      documentId: jsonSerialization['documentId'] as int,
      editorId: jsonSerialization['editorId'] as int,
      version: jsonSerialization['version'] as int,
      body: jsonSerialization['body'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int documentId;

  int editorId;

  int version;

  String body;

  DateTime createdAt;

  /// Returns a shallow copy of this [CollaborativeDocumentRevision]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  CollaborativeDocumentRevision copyWith({
    int? id,
    int? documentId,
    int? editorId,
    int? version,
    String? body,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'CollaborativeDocumentRevision',
      if (id != null) 'id': id,
      'documentId': documentId,
      'editorId': editorId,
      'version': version,
      'body': body,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _CollaborativeDocumentRevisionImpl extends CollaborativeDocumentRevision {
  _CollaborativeDocumentRevisionImpl({
    int? id,
    required int documentId,
    required int editorId,
    required int version,
    required String body,
    required DateTime createdAt,
  }) : super._(
          id: id,
          documentId: documentId,
          editorId: editorId,
          version: version,
          body: body,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [CollaborativeDocumentRevision]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  CollaborativeDocumentRevision copyWith({
    Object? id = _Undefined,
    int? documentId,
    int? editorId,
    int? version,
    String? body,
    DateTime? createdAt,
  }) {
    return CollaborativeDocumentRevision(
      id: id is int? ? id : this.id,
      documentId: documentId ?? this.documentId,
      editorId: editorId ?? this.editorId,
      version: version ?? this.version,
      body: body ?? this.body,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
