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
import 'study_history.dart' as _i2;
import 'study_materials.dart' as _i3;
import 'summaries.dart' as _i4;

abstract class DashboardBundle implements _i1.SerializableModel {
  DashboardBundle._({
    required this.history,
    required this.recentMaterials,
    required this.recentSummaries,
  });

  factory DashboardBundle({
    required _i2.StudyHistory history,
    required List<_i3.StudyMaterial> recentMaterials,
    required List<_i4.Summary> recentSummaries,
  }) = _DashboardBundleImpl;

  factory DashboardBundle.fromJson(Map<String, dynamic> jsonSerialization) {
    return DashboardBundle(
      history: _i2.StudyHistory.fromJson(
          (jsonSerialization['history'] as Map<String, dynamic>)),
      recentMaterials: (jsonSerialization['recentMaterials'] as List)
          .map((e) => _i3.StudyMaterial.fromJson((e as Map<String, dynamic>)))
          .toList(),
      recentSummaries: (jsonSerialization['recentSummaries'] as List)
          .map((e) => _i4.Summary.fromJson((e as Map<String, dynamic>)))
          .toList(),
    );
  }

  _i2.StudyHistory history;

  List<_i3.StudyMaterial> recentMaterials;

  List<_i4.Summary> recentSummaries;

  /// Returns a shallow copy of this [DashboardBundle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  DashboardBundle copyWith({
    _i2.StudyHistory? history,
    List<_i3.StudyMaterial>? recentMaterials,
    List<_i4.Summary>? recentSummaries,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      'history': history.toJson(),
      'recentMaterials': recentMaterials.toJson(valueToJson: (v) => v.toJson()),
      'recentSummaries': recentSummaries.toJson(valueToJson: (v) => v.toJson()),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _DashboardBundleImpl extends DashboardBundle {
  _DashboardBundleImpl({
    required _i2.StudyHistory history,
    required List<_i3.StudyMaterial> recentMaterials,
    required List<_i4.Summary> recentSummaries,
  }) : super._(
          history: history,
          recentMaterials: recentMaterials,
          recentSummaries: recentSummaries,
        );

  /// Returns a shallow copy of this [DashboardBundle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  DashboardBundle copyWith({
    _i2.StudyHistory? history,
    List<_i3.StudyMaterial>? recentMaterials,
    List<_i4.Summary>? recentSummaries,
  }) {
    return DashboardBundle(
      history: history ?? this.history.copyWith(),
      recentMaterials: recentMaterials ??
          this.recentMaterials.map((e0) => e0.copyWith()).toList(),
      recentSummaries: recentSummaries ??
          this.recentSummaries.map((e0) => e0.copyWith()).toList(),
    );
  }
}
