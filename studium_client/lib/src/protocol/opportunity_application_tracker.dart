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

abstract class OpportunityApplicationTracker implements _i1.SerializableModel {
  OpportunityApplicationTracker._({
    this.id,
    required this.opportunityId,
    required this.userId,
    required this.status,
    this.notes,
    this.applicationUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OpportunityApplicationTracker({
    int? id,
    required int opportunityId,
    required int userId,
    required String status,
    String? notes,
    String? applicationUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OpportunityApplicationTrackerImpl;

  factory OpportunityApplicationTracker.fromJson(
    Map<String, dynamic> jsonSerialization,
  ) {
    return OpportunityApplicationTracker(
      id: jsonSerialization['id'] as int?,
      opportunityId: jsonSerialization['opportunityId'] as int,
      userId: jsonSerialization['userId'] as int,
      status: jsonSerialization['status'] as String,
      notes: jsonSerialization['notes'] as String?,
      applicationUrl: jsonSerialization['applicationUrl'] as String?,
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

  int opportunityId;

  int userId;

  String status;

  String? notes;

  String? applicationUrl;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [OpportunityApplicationTracker]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OpportunityApplicationTracker copyWith({
    int? id,
    int? opportunityId,
    int? userId,
    String? status,
    String? notes,
    String? applicationUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpportunityApplicationTracker',
      if (id != null) 'id': id,
      'opportunityId': opportunityId,
      'userId': userId,
      'status': status,
      if (notes != null) 'notes': notes,
      if (applicationUrl != null) 'applicationUrl': applicationUrl,
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

class _OpportunityApplicationTrackerImpl extends OpportunityApplicationTracker {
  _OpportunityApplicationTrackerImpl({
    int? id,
    required int opportunityId,
    required int userId,
    required String status,
    String? notes,
    String? applicationUrl,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         opportunityId: opportunityId,
         userId: userId,
         status: status,
         notes: notes,
         applicationUrl: applicationUrl,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [OpportunityApplicationTracker]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OpportunityApplicationTracker copyWith({
    Object? id = _Undefined,
    int? opportunityId,
    int? userId,
    String? status,
    Object? notes = _Undefined,
    Object? applicationUrl = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OpportunityApplicationTracker(
      id: id is int? ? id : this.id,
      opportunityId: opportunityId ?? this.opportunityId,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      notes: notes is String? ? notes : this.notes,
      applicationUrl: applicationUrl is String?
          ? applicationUrl
          : this.applicationUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
