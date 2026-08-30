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

abstract class OpportunitySource implements _i1.SerializableModel {
  OpportunitySource._({
    this.id,
    required this.name,
    required this.provider,
    required this.feedUrl,
    required this.verificationStatus,
    required this.createdById,
    this.lastSyncedAt,
    this.nextSyncAt,
    this.lastSyncStatus,
    this.lastSyncError,
    this.staleAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OpportunitySource({
    int? id,
    required String name,
    required String provider,
    required String feedUrl,
    required String verificationStatus,
    required int createdById,
    DateTime? lastSyncedAt,
    DateTime? nextSyncAt,
    String? lastSyncStatus,
    String? lastSyncError,
    DateTime? staleAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OpportunitySourceImpl;

  factory OpportunitySource.fromJson(Map<String, dynamic> jsonSerialization) {
    return OpportunitySource(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      provider: jsonSerialization['provider'] as String,
      feedUrl: jsonSerialization['feedUrl'] as String,
      verificationStatus: jsonSerialization['verificationStatus'] as String,
      createdById: jsonSerialization['createdById'] as int,
      lastSyncedAt: jsonSerialization['lastSyncedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(
              jsonSerialization['lastSyncedAt'],
            ),
      nextSyncAt: jsonSerialization['nextSyncAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['nextSyncAt']),
      lastSyncStatus: jsonSerialization['lastSyncStatus'] as String?,
      lastSyncError: jsonSerialization['lastSyncError'] as String?,
      staleAt: jsonSerialization['staleAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['staleAt']),
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

  String name;

  String provider;

  String feedUrl;

  String verificationStatus;

  int createdById;

  DateTime? lastSyncedAt;

  DateTime? nextSyncAt;

  String? lastSyncStatus;

  String? lastSyncError;

  DateTime? staleAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [OpportunitySource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  OpportunitySource copyWith({
    int? id,
    String? name,
    String? provider,
    String? feedUrl,
    String? verificationStatus,
    int? createdById,
    DateTime? lastSyncedAt,
    DateTime? nextSyncAt,
    String? lastSyncStatus,
    String? lastSyncError,
    DateTime? staleAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'OpportunitySource',
      if (id != null) 'id': id,
      'name': name,
      'provider': provider,
      'feedUrl': feedUrl,
      'verificationStatus': verificationStatus,
      'createdById': createdById,
      if (lastSyncedAt != null) 'lastSyncedAt': lastSyncedAt?.toJson(),
      if (nextSyncAt != null) 'nextSyncAt': nextSyncAt?.toJson(),
      if (lastSyncStatus != null) 'lastSyncStatus': lastSyncStatus,
      if (lastSyncError != null) 'lastSyncError': lastSyncError,
      if (staleAt != null) 'staleAt': staleAt?.toJson(),
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

class _OpportunitySourceImpl extends OpportunitySource {
  _OpportunitySourceImpl({
    int? id,
    required String name,
    required String provider,
    required String feedUrl,
    required String verificationStatus,
    required int createdById,
    DateTime? lastSyncedAt,
    DateTime? nextSyncAt,
    String? lastSyncStatus,
    String? lastSyncError,
    DateTime? staleAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
         id: id,
         name: name,
         provider: provider,
         feedUrl: feedUrl,
         verificationStatus: verificationStatus,
         createdById: createdById,
         lastSyncedAt: lastSyncedAt,
         nextSyncAt: nextSyncAt,
         lastSyncStatus: lastSyncStatus,
         lastSyncError: lastSyncError,
         staleAt: staleAt,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [OpportunitySource]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  OpportunitySource copyWith({
    Object? id = _Undefined,
    String? name,
    String? provider,
    String? feedUrl,
    String? verificationStatus,
    int? createdById,
    Object? lastSyncedAt = _Undefined,
    Object? nextSyncAt = _Undefined,
    Object? lastSyncStatus = _Undefined,
    Object? lastSyncError = _Undefined,
    Object? staleAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return OpportunitySource(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      provider: provider ?? this.provider,
      feedUrl: feedUrl ?? this.feedUrl,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      createdById: createdById ?? this.createdById,
      lastSyncedAt: lastSyncedAt is DateTime?
          ? lastSyncedAt
          : this.lastSyncedAt,
      nextSyncAt: nextSyncAt is DateTime? ? nextSyncAt : this.nextSyncAt,
      lastSyncStatus: lastSyncStatus is String?
          ? lastSyncStatus
          : this.lastSyncStatus,
      lastSyncError: lastSyncError is String?
          ? lastSyncError
          : this.lastSyncError,
      staleAt: staleAt is DateTime? ? staleAt : this.staleAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
