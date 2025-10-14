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

abstract class Question implements _i1.SerializableModel {
  Question._({
    this.id,
    required this.studyMaterialId,
    required this.type,
    required this.questionText,
    this.correctAnswer,
    this.options,
    this.explanation,
    required this.difficulty,
    required this.bloomsLevel,
    required this.estimatedTime,
    this.tags,
    this.diagramImageUrl,
    this.labelingPoints,
    required this.createdAt,
  });

  factory Question({
    int? id,
    required int studyMaterialId,
    required String type,
    required String questionText,
    String? correctAnswer,
    List<String>? options,
    String? explanation,
    required String difficulty,
    required String bloomsLevel,
    required int estimatedTime,
    List<String>? tags,
    String? diagramImageUrl,
    List<String>? labelingPoints,
    required DateTime createdAt,
  }) = _QuestionImpl;

  factory Question.fromJson(Map<String, dynamic> jsonSerialization) {
    return Question(
      id: jsonSerialization['id'] as int?,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int,
      type: jsonSerialization['type'] as String,
      questionText: jsonSerialization['questionText'] as String,
      correctAnswer: jsonSerialization['correctAnswer'] as String?,
      options: (jsonSerialization['options'] as List?)
          ?.map((e) => e as String)
          .toList(),
      explanation: jsonSerialization['explanation'] as String?,
      difficulty: jsonSerialization['difficulty'] as String,
      bloomsLevel: jsonSerialization['bloomsLevel'] as String,
      estimatedTime: jsonSerialization['estimatedTime'] as int,
      tags: (jsonSerialization['tags'] as List?)
          ?.map((e) => e as String)
          .toList(),
      diagramImageUrl: jsonSerialization['diagramImageUrl'] as String?,
      labelingPoints: (jsonSerialization['labelingPoints'] as List?)
          ?.map((e) => e as String)
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

  String type;

  String questionText;

  String? correctAnswer;

  List<String>? options;

  String? explanation;

  String difficulty;

  String bloomsLevel;

  int estimatedTime;

  List<String>? tags;

  String? diagramImageUrl;

  List<String>? labelingPoints;

  DateTime createdAt;

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Question copyWith({
    int? id,
    int? studyMaterialId,
    String? type,
    String? questionText,
    String? correctAnswer,
    List<String>? options,
    String? explanation,
    String? difficulty,
    String? bloomsLevel,
    int? estimatedTime,
    List<String>? tags,
    String? diagramImageUrl,
    List<String>? labelingPoints,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'studyMaterialId': studyMaterialId,
      'type': type,
      'questionText': questionText,
      if (correctAnswer != null) 'correctAnswer': correctAnswer,
      if (options != null) 'options': options?.toJson(),
      if (explanation != null) 'explanation': explanation,
      'difficulty': difficulty,
      'bloomsLevel': bloomsLevel,
      'estimatedTime': estimatedTime,
      if (tags != null) 'tags': tags?.toJson(),
      if (diagramImageUrl != null) 'diagramImageUrl': diagramImageUrl,
      if (labelingPoints != null) 'labelingPoints': labelingPoints?.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _QuestionImpl extends Question {
  _QuestionImpl({
    int? id,
    required int studyMaterialId,
    required String type,
    required String questionText,
    String? correctAnswer,
    List<String>? options,
    String? explanation,
    required String difficulty,
    required String bloomsLevel,
    required int estimatedTime,
    List<String>? tags,
    String? diagramImageUrl,
    List<String>? labelingPoints,
    required DateTime createdAt,
  }) : super._(
          id: id,
          studyMaterialId: studyMaterialId,
          type: type,
          questionText: questionText,
          correctAnswer: correctAnswer,
          options: options,
          explanation: explanation,
          difficulty: difficulty,
          bloomsLevel: bloomsLevel,
          estimatedTime: estimatedTime,
          tags: tags,
          diagramImageUrl: diagramImageUrl,
          labelingPoints: labelingPoints,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Question]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Question copyWith({
    Object? id = _Undefined,
    int? studyMaterialId,
    String? type,
    String? questionText,
    Object? correctAnswer = _Undefined,
    Object? options = _Undefined,
    Object? explanation = _Undefined,
    String? difficulty,
    String? bloomsLevel,
    int? estimatedTime,
    Object? tags = _Undefined,
    Object? diagramImageUrl = _Undefined,
    Object? labelingPoints = _Undefined,
    DateTime? createdAt,
  }) {
    return Question(
      id: id is int? ? id : this.id,
      studyMaterialId: studyMaterialId ?? this.studyMaterialId,
      type: type ?? this.type,
      questionText: questionText ?? this.questionText,
      correctAnswer:
          correctAnswer is String? ? correctAnswer : this.correctAnswer,
      options: options is List<String>?
          ? options
          : this.options?.map((e0) => e0).toList(),
      explanation: explanation is String? ? explanation : this.explanation,
      difficulty: difficulty ?? this.difficulty,
      bloomsLevel: bloomsLevel ?? this.bloomsLevel,
      estimatedTime: estimatedTime ?? this.estimatedTime,
      tags: tags is List<String>? ? tags : this.tags?.map((e0) => e0).toList(),
      diagramImageUrl:
          diagramImageUrl is String? ? diagramImageUrl : this.diagramImageUrl,
      labelingPoints: labelingPoints is List<String>?
          ? labelingPoints
          : this.labelingPoints?.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
