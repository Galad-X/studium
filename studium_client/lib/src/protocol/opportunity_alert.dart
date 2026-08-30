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

abstract class OpportunityAlert implements _i1.SerializableModel {
  OpportunityAlert._({
    this.id,
    required this.userId,
    this.country,
    this.field,
    this.educationLevel,
    required this.opportunityTypes,
    required this.deadlineWithinDays,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OpportunityAlert({
    int? id,
    required int userId,
    String? country,
    String? field,
    String? educationLevel,
    required List<String> opportunityTypes,
    required int deadlineWithinDays,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OpportunityAlertImpl;

  factory OpportunityAlert.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpportunityAlert(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      country: jsonSerialization['country'] as String?,
      field: jsonSerialization['field'] as String?,
      educationLevel: jsonSerialization['educationLevel'] as String?,
      opportunityTypes: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['opportunityTypes'],
      ),
      deadlineWithinDays: jsonSerialization['deadlineWithinDays'] as int,
      active: _i1.BoolJsonExtension.fromJson(jsonSerialization['active']),
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

  int userId;

  String? country;

  String? field;

  String? educationLevel;

  List<String> opportunityTypes;

  int deadlineWithinDays;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [OpportunityAlert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OpportunityAlert copyWith({
    int? id,
    int? userId,
    String? country,
    String? field,
    String? educationLevel,
    List<String>? opportunityTypes,
    int? deadlineWithinDays,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpportunityAlert',
      if (id != null) 'id': id,
      'userId': userId,
      if (country != null) 'country': country,
      if (field != null) 'field': field,
      if (educationLevel != null) 'educationLevel': educationLevel,
      'opportunityTypes': opportunityTypes.toJson(),
      'deadlineWithinDays': deadlineWithinDays,
      'active': active,
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

class _OpportunityAlertImpl extends OpportunityAlert {
  _OpportunityAlertImpl({
    int? id,
    required int userId,
    String? country,
    String? field,
    String? educationLevel,
    required List<String> opportunityTypes,
    required int deadlineWithinDays,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          country: country,
          field: field,
          educationLevel: educationLevel,
          opportunityTypes: opportunityTypes,
          deadlineWithinDays: deadlineWithinDays,
          active: active,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [OpportunityAlert]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OpportunityAlert copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? country = _Undefined,
    Object? field = _Undefined,
    Object? educationLevel = _Undefined,
    List<String>? opportunityTypes,
    int? deadlineWithinDays,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OpportunityAlert(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      country: country is String? ? country : this.country,
      field: field is String? ? field : this.field,
      educationLevel:
          educationLevel is String? ? educationLevel : this.educationLevel,
      opportunityTypes:
          opportunityTypes ?? this.opportunityTypes.map((e0) => e0).toList(),
      deadlineWithinDays: deadlineWithinDays ?? this.deadlineWithinDays,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
