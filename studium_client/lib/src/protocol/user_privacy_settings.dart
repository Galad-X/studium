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

abstract class UserPrivacySettings implements _i1.SerializableModel {
  UserPrivacySettings._({
    this.id,
    required this.userId,
    bool? isMinor,
    this.dateOfBirth,
    this.guardianConsentAt,
    bool? allowUnknownDirectMessages,
    required this.updatedAt,
  })  : isMinor = isMinor ?? false,
        allowUnknownDirectMessages = allowUnknownDirectMessages ?? true;

  factory UserPrivacySettings({
    int? id,
    required int userId,
    bool? isMinor,
    DateTime? dateOfBirth,
    DateTime? guardianConsentAt,
    bool? allowUnknownDirectMessages,
    required DateTime updatedAt,
  }) = _UserPrivacySettingsImpl;

  factory UserPrivacySettings.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserPrivacySettings(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      isMinor: jsonSerialization['isMinor'] == null
          ? null
          : _i1.BoolJsonExtension.fromJson(jsonSerialization['isMinor']),
      dateOfBirth: jsonSerialization['dateOfBirth'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['dateOfBirth'],
            ),
      guardianConsentAt: jsonSerialization['guardianConsentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['guardianConsentAt'],
            ),
      allowUnknownDirectMessages:
          jsonSerialization['allowUnknownDirectMessages'] == null
              ? null
              : _i1.BoolJsonExtension.fromJson(
                  jsonSerialization['allowUnknownDirectMessages'],
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

  bool isMinor;

  DateTime? dateOfBirth;

  DateTime? guardianConsentAt;

  bool allowUnknownDirectMessages;

  DateTime updatedAt;

  /// Returns a shallow copy of this [UserPrivacySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserPrivacySettings copyWith({
    int? id,
    int? userId,
    bool? isMinor,
    DateTime? dateOfBirth,
    DateTime? guardianConsentAt,
    bool? allowUnknownDirectMessages,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserPrivacySettings',
      if (id != null) 'id': id,
      'userId': userId,
      'isMinor': isMinor,
      if (dateOfBirth != null) 'dateOfBirth': dateOfBirth?.toJson(),
      if (guardianConsentAt != null)
        'guardianConsentAt': guardianConsentAt?.toJson(),
      'allowUnknownDirectMessages': allowUnknownDirectMessages,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserPrivacySettingsImpl extends UserPrivacySettings {
  _UserPrivacySettingsImpl({
    int? id,
    required int userId,
    bool? isMinor,
    DateTime? dateOfBirth,
    DateTime? guardianConsentAt,
    bool? allowUnknownDirectMessages,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          userId: userId,
          isMinor: isMinor,
          dateOfBirth: dateOfBirth,
          guardianConsentAt: guardianConsentAt,
          allowUnknownDirectMessages: allowUnknownDirectMessages,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [UserPrivacySettings]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserPrivacySettings copyWith({
    Object? id = _Undefined,
    int? userId,
    bool? isMinor,
    Object? dateOfBirth = _Undefined,
    Object? guardianConsentAt = _Undefined,
    bool? allowUnknownDirectMessages,
    DateTime? updatedAt,
  }) {
    return UserPrivacySettings(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      isMinor: isMinor ?? this.isMinor,
      dateOfBirth: dateOfBirth is DateTime? ? dateOfBirth : this.dateOfBirth,
      guardianConsentAt: guardianConsentAt is DateTime?
          ? guardianConsentAt
          : this.guardianConsentAt,
      allowUnknownDirectMessages:
          allowUnknownDirectMessages ?? this.allowUnknownDirectMessages,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
