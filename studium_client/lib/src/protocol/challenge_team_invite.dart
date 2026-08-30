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

abstract class ChallengeTeamInvite implements _i1.SerializableModel {
  ChallengeTeamInvite._({
    this.id,
    required this.teamId,
    required this.inviterId,
    required this.inviteeId,
    required this.tokenHash,
    required this.status,
    required this.expiresAt,
    required this.createdAt,
    this.acceptedAt,
  });

  factory ChallengeTeamInvite({
    int? id,
    required int teamId,
    required int inviterId,
    required int inviteeId,
    required String tokenHash,
    required String status,
    required DateTime expiresAt,
    required DateTime createdAt,
    DateTime? acceptedAt,
  }) = _ChallengeTeamInviteImpl;

  factory ChallengeTeamInvite.fromJson(Map<String, dynamic> jsonSerialization) {
    return ChallengeTeamInvite(
      id: jsonSerialization['id'] as int?,
      teamId: jsonSerialization['teamId'] as int,
      inviterId: jsonSerialization['inviterId'] as int,
      inviteeId: jsonSerialization['inviteeId'] as int,
      tokenHash: jsonSerialization['tokenHash'] as String,
      status: jsonSerialization['status'] as String,
      expiresAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['expiresAt'],
      ),
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
      acceptedAt: jsonSerialization['acceptedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['acceptedAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int teamId;

  int inviterId;

  int inviteeId;

  String tokenHash;

  String status;

  DateTime expiresAt;

  DateTime createdAt;

  DateTime? acceptedAt;

  /// Returns a shallow copy of this [ChallengeTeamInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ChallengeTeamInvite copyWith({
    int? id,
    int? teamId,
    int? inviterId,
    int? inviteeId,
    String? tokenHash,
    String? status,
    DateTime? expiresAt,
    DateTime? createdAt,
    DateTime? acceptedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ChallengeTeamInvite',
      if (id != null) 'id': id,
      'teamId': teamId,
      'inviterId': inviterId,
      'inviteeId': inviteeId,
      'tokenHash': tokenHash,
      'status': status,
      'expiresAt': expiresAt.toJson(),
      'createdAt': createdAt.toJson(),
      if (acceptedAt != null) 'acceptedAt': acceptedAt?.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ChallengeTeamInviteImpl extends ChallengeTeamInvite {
  _ChallengeTeamInviteImpl({
    int? id,
    required int teamId,
    required int inviterId,
    required int inviteeId,
    required String tokenHash,
    required String status,
    required DateTime expiresAt,
    required DateTime createdAt,
    DateTime? acceptedAt,
  }) : super._(
          id: id,
          teamId: teamId,
          inviterId: inviterId,
          inviteeId: inviteeId,
          tokenHash: tokenHash,
          status: status,
          expiresAt: expiresAt,
          createdAt: createdAt,
          acceptedAt: acceptedAt,
        );

  /// Returns a shallow copy of this [ChallengeTeamInvite]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ChallengeTeamInvite copyWith({
    Object? id = _Undefined,
    int? teamId,
    int? inviterId,
    int? inviteeId,
    String? tokenHash,
    String? status,
    DateTime? expiresAt,
    DateTime? createdAt,
    Object? acceptedAt = _Undefined,
  }) {
    return ChallengeTeamInvite(
      id: id is int? ? id : this.id,
      teamId: teamId ?? this.teamId,
      inviterId: inviterId ?? this.inviterId,
      inviteeId: inviteeId ?? this.inviteeId,
      tokenHash: tokenHash ?? this.tokenHash,
      status: status ?? this.status,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      acceptedAt: acceptedAt is DateTime? ? acceptedAt : this.acceptedAt,
    );
  }
}
