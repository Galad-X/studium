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

abstract class PushDevice implements _i1.SerializableModel {
  PushDevice._({
    this.id,
    required this.userId,
    required this.token,
    required this.platform,
    required this.active,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PushDevice({
    int? id,
    required int userId,
    required String token,
    required String platform,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _PushDeviceImpl;

  factory PushDevice.fromJson(Map<String, dynamic> jsonSerialization) {
    return PushDevice(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      token: jsonSerialization['token'] as String,
      platform: jsonSerialization['platform'] as String,
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

  String token;

  String platform;

  bool active;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [PushDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  PushDevice copyWith({
    int? id,
    int? userId,
    String? token,
    String? platform,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'PushDevice',
      if (id != null) 'id': id,
      'userId': userId,
      'token': token,
      'platform': platform,
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

class _PushDeviceImpl extends PushDevice {
  _PushDeviceImpl({
    int? id,
    required int userId,
    required String token,
    required String platform,
    required bool active,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          token: token,
          platform: platform,
          active: active,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [PushDevice]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  PushDevice copyWith({
    Object? id = _Undefined,
    int? userId,
    String? token,
    String? platform,
    bool? active,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PushDevice(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      token: token ?? this.token,
      platform: platform ?? this.platform,
      active: active ?? this.active,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
