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

abstract class AcademicWriting implements _i1.SerializableModel {
  AcademicWriting._({
    this.id,
    required this.userId,
    this.studyMaterialId,
    required this.type,
    required this.title,
    this.wordCount,
    required this.content,
    required this.format,
    required this.fileUrl,
    required this.createdAt,
  });

  factory AcademicWriting({
    int? id,
    required int userId,
    int? studyMaterialId,
    required String type,
    required String title,
    int? wordCount,
    required String content,
    required String format,
    required String fileUrl,
    required DateTime createdAt,
  }) = _AcademicWritingImpl;

  factory AcademicWriting.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcademicWriting(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int?,
      type: jsonSerialization['type'] as String,
      title: jsonSerialization['title'] as String,
      wordCount: jsonSerialization['wordCount'] as int?,
      content: jsonSerialization['content'] as String,
      format: jsonSerialization['format'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int? studyMaterialId;

  String type;

  String title;

  int? wordCount;

  String content;

  String format;

  String fileUrl;

  DateTime createdAt;

  /// Returns a shallow copy of this [AcademicWriting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AcademicWriting copyWith({
    int? id,
    int? userId,
    int? studyMaterialId,
    String? type,
    String? title,
    int? wordCount,
    String? content,
    String? format,
    String? fileUrl,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AcademicWriting',
      if (id != null) 'id': id,
      'userId': userId,
      if (studyMaterialId != null) 'studyMaterialId': studyMaterialId,
      'type': type,
      'title': title,
      if (wordCount != null) 'wordCount': wordCount,
      'content': content,
      'format': format,
      'fileUrl': fileUrl,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AcademicWritingImpl extends AcademicWriting {
  _AcademicWritingImpl({
    int? id,
    required int userId,
    int? studyMaterialId,
    required String type,
    required String title,
    int? wordCount,
    required String content,
    required String format,
    required String fileUrl,
    required DateTime createdAt,
  }) : super._(
          id: id,
          userId: userId,
          studyMaterialId: studyMaterialId,
          type: type,
          title: title,
          wordCount: wordCount,
          content: content,
          format: format,
          fileUrl: fileUrl,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [AcademicWriting]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AcademicWriting copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? studyMaterialId = _Undefined,
    String? type,
    String? title,
    Object? wordCount = _Undefined,
    String? content,
    String? format,
    String? fileUrl,
    DateTime? createdAt,
  }) {
    return AcademicWriting(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      studyMaterialId:
          studyMaterialId is int? ? studyMaterialId : this.studyMaterialId,
      type: type ?? this.type,
      title: title ?? this.title,
      wordCount: wordCount is int? ? wordCount : this.wordCount,
      content: content ?? this.content,
      format: format ?? this.format,
      fileUrl: fileUrl ?? this.fileUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
