/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;

abstract class Notification implements _i1.SerializableModel {
  Notification._({
    this.id,
    required this.userId,
    required this.message,
    this.relatedId,
    required this.type,
    bool? isRead,
    required this.createdAt,
  }) : isRead = isRead ?? false;

  factory Notification({
    int? id,
    required int userId,
    required String message,
    int? relatedId,
    required String type,
    bool? isRead,
    required DateTime createdAt,
  }) = _NotificationImpl;

  factory Notification.fromJson(Map<String, dynamic> jsonSerialization) {
    return Notification(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      message: jsonSerialization['message'] as String,
      relatedId: jsonSerialization['relatedId'] as int?,
      type: jsonSerialization['type'] as String,
      isRead: jsonSerialization['isRead'] as bool,
      createdAt:
          _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String message;

  int? relatedId;

  String type;

  bool isRead;

  DateTime createdAt;

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Notification copyWith({
    int? id,
    int? userId,
    String? message,
    int? relatedId,
    String? type,
    bool? isRead,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'message': message,
      if (relatedId != null) 'relatedId': relatedId,
      'type': type,
      'isRead': isRead,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _NotificationImpl extends Notification {
  _NotificationImpl({
    int? id,
    required int userId,
    required String message,
    int? relatedId,
    required String type,
    bool? isRead,
    required DateTime createdAt,
  }) : super._(
          id: id,
          userId: userId,
          message: message,
          relatedId: relatedId,
          type: type,
          isRead: isRead,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Notification]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Notification copyWith({
    Object? id = _Undefined,
    int? userId,
    String? message,
    Object? relatedId = _Undefined,
    String? type,
    bool? isRead,
    DateTime? createdAt,
  }) {
    return Notification(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      message: message ?? this.message,
      relatedId: relatedId is int? ? relatedId : this.relatedId,
      type: type ?? this.type,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
