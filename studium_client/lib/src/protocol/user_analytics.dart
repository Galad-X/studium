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

abstract class UserAnalytics implements _i1.SerializableModel {
  UserAnalytics._({
    this.id,
    required this.userId,
    required this.action,
    required this.timestamp,
    this.metadata,
  });

  factory UserAnalytics({
    int? id,
    required int userId,
    required String action,
    required DateTime timestamp,
    String? metadata,
  }) = _UserAnalyticsImpl;

  factory UserAnalytics.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserAnalytics(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      action: jsonSerialization['action'] as String,
      timestamp: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['timestamp'],
      ),
      metadata: jsonSerialization['metadata'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String action;

  DateTime timestamp;

  String? metadata;

  /// Returns a shallow copy of this [UserAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserAnalytics copyWith({
    int? id,
    int? userId,
    String? action,
    DateTime? timestamp,
    String? metadata,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserAnalytics',
      if (id != null) 'id': id,
      'userId': userId,
      'action': action,
      'timestamp': timestamp.toJson(),
      if (metadata != null) 'metadata': metadata,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserAnalyticsImpl extends UserAnalytics {
  _UserAnalyticsImpl({
    int? id,
    required int userId,
    required String action,
    required DateTime timestamp,
    String? metadata,
  }) : super._(
          id: id,
          userId: userId,
          action: action,
          timestamp: timestamp,
          metadata: metadata,
        );

  /// Returns a shallow copy of this [UserAnalytics]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserAnalytics copyWith({
    Object? id = _Undefined,
    int? userId,
    String? action,
    DateTime? timestamp,
    Object? metadata = _Undefined,
  }) {
    return UserAnalytics(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      action: action ?? this.action,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata is String? ? metadata : this.metadata,
    );
  }
}
