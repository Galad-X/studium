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

abstract class ResearchComparison implements _i1.SerializableModel {
  ResearchComparison._({
    this.id,
    this.summaryId,
    required this.studyMaterialId,
    required this.newerFindings,
    required this.unsolvedProblems,
    required this.createdAt,
  });

  factory ResearchComparison({
    int? id,
    int? summaryId,
    required int studyMaterialId,
    required String newerFindings,
    required List<String> unsolvedProblems,
    required DateTime createdAt,
  }) = _ResearchComparisonImpl;

  factory ResearchComparison.fromJson(Map<String, dynamic> jsonSerialization) {
    return ResearchComparison(
      id: jsonSerialization['id'] as int?,
      summaryId: jsonSerialization['summaryId'] as int?,
      studyMaterialId: jsonSerialization['studyMaterialId'] as int,
      newerFindings: jsonSerialization['newerFindings'] as String,
      unsolvedProblems: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['unsolvedProblems'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int? summaryId;

  int studyMaterialId;

  String newerFindings;

  List<String> unsolvedProblems;

  DateTime createdAt;

  /// Returns a shallow copy of this [ResearchComparison]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ResearchComparison copyWith({
    int? id,
    int? summaryId,
    int? studyMaterialId,
    String? newerFindings,
    List<String>? unsolvedProblems,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ResearchComparison',
      if (id != null) 'id': id,
      if (summaryId != null) 'summaryId': summaryId,
      'studyMaterialId': studyMaterialId,
      'newerFindings': newerFindings,
      'unsolvedProblems': unsolvedProblems.toJson(),
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ResearchComparisonImpl extends ResearchComparison {
  _ResearchComparisonImpl({
    int? id,
    int? summaryId,
    required int studyMaterialId,
    required String newerFindings,
    required List<String> unsolvedProblems,
    required DateTime createdAt,
  }) : super._(
          id: id,
          summaryId: summaryId,
          studyMaterialId: studyMaterialId,
          newerFindings: newerFindings,
          unsolvedProblems: unsolvedProblems,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [ResearchComparison]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ResearchComparison copyWith({
    Object? id = _Undefined,
    Object? summaryId = _Undefined,
    int? studyMaterialId,
    String? newerFindings,
    List<String>? unsolvedProblems,
    DateTime? createdAt,
  }) {
    return ResearchComparison(
      id: id is int? ? id : this.id,
      summaryId: summaryId is int? ? summaryId : this.summaryId,
      studyMaterialId: studyMaterialId ?? this.studyMaterialId,
      newerFindings: newerFindings ?? this.newerFindings,
      unsolvedProblems:
          unsolvedProblems ?? this.unsolvedProblems.map((e0) => e0).toList(),
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
