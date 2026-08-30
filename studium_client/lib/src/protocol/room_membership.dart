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

abstract class RoomMembership implements _i1.SerializableModel {
  RoomMembership._({
    this.id,
    required this.roomId,
    required this.userId,
    required this.role,
    required this.status,
    required this.joinedAt,
  });

  factory RoomMembership({
    int? id,
    required int roomId,
    required int userId,
    required String role,
    required String status,
    required DateTime joinedAt,
  }) = _RoomMembershipImpl;

  factory RoomMembership.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomMembership(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      userId: jsonSerialization['userId'] as int,
      role: jsonSerialization['role'] as String,
      status: jsonSerialization['status'] as String,
      joinedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['joinedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  int userId;

  String role;

  String status;

  DateTime joinedAt;

  /// Returns a shallow copy of this [RoomMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoomMembership copyWith({
    int? id,
    int? roomId,
    int? userId,
    String? role,
    String? status,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomMembership',
      if (id != null) 'id': id,
      'roomId': roomId,
      'userId': userId,
      'role': role,
      'status': status,
      'joinedAt': joinedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomMembershipImpl extends RoomMembership {
  _RoomMembershipImpl({
    int? id,
    required int roomId,
    required int userId,
    required String role,
    required String status,
    required DateTime joinedAt,
  }) : super._(
          id: id,
          roomId: roomId,
          userId: userId,
          role: role,
          status: status,
          joinedAt: joinedAt,
        );

  /// Returns a shallow copy of this [RoomMembership]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoomMembership copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? userId,
    String? role,
    String? status,
    DateTime? joinedAt,
  }) {
    return RoomMembership(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
