/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Summary implements _i1.SerializableModel {
  Summary._({
    this.id,
    required this.studyMaterialId,
    required this.userId,
    required this.isPremium,
    required this.subject,
    required this.topic,
    this.wordCount,
    this.introduction,
    required this.subtopics,
    required this.nuggets,
    required this.createdAt,
  });

  factory Summary({
    int? id,
    required int studyMaterialId,
    required int userId,
    required bool isPremium,
    required String subject,
    required String topic,
    int? wordCount,
    String? introduction,
    required List<String> subtopics,
    required List<String> nuggets,
    required DateTime createdAt,
  }) = _SummaryImpl;

  factory Summary.fromJson(Map<String, dynamic> jsonSerialization) {
    return Summary(
      id: jsonSerialization['id'] as int?,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int,
      userId: jsonSerialization['userId'] as int,
      isPremium: jsonSerialization['isPremium'] as bool,
      subject: jsonSerialization['subject'] as String,
      topic: jsonSerialization['topic'] as String,
      wordCount: jsonSerialization['wordCount'] as int?,
      introduction: jsonSerialization['introduction'] as String?,
      subtopics: (jsonSerialization['subtopics'] as List)
          .map((e) => e as String)
          .toList(),
      nuggets: (jsonSerialization['nuggets'] as List)
          .map((e) => e as String)
          .toList(),
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int studyMaterialId;

  int userId;

  bool isPremium;

  String subject;

  String topic;

  int? wordCount;

  String? introduction;

  List<String> subtopics;

  List<String> nuggets;

  DateTime createdAt;

  /// Returns a shallow copy of this [Summary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Summary copyWith({
    int? id,
    int? studyMaterialId,
    int? userId,
    bool? isPremium,
    String? subject,
    String? topic,
    int? wordCount,
    String? introduction,
    List<String>? subtopics,
    List<String>? nuggets,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'studyMaterialId': studyMaterialId,
      'userId': userId,
      'isPremium': isPremium,
      'subject': subject,
      'topic': topic,
      if (wordCount != null) 'wordCount': wordCount,
      if (introduction != null) 'introduction': introduction,
      'subtopics': subtopics.toJson(),
      'nuggets': nuggets.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SummaryImpl extends Summary {
  _SummaryImpl({
    int? id,
    required int studyMaterialId,
    required int userId,
    required bool isPremium,
    required String subject,
    required String topic,
    int? wordCount,
    String? introduction,
    required List<String> subtopics,
    required List<String> nuggets,
    required DateTime createdAt,
  }) : super._(
          id: id,
          studyMaterialId: studyMaterialId,
          userId: userId,
          isPremium: isPremium,
          subject: subject,
          topic: topic,
          wordCount: wordCount,
          introduction: introduction,
          subtopics: subtopics,
          nuggets: nuggets,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Summary]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Summary copyWith({
    Object? id = _Undefined,
    int? studyMaterialId,
    int? userId,
    bool? isPremium,
    String? subject,
    String? topic,
    Object? wordCount = _Undefined,
    Object? introduction = _Undefined,
    List<String>? subtopics,
    List<String>? nuggets,
    DateTime? createdAt,
  }) {
    return Summary(
      id: id is int? ? id : this.id,
      studyMaterialId: studyMaterialId ?? this.studyMaterialId,
      userId: userId ?? this.userId,
      isPremium: isPremium ?? this.isPremium,
      subject: subject ?? this.subject,
      topic: topic ?? this.topic,
      wordCount: wordCount is int? ? wordCount : this.wordCount,
      introduction: introduction is String? ? introduction : this.introduction,
      subtopics: subtopics ?? this.subtopics.map((e0) => e0).toList(),
      nuggets: nuggets ?? this.nuggets.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
