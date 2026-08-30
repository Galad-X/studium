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

abstract class InstitutionInvite implements _i1.SerializableModel {
  InstitutionInvite._({
    this.id,
    required this.institutionId,
    required this.createdById,
    required this.tokenHash,
    required this.expiresAt,
    required this.maxUses,
    required this.uses,
    required this.status,
    required this.createdAt,
  });

  factory InstitutionInvite({
    int? id,
    required int institutionId,
    required int createdById,
    required String tokenHash,
    required DateTime expiresAt,
    required int maxUses,
    required int uses,
    required String status,
    required DateTime createdAt,
  }) = _InstitutionInviteImpl;

  factory InstitutionInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return InstitutionInvite(
      id: jsonSerialization['id'] as int?,
      institutionId: jsonSerialization['institutionId'] as int,
      createdById: jsonSerialization['createdById'] as int,
      tokenHash: jsonSerialization['tokenHash'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      maxUses: jsonSerialization['maxUses'] as int,
      uses: jsonSerialization['uses'] as int,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int institutionId;

  int createdById;

  String tokenHash;

  DateTime expiresAt;

  int maxUses;

  int uses;

  String status;

  DateTime createdAt;

  /// Returns a shallow copy of this [InstitutionInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InstitutionInvite copyWith({
    int? id,
    int? institutionId,
    int? createdById,
    String? tokenHash,
    DateTime? expiresAt,
    int? maxUses,
    int? uses,
    String? status,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InstitutionInvite',
      if (id != null) 'id': id,
      'institutionId': institutionId,
      'createdById': createdById,
      'tokenHash': tokenHash,
      'expiresAt': expiresAt.toJson(),
      'maxUses': maxUses,
      'uses': uses,
      'status': status,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InstitutionInviteImpl extends InstitutionInvite {
  _InstitutionInviteImpl({
    int? id,
    required int institutionId,
    required int createdById,
    required String tokenHash,
    required DateTime expiresAt,
    required int maxUses,
    required int uses,
    required String status,
    required DateTime createdAt,
  }) : super._(
          id: id,
          institutionId: institutionId,
          createdById: createdById,
          tokenHash: tokenHash,
          expiresAt: expiresAt,
          maxUses: maxUses,
          uses: uses,
          status: status,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [InstitutionInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InstitutionInvite copyWith({
    Object? id = _Undefined,
    int? institutionId,
    int? createdById,
    String? tokenHash,
    DateTime? expiresAt,
    int? maxUses,
    int? uses,
    String? status,
    DateTime? createdAt,
  }) {
    return InstitutionInvite(
      id: id is int? ? id : this.id,
      institutionId: institutionId ?? this.institutionId,
      createdById: createdById ?? this.createdById,
      tokenHash: tokenHash ?? this.tokenHash,
      expiresAt: expiresAt ?? this.expiresAt,
      maxUses: maxUses ?? this.maxUses,
      uses: uses ?? this.uses,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
