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

abstract class FileProcessing implements _i1.SerializableModel {
  FileProcessing._({
    this.id,
    required this.studyMaterialId,
    required this.status,
    this.processedText,
    this.errorMessage,
    required this.attempts,
    required this.maxAttempts,
    this.lastStartedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory FileProcessing({
    int? id,
    required int studyMaterialId,
    required String status,
    String? processedText,
    String? errorMessage,
    required int attempts,
    required int maxAttempts,
    DateTime? lastStartedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _FileProcessingImpl;

  factory FileProcessing.fromJson(Map<String, dynamic> jsonSerialization) {
    return FileProcessing(
      id: jsonSerialization['id'] as int?,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int,
      status: jsonSerialization['status'] as String,
      processedText: jsonSerialization['processedText'] as String?,
      errorMessage: jsonSerialization['errorMessage'] as String?,
      attempts: jsonSerialization['attempts'] as int,
      maxAttempts: jsonSerialization['maxAttempts'] as int,
      lastStartedAt: jsonSerialization['lastStartedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastStartedAt'],
            ),
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

  int studyMaterialId;

  String status;

  String? processedText;

  String? errorMessage;

  int attempts;

  int maxAttempts;

  DateTime? lastStartedAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [FileProcessing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  FileProcessing copyWith({
    int? id,
    int? studyMaterialId,
    String? status,
    String? processedText,
    String? errorMessage,
    int? attempts,
    int? maxAttempts,
    DateTime? lastStartedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'FileProcessing',
      if (id != null) 'id': id,
      'studyMaterialId': studyMaterialId,
      'status': status,
      if (processedText != null) 'processedText': processedText,
      if (errorMessage != null) 'errorMessage': errorMessage,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      if (lastStartedAt != null) 'lastStartedAt': lastStartedAt?.toJson(),
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

class _FileProcessingImpl extends FileProcessing {
  _FileProcessingImpl({
    int? id,
    required int studyMaterialId,
    required String status,
    String? processedText,
    String? errorMessage,
    required int attempts,
    required int maxAttempts,
    DateTime? lastStartedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         studyMaterialId: studyMaterialId,
         status: status,
         processedText: processedText,
         errorMessage: errorMessage,
         attempts: attempts,
         maxAttempts: maxAttempts,
         lastStartedAt: lastStartedAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [FileProcessing]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  FileProcessing copyWith({
    Object? id = _Undefined,
    int? studyMaterialId,
    String? status,
    Object? processedText = _Undefined,
    Object? errorMessage = _Undefined,
    int? attempts,
    int? maxAttempts,
    Object? lastStartedAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return FileProcessing(
      id: id is int? ? id : this.id,
      studyMaterialId: studyMaterialId ?? this.studyMaterialId,
      status: status ?? this.status,
      processedText: processedText is String?
          ? processedText
          : this.processedText,
      errorMessage: errorMessage is String? ? errorMessage : this.errorMessage,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      lastStartedAt: lastStartedAt is DateTime?
          ? lastStartedAt
          : this.lastStartedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
