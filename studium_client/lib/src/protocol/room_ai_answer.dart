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
import 'package:studium_client/src/protocol/protocol.dart' as _i2;

abstract class RoomAiAnswer implements _i1.SerializableModel {
  RoomAiAnswer._({
    this.id,
    required this.roomId,
    required this.askerId,
    required this.question,
    required this.answer,
    required this.sourceResourceIds,
    required this.citations,
    required this.confidence,
    required this.createdAt,
  });

  factory RoomAiAnswer({
    int? id,
    required int roomId,
    required int askerId,
    required String question,
    required String answer,
    required List<int> sourceResourceIds,
    required List<String> citations,
    required String confidence,
    required DateTime createdAt,
  }) = _RoomAiAnswerImpl;

  factory RoomAiAnswer.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomAiAnswer(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      askerId: jsonSerialization['askerId'] as int,
      question: jsonSerialization['question'] as String,
      answer: jsonSerialization['answer'] as String,
      sourceResourceIds: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['sourceResourceIds'],
      ),
      citations: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['citations'],
      ),
      confidence: jsonSerialization['confidence'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  int askerId;

  String question;

  String answer;

  List<int> sourceResourceIds;

  List<String> citations;

  String confidence;

  DateTime createdAt;

  /// Returns a shallow copy of this [RoomAiAnswer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoomAiAnswer copyWith({
    int? id,
    int? roomId,
    int? askerId,
    String? question,
    String? answer,
    List<int>? sourceResourceIds,
    List<String>? citations,
    String? confidence,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomAiAnswer',
      if (id != null) 'id': id,
      'roomId': roomId,
      'askerId': askerId,
      'question': question,
      'answer': answer,
      'sourceResourceIds': sourceResourceIds.toJson(),
      'citations': citations.toJson(),
      'confidence': confidence,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomAiAnswerImpl extends RoomAiAnswer {
  _RoomAiAnswerImpl({
    int? id,
    required int roomId,
    required int askerId,
    required String question,
    required String answer,
    required List<int> sourceResourceIds,
    required List<String> citations,
    required String confidence,
    required DateTime createdAt,
  }) : super._(
          id: id,
          roomId: roomId,
          askerId: askerId,
          question: question,
          answer: answer,
          sourceResourceIds: sourceResourceIds,
          citations: citations,
          confidence: confidence,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [RoomAiAnswer]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoomAiAnswer copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? askerId,
    String? question,
    String? answer,
    List<int>? sourceResourceIds,
    List<String>? citations,
    String? confidence,
    DateTime? createdAt,
  }) {
    return RoomAiAnswer(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      askerId: askerId ?? this.askerId,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      sourceResourceIds:
          sourceResourceIds ?? this.sourceResourceIds.map((e0) => e0).toList(),
      citations: citations ?? this.citations.map((e0) => e0).toList(),
      confidence: confidence ?? this.confidence,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
