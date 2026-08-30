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

abstract class UserReputation implements _i1.SerializableModel {
  UserReputation._({
    this.id,
    required this.userId,
    int? score,
    int? acceptedSolutions,
    int? verifiedContributions,
    required this.updatedAt,
  }) : score = score ?? 0,
       acceptedSolutions = acceptedSolutions ?? 0,
       verifiedContributions = verifiedContributions ?? 0;

  factory UserReputation({
    int? id,
    required int userId,
    int? score,
    int? acceptedSolutions,
    int? verifiedContributions,
    required DateTime updatedAt,
  }) = _UserReputationImpl;

  factory UserReputation.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserReputation(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      score: jsonSerialization['score'] as int?,
      acceptedSolutions: jsonSerialization['acceptedSolutions'] as int?,
      verifiedContributions: jsonSerialization['verifiedContributions'] as int?,
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

  int score;

  int acceptedSolutions;

  int verifiedContributions;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserReputation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserReputation copyWith({
    int? id,
    int? userId,
    int? score,
    int? acceptedSolutions,
    int? verifiedContributions,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserReputation',
      if (id != null) 'id': id,
      'userId': userId,
      'score': score,
      'acceptedSolutions': acceptedSolutions,
      'verifiedContributions': verifiedContributions,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserReputationImpl extends UserReputation {
  _UserReputationImpl({
    int? id,
    required int userId,
    int? score,
    int? acceptedSolutions,
    int? verifiedContributions,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         score: score,
         acceptedSolutions: acceptedSolutions,
         verifiedContributions: verifiedContributions,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [UserReputation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserReputation copyWith({
    Object? id = _Undefined,
    int? userId,
    int? score,
    int? acceptedSolutions,
    int? verifiedContributions,
    DateTime? updatedAt,
  }) {
    return UserReputation(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      score: score ?? this.score,
      acceptedSolutions: acceptedSolutions ?? this.acceptedSolutions,
      verifiedContributions:
          verifiedContributions ?? this.verifiedContributions,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
