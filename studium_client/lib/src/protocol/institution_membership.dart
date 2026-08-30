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

abstract class InstitutionMembership implements _i1.SerializableModel {
  InstitutionMembership._({
    this.id,
    required this.userId,
    required this.institutionId,
    required this.role,
    required this.verificationMethod,
    required this.status,
    required this.createdAt,
    this.verifiedAt,
  });

  factory InstitutionMembership({
    int? id,
    required int userId,
    required int institutionId,
    required String role,
    required String verificationMethod,
    required String status,
    required DateTime createdAt,
    DateTime? verifiedAt,
  }) = _InstitutionMembershipImpl;

  factory InstitutionMembership.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return InstitutionMembership(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      institutionId: jsonSerialization['institutionId'] as int,
      role: jsonSerialization['role'] as String,
      verificationMethod: jsonSerialization['verificationMethod'] as String,
      status: jsonSerialization['status'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      verifiedAt: jsonSerialization['verifiedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['verifiedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  int institutionId;

  String role;

  String verificationMethod;

  String status;

  DateTime createdAt;

  DateTime? verifiedAt;

  /// Returns a shallow copy of this [InstitutionMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  InstitutionMembership copyWith({
    int? id,
    int? userId,
    int? institutionId,
    String? role,
    String? verificationMethod,
    String? status,
    DateTime? createdAt,
    DateTime? verifiedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'InstitutionMembership',
      if (id != null) 'id': id,
      'userId': userId,
      'institutionId': institutionId,
      'role': role,
      'verificationMethod': verificationMethod,
      'status': status,
      'createdAt': createdAt.toJson(),
      if (verifiedAt != null) 'verifiedAt': verifiedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InstitutionMembershipImpl extends InstitutionMembership {
  _InstitutionMembershipImpl({
    int? id,
    required int userId,
    required int institutionId,
    required String role,
    required String verificationMethod,
    required String status,
    required DateTime createdAt,
    DateTime? verifiedAt,
  }) : super._(
          id: id,
          userId: userId,
          institutionId: institutionId,
          role: role,
          verificationMethod: verificationMethod,
          status: status,
          createdAt: createdAt,
          verifiedAt: verifiedAt,
        );

  /// Returns a shallow copy of this [InstitutionMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  InstitutionMembership copyWith({
    Object? id = _Undefined,
    int? userId,
    int? institutionId,
    String? role,
    String? verificationMethod,
    String? status,
    DateTime? createdAt,
    Object? verifiedAt = _Undefined,
  }) {
    return InstitutionMembership(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      institutionId: institutionId ?? this.institutionId,
      role: role ?? this.role,
      verificationMethod: verificationMethod ?? this.verificationMethod,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      verifiedAt: verifiedAt is DateTime? ? verifiedAt : this.verifiedAt,
    );
  }
}
