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

abstract class UserSafetyRelationship implements _i1.SerializableModel {
  UserSafetyRelationship._({
    this.id,
    required this.userId,
    required this.targetUserId,
    required this.relationshipType,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserSafetyRelationship({
    int? id,
    required int userId,
    required int targetUserId,
    required String relationshipType,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _UserSafetyRelationshipImpl;

  factory UserSafetyRelationship.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return UserSafetyRelationship(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      targetUserId: jsonSerialization['targetUserId'] as int,
      relationshipType: jsonSerialization['relationshipType'] as String,
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

  int targetUserId;

  String relationshipType;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserSafetyRelationship]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserSafetyRelationship copyWith({
    int? id,
    int? userId,
    int? targetUserId,
    String? relationshipType,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserSafetyRelationship',
      if (id != null) 'id': id,
      'userId': userId,
      'targetUserId': targetUserId,
      'relationshipType': relationshipType,
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

class _UserSafetyRelationshipImpl extends UserSafetyRelationship {
  _UserSafetyRelationshipImpl({
    int? id,
    required int userId,
    required int targetUserId,
    required String relationshipType,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         targetUserId: targetUserId,
         relationshipType: relationshipType,
         active: active,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserSafetyRelationship]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserSafetyRelationship copyWith({
    Object? id = _Undefined,
    int? userId,
    int? targetUserId,
    String? relationshipType,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserSafetyRelationship(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      targetUserId: targetUserId ?? this.targetUserId,
      relationshipType: relationshipType ?? this.relationshipType,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
