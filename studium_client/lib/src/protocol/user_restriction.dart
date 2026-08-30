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

abstract class UserRestriction implements _i1.SerializableModel {
  UserRestriction._({
    this.id,
    required this.userId,
    required this.restrictionType,
    required this.reason,
    this.expiresAt,
    required this.active,
    required this.createdAt,
  });

  factory UserRestriction({
    int? id,
    required int userId,
    required String restrictionType,
    required String reason,
    DateTime? expiresAt,
    required bool active,
    required DateTime createdAt,
  }) = _UserRestrictionImpl;

  factory UserRestriction.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserRestriction(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      restrictionType: jsonSerialization['restrictionType'] as String,
      reason: jsonSerialization['reason'] as String,
      expiresAt: jsonSerialization['expiresAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['expiresAt']),
      active: _i1.BoolJsonExtension.fromJson(jsonSerialization['active']),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String restrictionType;

  String reason;

  DateTime? expiresAt;

  bool active;

  DateTime createdAt;

  /// Returns a shallow copy of this [UserRestriction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserRestriction copyWith({
    int? id,
    int? userId,
    String? restrictionType,
    String? reason,
    DateTime? expiresAt,
    bool? active,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserRestriction',
      if (id != null) 'id': id,
      'userId': userId,
      'restrictionType': restrictionType,
      'reason': reason,
      if (expiresAt != null) 'expiresAt': expiresAt?.toJson(),
      'active': active,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserRestrictionImpl extends UserRestriction {
  _UserRestrictionImpl({
    int? id,
    required int userId,
    required String restrictionType,
    required String reason,
    DateTime? expiresAt,
    required bool active,
    required DateTime createdAt,
  }) : super._(
         id: id,
         userId: userId,
         restrictionType: restrictionType,
         reason: reason,
         expiresAt: expiresAt,
         active: active,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [UserRestriction]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserRestriction copyWith({
    Object? id = _Undefined,
    int? userId,
    String? restrictionType,
    String? reason,
    Object? expiresAt = _Undefined,
    bool? active,
    DateTime? createdAt,
  }) {
    return UserRestriction(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      restrictionType: restrictionType ?? this.restrictionType,
      reason: reason ?? this.reason,
      expiresAt: expiresAt is DateTime? ? expiresAt : this.expiresAt,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
