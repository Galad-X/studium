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

abstract class StudyRoom implements _i1.SerializableModel {
  StudyRoom._({
    this.id,
    this.institutionId,
    required this.ownerId,
    required this.title,
    required this.description,
    this.subject,
    required this.visibility,
    required this.membershipPolicy,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory StudyRoom({
    int? id,
    int? institutionId,
    required int ownerId,
    required String title,
    required String description,
    String? subject,
    required String visibility,
    required String membershipPolicy,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _StudyRoomImpl;

  factory StudyRoom.fromJson(Map<String, dynamic> jsonSerialization) {
    return StudyRoom(
      id: jsonSerialization['id'] as int?,
      institutionId: jsonSerialization['institutionId'] as int?,
      ownerId: jsonSerialization['ownerId'] as int,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      subject: jsonSerialization['subject'] as String?,
      visibility: jsonSerialization['visibility'] as String,
      membershipPolicy: jsonSerialization['membershipPolicy'] as String,
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

  int? institutionId;

  int ownerId;

  String title;

  String description;

  String? subject;

  String visibility;

  String membershipPolicy;

  String status;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [StudyRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  StudyRoom copyWith({
    int? id,
    int? institutionId,
    int? ownerId,
    String? title,
    String? description,
    String? subject,
    String? visibility,
    String? membershipPolicy,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'StudyRoom',
      if (id != null) 'id': id,
      if (institutionId != null) 'institutionId': institutionId,
      'ownerId': ownerId,
      'title': title,
      'description': description,
      if (subject != null) 'subject': subject,
      'visibility': visibility,
      'membershipPolicy': membershipPolicy,
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

class _StudyRoomImpl extends StudyRoom {
  _StudyRoomImpl({
    int? id,
    int? institutionId,
    required int ownerId,
    required String title,
    required String description,
    String? subject,
    required String visibility,
    required String membershipPolicy,
    required String status,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          institutionId: institutionId,
          ownerId: ownerId,
          title: title,
          description: description,
          subject: subject,
          visibility: visibility,
          membershipPolicy: membershipPolicy,
          status: status,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [StudyRoom]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  StudyRoom copyWith({
    Object? id = _Undefined,
    Object? institutionId = _Undefined,
    int? ownerId,
    String? title,
    String? description,
    Object? subject = _Undefined,
    String? visibility,
    String? membershipPolicy,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return StudyRoom(
      id: id is int? ? id : this.id,
      institutionId: institutionId is int? ? institutionId : this.institutionId,
      ownerId: ownerId ?? this.ownerId,
      title: title ?? this.title,
      description: description ?? this.description,
      subject: subject is String? ? subject : this.subject,
      visibility: visibility ?? this.visibility,
      membershipPolicy: membershipPolicy ?? this.membershipPolicy,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
