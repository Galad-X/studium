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

abstract class RoomWhiteboardState implements _i1.SerializableModel {
  RoomWhiteboardState._({
    this.id,
    required this.roomId,
    int? version,
    required this.strokesJson,
    required this.updatedById,
    required this.updatedAt,
  }) : version = version ?? 0;

  factory RoomWhiteboardState({
    int? id,
    required int roomId,
    int? version,
    required String strokesJson,
    required int updatedById,
    required DateTime updatedAt,
  }) = _RoomWhiteboardStateImpl;

  factory RoomWhiteboardState.fromJson(Map<String, dynamic> jsonSerialization) {
    return RoomWhiteboardState(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      version: jsonSerialization['version'] as int?,
      strokesJson: jsonSerialization['strokesJson'] as String,
      updatedById: jsonSerialization['updatedById'] as int,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int roomId;

  int version;

  String strokesJson;

  int updatedById;

  DateTime updatedAt;

  /// Returns a shallow copy of this [RoomWhiteboardState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  RoomWhiteboardState copyWith({
    int? id,
    int? roomId,
    int? version,
    String? strokesJson,
    int? updatedById,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'RoomWhiteboardState',
      if (id != null) 'id': id,
      'roomId': roomId,
      'version': version,
      'strokesJson': strokesJson,
      'updatedById': updatedById,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RoomWhiteboardStateImpl extends RoomWhiteboardState {
  _RoomWhiteboardStateImpl({
    int? id,
    required int roomId,
    int? version,
    required String strokesJson,
    required int updatedById,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          roomId: roomId,
          version: version,
          strokesJson: strokesJson,
          updatedById: updatedById,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [RoomWhiteboardState]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  RoomWhiteboardState copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? version,
    String? strokesJson,
    int? updatedById,
    DateTime? updatedAt,
  }) {
    return RoomWhiteboardState(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      version: version ?? this.version,
      strokesJson: strokesJson ?? this.strokesJson,
      updatedById: updatedById ?? this.updatedById,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
