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

abstract class Conversation implements _i1.SerializableModel {
  Conversation._({
    this.id,
    required this.conversationType,
    this.title,
    required this.createdById,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Conversation({
    int? id,
    required String conversationType,
    String? title,
    required int createdById,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _ConversationImpl;

  factory Conversation.fromJson(Map<String, dynamic> jsonSerialization) {
    return Conversation(
      id: jsonSerialization['id'] as int?,
      conversationType: jsonSerialization['conversationType'] as String,
      title: jsonSerialization['title'] as String?,
      createdById: jsonSerialization['createdById'] as int,
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

  String conversationType;

  String? title;

  int createdById;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Conversation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Conversation copyWith({
    int? id,
    String? conversationType,
    String? title,
    int? createdById,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Conversation',
      if (id != null) 'id': id,
      'conversationType': conversationType,
      if (title != null) 'title': title,
      'createdById': createdById,
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

class _ConversationImpl extends Conversation {
  _ConversationImpl({
    int? id,
    required String conversationType,
    String? title,
    required int createdById,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         conversationType: conversationType,
         title: title,
         createdById: createdById,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Conversation]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Conversation copyWith({
    Object? id = _Undefined,
    String? conversationType,
    Object? title = _Undefined,
    int? createdById,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Conversation(
      id: id is int? ? id : this.id,
      conversationType: conversationType ?? this.conversationType,
      title: title is String? ? title : this.title,
      createdById: createdById ?? this.createdById,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
