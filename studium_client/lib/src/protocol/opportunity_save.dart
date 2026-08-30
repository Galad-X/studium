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

abstract class OpportunitySave implements _i1.SerializableModel {
  OpportunitySave._({
    this.id,
    required this.opportunityId,
    required this.userId,
    required this.alertEnabled,
    required this.savedAt,
  });

  factory OpportunitySave({
    int? id,
    required int opportunityId,
    required int userId,
    required bool alertEnabled,
    required DateTime savedAt,
  }) = _OpportunitySaveImpl;

  factory OpportunitySave.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpportunitySave(
      id: jsonSerialization['id'] as int?,
      opportunityId: jsonSerialization['opportunityId'] as int,
      userId: jsonSerialization['userId'] as int,
      alertEnabled: _i1.BoolJsonExtension.fromJson(
        jsonSerialization['alertEnabled'],
      ),
      savedAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['savedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int opportunityId;

  int userId;

  bool alertEnabled;

  DateTime savedAt;

  /// Returns a shallow copy of this [OpportunitySave]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OpportunitySave copyWith({
    int? id,
    int? opportunityId,
    int? userId,
    bool? alertEnabled,
    DateTime? savedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpportunitySave',
      if (id != null) 'id': id,
      'opportunityId': opportunityId,
      'userId': userId,
      'alertEnabled': alertEnabled,
      'savedAt': savedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _OpportunitySaveImpl extends OpportunitySave {
  _OpportunitySaveImpl({
    int? id,
    required int opportunityId,
    required int userId,
    required bool alertEnabled,
    required DateTime savedAt,
  }) : super._(
          id: id,
          opportunityId: opportunityId,
          userId: userId,
          alertEnabled: alertEnabled,
          savedAt: savedAt,
        );

  /// Returns a shallow copy of this [OpportunitySave]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OpportunitySave copyWith({
    Object? id = _Undefined,
    int? opportunityId,
    int? userId,
    bool? alertEnabled,
    DateTime? savedAt,
  }) {
    return OpportunitySave(
      id: id is int? ? id : this.id,
      opportunityId: opportunityId ?? this.opportunityId,
      userId: userId ?? this.userId,
      alertEnabled: alertEnabled ?? this.alertEnabled,
      savedAt: savedAt ?? this.savedAt,
    );
  }
}
