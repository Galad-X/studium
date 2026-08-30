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

abstract class Answer implements _i1.SerializableModel {
  Answer._({
    this.id,
    required this.userId,
    required this.questionId,
    required this.answerText,
    this.score,
    this.feedback,
    required this.submittedAt,
  });

  factory Answer({
    int? id,
    required int userId,
    required int questionId,
    required String answerText,
    double? score,
    String? feedback,
    required DateTime submittedAt,
  }) = _AnswerImpl;

  factory Answer.fromJson(Map<String, dynamic> jsonSerialization) {
    return Answer(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      questionId: jsonSerialization['questionId'] as int,
      answerText: jsonSerialization['answerText'] as String,
      score: (jsonSerialization['score'] as num?)?.toDouble(),
      feedback: jsonSerialization['feedback'] as String?,
      submittedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['submittedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int questionId;

  String answerText;

  double? score;

  String? feedback;

  DateTime submittedAt;

  /// Returns a shallow copy of this [Answer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Answer copyWith({
    int? id,
    int? userId,
    int? questionId,
    String? answerText,
    double? score,
    String? feedback,
    DateTime? submittedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Answer',
      if (id != null) 'id': id,
      'userId': userId,
      'questionId': questionId,
      'answerText': answerText,
      if (score != null) 'score': score,
      if (feedback != null) 'feedback': feedback,
      'submittedAt': submittedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AnswerImpl extends Answer {
  _AnswerImpl({
    int? id,
    required int userId,
    required int questionId,
    required String answerText,
    double? score,
    String? feedback,
    required DateTime submittedAt,
  }) : super._(
          id: id,
          userId: userId,
          questionId: questionId,
          answerText: answerText,
          score: score,
          feedback: feedback,
          submittedAt: submittedAt,
        );

  /// Returns a shallow copy of this [Answer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Answer copyWith({
    Object? id = _Undefined,
    int? userId,
    int? questionId,
    String? answerText,
    Object? score = _Undefined,
    Object? feedback = _Undefined,
    DateTime? submittedAt,
  }) {
    return Answer(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      questionId: questionId ?? this.questionId,
      answerText: answerText ?? this.answerText,
      score: score is double? ? score : this.score,
      feedback: feedback is String? ? feedback : this.feedback,
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }
}
