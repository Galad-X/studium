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

abstract class StudyMaterial implements _i1.SerializableModel {
  StudyMaterial._({
    this.id,
    required this.userId,
    required this.title,
    required this.fileType,
    required this.fileUrl,
    required this.uploadDate,
    this.size,
    this.contentText,
  });

  factory StudyMaterial({
    int? id,
    required int userId,
    required String title,
    required String fileType,
    required String fileUrl,
    required DateTime uploadDate,
    int? size,
    String? contentText,
  }) = _StudyMaterialImpl;

  factory StudyMaterial.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyMaterial(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      title: jsonSerialization['title'] as String,
      fileType: jsonSerialization['fileType'] as String,
      fileUrl: jsonSerialization['fileUrl'] as String,
      uploadDate: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['uploadDate'],
      ),
      size: jsonSerialization['size'] as int?,
      contentText: jsonSerialization['contentText'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String title;

  String fileType;

  String fileUrl;

  DateTime uploadDate;

  int? size;

  String? contentText;

  /// Returns a shallow copy of this [StudyMaterial]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudyMaterial copyWith({
    int? id,
    int? userId,
    String? title,
    String? fileType,
    String? fileUrl,
    DateTime? uploadDate,
    int? size,
    String? contentText,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyMaterial',
      if (id != null) 'id': id,
      'userId': userId,
      'title': title,
      'fileType': fileType,
      'fileUrl': fileUrl,
      'uploadDate': uploadDate.toJson(),
      if (size != null) 'size': size,
      if (contentText != null) 'contentText': contentText,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyMaterialImpl extends StudyMaterial {
  _StudyMaterialImpl({
    int? id,
    required int userId,
    required String title,
    required String fileType,
    required String fileUrl,
    required DateTime uploadDate,
    int? size,
    String? contentText,
  }) : super._(
          id: id,
          userId: userId,
          title: title,
          fileType: fileType,
          fileUrl: fileUrl,
          uploadDate: uploadDate,
          size: size,
          contentText: contentText,
        );

  /// Returns a shallow copy of this [StudyMaterial]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudyMaterial copyWith({
    Object? id = _Undefined,
    int? userId,
    String? title,
    String? fileType,
    String? fileUrl,
    DateTime? uploadDate,
    Object? size = _Undefined,
    Object? contentText = _Undefined,
  }) {
    return StudyMaterial(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      fileType: fileType ?? this.fileType,
      fileUrl: fileUrl ?? this.fileUrl,
      uploadDate: uploadDate ?? this.uploadDate,
      size: size is int? ? size : this.size,
      contentText: contentText is String? ? contentText : this.contentText,
    );
  }
}
