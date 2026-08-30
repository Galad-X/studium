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
import 'package:studium_client/src/protocol/protocol.dart' as _i2;

abstract class AcademicProfile implements _i1.SerializableModel {
  AcademicProfile._({
    this.id,
    required this.userId,
    required this.institutionId,
    this.department,
    this.programme,
    this.level,
    required this.subjects,
    required this.interests,
    required this.languages,
    this.availability,
    required this.updatedAt,
  });

  factory AcademicProfile({
    int? id,
    required int userId,
    required int institutionId,
    String? department,
    String? programme,
    String? level,
    required List<String> subjects,
    required List<String> interests,
    required List<String> languages,
    String? availability,
    required DateTime updatedAt,
  }) = _AcademicProfileImpl;

  factory AcademicProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return AcademicProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      institutionId: jsonSerialization['institutionId'] as int,
      department: jsonSerialization['department'] as String?,
      programme: jsonSerialization['programme'] as String?,
      level: jsonSerialization['level'] as String?,
      subjects: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['subjects'],
      ),
      interests: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['interests'],
      ),
      languages: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['languages'],
      ),
      availability: jsonSerialization['availability'] as String?,
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

  int institutionId;

  String? department;

  String? programme;

  String? level;

  List<String> subjects;

  List<String> interests;

  List<String> languages;

  String? availability;

  DateTime updatedAt;

  /// Returns a shallow copy of this [AcademicProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  AcademicProfile copyWith({
    int? id,
    int? userId,
    int? institutionId,
    String? department,
    String? programme,
    String? level,
    List<String>? subjects,
    List<String>? interests,
    List<String>? languages,
    String? availability,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'AcademicProfile',
      if (id != null) 'id': id,
      'userId': userId,
      'institutionId': institutionId,
      if (department != null) 'department': department,
      if (programme != null) 'programme': programme,
      if (level != null) 'level': level,
      'subjects': subjects.toJson(),
      'interests': interests.toJson(),
      'languages': languages.toJson(),
      if (availability != null) 'availability': availability,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _AcademicProfileImpl extends AcademicProfile {
  _AcademicProfileImpl({
    int? id,
    required int userId,
    required int institutionId,
    String? department,
    String? programme,
    String? level,
    required List<String> subjects,
    required List<String> interests,
    required List<String> languages,
    String? availability,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         userId: userId,
         institutionId: institutionId,
         department: department,
         programme: programme,
         level: level,
         subjects: subjects,
         interests: interests,
         languages: languages,
         availability: availability,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [AcademicProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  AcademicProfile copyWith({
    Object? id = _Undefined,
    int? userId,
    int? institutionId,
    Object? department = _Undefined,
    Object? programme = _Undefined,
    Object? level = _Undefined,
    List<String>? subjects,
    List<String>? interests,
    List<String>? languages,
    Object? availability = _Undefined,
    DateTime? updatedAt,
  }) {
    return AcademicProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      institutionId: institutionId ?? this.institutionId,
      department: department is String? ? department : this.department,
      programme: programme is String? ? programme : this.programme,
      level: level is String? ? level : this.level,
      subjects: subjects ?? this.subjects.map((e0) => e0).toList(),
      interests: interests ?? this.interests.map((e0) => e0).toList(),
      languages: languages ?? this.languages.map((e0) => e0).toList(),
      availability: availability is String? ? availability : this.availability,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
