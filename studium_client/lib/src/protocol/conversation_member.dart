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

abstract class ConversationMember implements _i1.SerializableModel {
  ConversationMember._({
    this.id,
    required this.conversationId,
    required this.userId,
    required this.role,
    required this.status,
    required this.joinedAt,
  });

  factory ConversationMember({
    int? id,
    required int conversationId,
    required int userId,
    required String role,
    required String status,
    required DateTime joinedAt,
  }) = _ConversationMemberImpl;

  factory ConversationMember.fromJson(Map<String, dynamic> jsonSerialization) {
    return ConversationMember(
      id: jsonSerialization['id'] as int?,
      conversationId: jsonSerialization['conversationId'] as int,
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

  int conversationId;

  int userId;

  String role;

  String status;

  DateTime joinedAt;

  /// Returns a shallow copy of this [ConversationMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ConversationMember copyWith({
    int? id,
    int? conversationId,
    int? userId,
    String? role,
    String? status,
    DateTime? joinedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConversationMember',
      if (id != null) 'id': id,
      'conversationId': conversationId,
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

class _ConversationMemberImpl extends ConversationMember {
  _ConversationMemberImpl({
    int? id,
    required int conversationId,
    required int userId,
    required String role,
    required String status,
    required DateTime joinedAt,
  }) : super._(
         id: id,
         conversationId: conversationId,
         userId: userId,
         role: role,
         status: status,
         joinedAt: joinedAt,
       );

  /// Returns a shallow copy of this [ConversationMember]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ConversationMember copyWith({
    Object? id = _Undefined,
    int? conversationId,
    int? userId,
    String? role,
    String? status,
    DateTime? joinedAt,
  }) {
    return ConversationMember(
      id: id is int? ? id : this.id,
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      role: role ?? this.role,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
