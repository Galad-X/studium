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

abstract class StudyHistory implements _i1.SerializableModel {
  StudyHistory._({
    this.id,
    required this.userId,
    required this.materialIds,
    required this.questionIds,
    required this.summaryIds,
    required this.writingIds,
    this.progress,
    required this.lastUpdated,
  });

  factory StudyHistory({
    int? id,
    required int userId,
    required List<int> materialIds,
    required List<int> questionIds,
    required List<int> summaryIds,
    required List<int> writingIds,
    double? progress,
    required DateTime lastUpdated,
  }) = _StudyHistoryImpl;

  factory StudyHistory.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyHistory(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      materialIds: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['materialIds'],
      ),
      questionIds: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['questionIds'],
      ),
      summaryIds: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['summaryIds'],
      ),
      writingIds: _i2.Protocol().deserialize<List<int>>(
        jsonSerialization['writingIds'],
      ),
      progress: (jsonSerialization['progress'] as num?)?.toDouble(),
      lastUpdated: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['lastUpdated'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  List<int> materialIds;

  List<int> questionIds;

  List<int> summaryIds;

  List<int> writingIds;

  double? progress;

  DateTime lastUpdated;

  /// Returns a shallow copy of this [StudyHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudyHistory copyWith({
    int? id,
    int? userId,
    List<int>? materialIds,
    List<int>? questionIds,
    List<int>? summaryIds,
    List<int>? writingIds,
    double? progress,
    DateTime? lastUpdated,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyHistory',
      if (id != null) 'id': id,
      'userId': userId,
      'materialIds': materialIds.toJson(),
      'questionIds': questionIds.toJson(),
      'summaryIds': summaryIds.toJson(),
      'writingIds': writingIds.toJson(),
      if (progress != null) 'progress': progress,
      'lastUpdated': lastUpdated.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _StudyHistoryImpl extends StudyHistory {
  _StudyHistoryImpl({
    int? id,
    required int userId,
    required List<int> materialIds,
    required List<int> questionIds,
    required List<int> summaryIds,
    required List<int> writingIds,
    double? progress,
    required DateTime lastUpdated,
  }) : super._(
         id: id,
         userId: userId,
         materialIds: materialIds,
         questionIds: questionIds,
         summaryIds: summaryIds,
         writingIds: writingIds,
         progress: progress,
         lastUpdated: lastUpdated,
       );

  /// Returns a shallow copy of this [StudyHistory]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudyHistory copyWith({
    Object? id = _Undefined,
    int? userId,
    List<int>? materialIds,
    List<int>? questionIds,
    List<int>? summaryIds,
    List<int>? writingIds,
    Object? progress = _Undefined,
    DateTime? lastUpdated,
  }) {
    return StudyHistory(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      materialIds: materialIds ?? this.materialIds.map((e0) => e0).toList(),
      questionIds: questionIds ?? this.questionIds.map((e0) => e0).toList(),
      summaryIds: summaryIds ?? this.summaryIds.map((e0) => e0).toList(),
      writingIds: writingIds ?? this.writingIds.map((e0) => e0).toList(),
      progress: progress is double? ? progress : this.progress,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
