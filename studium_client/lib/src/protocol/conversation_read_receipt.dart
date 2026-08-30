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

abstract class ConversationReadReceipt implements _i1.SerializableModel {
  ConversationReadReceipt._({
    this.id,
    required this.conversationId,
    required this.userId,
    required this.lastReadMessageId,
    required this.updatedAt,
  });

  factory ConversationReadReceipt({
    int? id,
    required int conversationId,
    required int userId,
    required int lastReadMessageId,
    required DateTime updatedAt,
  }) = _ConversationReadReceiptImpl;

  factory ConversationReadReceipt.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return ConversationReadReceipt(
      id: jsonSerialization['id'] as int?,
      conversationId: jsonSerialization['conversationId'] as int,
      userId: jsonSerialization['userId'] as int,
      lastReadMessageId: jsonSerialization['lastReadMessageId'] as int,
      updatedAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['updatedAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int conversationId;

  int userId;

  int lastReadMessageId;

  DateTime updatedAt;

  /// Returns a shallow copy of this [ConversationReadReceipt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  ConversationReadReceipt copyWith({
    int? id,
    int? conversationId,
    int? userId,
    int? lastReadMessageId,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'ConversationReadReceipt',
      if (id != null) 'id': id,
      'conversationId': conversationId,
      'userId': userId,
      'lastReadMessageId': lastReadMessageId,
      'updatedAt': updatedAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ConversationReadReceiptImpl extends ConversationReadReceipt {
  _ConversationReadReceiptImpl({
    int? id,
    required int conversationId,
    required int userId,
    required int lastReadMessageId,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         conversationId: conversationId,
         userId: userId,
         lastReadMessageId: lastReadMessageId,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [ConversationReadReceipt]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  ConversationReadReceipt copyWith({
    Object? id = _Undefined,
    int? conversationId,
    int? userId,
    int? lastReadMessageId,
    DateTime? updatedAt,
  }) {
    return ConversationReadReceipt(
      id: id is int? ? id : this.id,
      conversationId: conversationId ?? this.conversationId,
      userId: userId ?? this.userId,
      lastReadMessageId: lastReadMessageId ?? this.lastReadMessageId,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
