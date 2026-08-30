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

abstract class EmailDelivery implements _i1.SerializableModel {
  EmailDelivery._({
    this.id,
    required this.recipient,
    required this.subject,
    required this.htmlBody,
    this.dedupeKey,
    required this.status,
    required this.attempts,
    required this.maxAttempts,
    required this.availableAt,
    this.lockedAt,
    this.lockToken,
    this.lastError,
    this.sentAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory EmailDelivery({
    int? id,
    required String recipient,
    required String subject,
    required String htmlBody,
    String? dedupeKey,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _EmailDeliveryImpl;

  factory EmailDelivery.fromJson(Map<String, dynamic> jsonSerialization) {
    return EmailDelivery(
      id: jsonSerialization['id'] as int?,
      recipient: jsonSerialization['recipient'] as String,
      subject: jsonSerialization['subject'] as String,
      htmlBody: jsonSerialization['htmlBody'] as String,
      dedupeKey: jsonSerialization['dedupeKey'] as String?,
      status: jsonSerialization['status'] as String,
      attempts: jsonSerialization['attempts'] as int,
      maxAttempts: jsonSerialization['maxAttempts'] as int,
      availableAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['availableAt'],
      ),
      lockedAt: jsonSerialization['lockedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lockedAt']),
      lockToken: jsonSerialization['lockToken'] as String?,
      lastError: jsonSerialization['lastError'] as String?,
      sentAt: jsonSerialization['sentAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['sentAt']),
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

  String recipient;

  String subject;

  String htmlBody;

  String? dedupeKey;

  String status;

  int attempts;

  int maxAttempts;

  DateTime availableAt;

  DateTime? lockedAt;

  String? lockToken;

  String? lastError;

  DateTime? sentAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [EmailDelivery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  EmailDelivery copyWith({
    int? id,
    String? recipient,
    String? subject,
    String? htmlBody,
    String? dedupeKey,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'EmailDelivery',
      if (id != null) 'id': id,
      'recipient': recipient,
      'subject': subject,
      'htmlBody': htmlBody,
      if (dedupeKey != null) 'dedupeKey': dedupeKey,
      'status': status,
      'attempts': attempts,
      'maxAttempts': maxAttempts,
      'availableAt': availableAt.toJson(),
      if (lockedAt != null) 'lockedAt': lockedAt?.toJson(),
      if (lockToken != null) 'lockToken': lockToken,
      if (lastError != null) 'lastError': lastError,
      if (sentAt != null) 'sentAt': sentAt?.toJson(),
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

class _EmailDeliveryImpl extends EmailDelivery {
  _EmailDeliveryImpl({
    int? id,
    required String recipient,
    required String subject,
    required String htmlBody,
    String? dedupeKey,
    required String status,
    required int attempts,
    required int maxAttempts,
    required DateTime availableAt,
    DateTime? lockedAt,
    String? lockToken,
    String? lastError,
    DateTime? sentAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         recipient: recipient,
         subject: subject,
         htmlBody: htmlBody,
         dedupeKey: dedupeKey,
         status: status,
         attempts: attempts,
         maxAttempts: maxAttempts,
         availableAt: availableAt,
         lockedAt: lockedAt,
         lockToken: lockToken,
         lastError: lastError,
         sentAt: sentAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [EmailDelivery]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  EmailDelivery copyWith({
    Object? id = _Undefined,
    String? recipient,
    String? subject,
    String? htmlBody,
    Object? dedupeKey = _Undefined,
    String? status,
    int? attempts,
    int? maxAttempts,
    DateTime? availableAt,
    Object? lockedAt = _Undefined,
    Object? lockToken = _Undefined,
    Object? lastError = _Undefined,
    Object? sentAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return EmailDelivery(
      id: id is int? ? id : this.id,
      recipient: recipient ?? this.recipient,
      subject: subject ?? this.subject,
      htmlBody: htmlBody ?? this.htmlBody,
      dedupeKey: dedupeKey is String? ? dedupeKey : this.dedupeKey,
      status: status ?? this.status,
      attempts: attempts ?? this.attempts,
      maxAttempts: maxAttempts ?? this.maxAttempts,
      availableAt: availableAt ?? this.availableAt,
      lockedAt: lockedAt is DateTime? ? lockedAt : this.lockedAt,
      lockToken: lockToken is String? ? lockToken : this.lockToken,
      lastError: lastError is String? ? lastError : this.lastError,
      sentAt: sentAt is DateTime? ? sentAt : this.sentAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
