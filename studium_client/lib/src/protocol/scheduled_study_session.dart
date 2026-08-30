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

abstract class ScheduledStudySession implements _i1.SerializableModel {
  ScheduledStudySession._({
    this.id,
    required this.roomId,
    required this.organizerId,
    required this.title,
    this.description,
    required this.startsAt,
    required this.endsAt,
    this.meetingUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ScheduledStudySession({
    int? id,
    required int roomId,
    required int organizerId,
    required String title,
    String? description,
    required DateTime startsAt,
    required DateTime endsAt,
    String? meetingUrl,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ScheduledStudySessionImpl;

  factory ScheduledStudySession.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ScheduledStudySession(
      id: jsonSerialization['id'] as int?,
      roomId: jsonSerialization['roomId'] as int,
      organizerId: jsonSerialization['organizerId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String?,
      startsAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['startsAt'],
      ),
      endsAt: _i1.DateTimeJsonExtension.fromJson(jsonSerialization['endsAt']),
      meetingUrl: jsonSerialization['meetingUrl'] as String?,
      status: jsonSerialization['status'] as String,
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

  int roomId;

  int organizerId;

  String title;

  String? description;

  DateTime startsAt;

  DateTime endsAt;

  String? meetingUrl;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ScheduledStudySession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ScheduledStudySession copyWith({
    int? id,
    int? roomId,
    int? organizerId,
    String? title,
    String? description,
    DateTime? startsAt,
    DateTime? endsAt,
    String? meetingUrl,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ScheduledStudySession',
      if (id != null) 'id': id,
      'roomId': roomId,
      'organizerId': organizerId,
      'title': title,
      if (description != null) 'description': description,
      'startsAt': startsAt.toJson(),
      'endsAt': endsAt.toJson(),
      if (meetingUrl != null) 'meetingUrl': meetingUrl,
      'status': status,
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

class _ScheduledStudySessionImpl extends ScheduledStudySession {
  _ScheduledStudySessionImpl({
    int? id,
    required int roomId,
    required int organizerId,
    required String title,
    String? description,
    required DateTime startsAt,
    required DateTime endsAt,
    String? meetingUrl,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          roomId: roomId,
          organizerId: organizerId,
          title: title,
          description: description,
          startsAt: startsAt,
          endsAt: endsAt,
          meetingUrl: meetingUrl,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [ScheduledStudySession]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ScheduledStudySession copyWith({
    Object? id = _Undefined,
    int? roomId,
    int? organizerId,
    String? title,
    Object? description = _Undefined,
    DateTime? startsAt,
    DateTime? endsAt,
    Object? meetingUrl = _Undefined,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ScheduledStudySession(
      id: id is int? ? id : this.id,
      roomId: roomId ?? this.roomId,
      organizerId: organizerId ?? this.organizerId,
      title: title ?? this.title,
      description: description is String? ? description : this.description,
      startsAt: startsAt ?? this.startsAt,
      endsAt: endsAt ?? this.endsAt,
      meetingUrl: meetingUrl is String? ? meetingUrl : this.meetingUrl,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
