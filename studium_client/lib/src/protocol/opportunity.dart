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

abstract class Opportunity implements _i1.SerializableModel {
  Opportunity._({
    this.id,
    required this.title,
    required this.opportunityType,
    required this.provider,
    required this.country,
    this.eligibilityRegion,
    required this.field,
    required this.educationLevel,
    required this.deadline,
    required this.fundingDetails,
    required this.officialUrl,
    required this.verificationStatus,
    this.sourceId,
    this.externalId,
    this.submittedById,
    this.lastSeenAt,
    this.staleAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Opportunity({
    int? id,
    required String title,
    required String opportunityType,
    required String provider,
    required String country,
    String? eligibilityRegion,
    required String field,
    required String educationLevel,
    required DateTime deadline,
    required String fundingDetails,
    required String officialUrl,
    required String verificationStatus,
    int? sourceId,
    String? externalId,
    int? submittedById,
    DateTime? lastSeenAt,
    DateTime? staleAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _OpportunityImpl;

  factory Opportunity.fromJson(Map<String, dynamic> jsonSerialization) {
    return Opportunity(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      opportunityType: jsonSerialization['opportunityType'] as String,
      provider: jsonSerialization['provider'] as String,
      country: jsonSerialization['country'] as String,
      eligibilityRegion: jsonSerialization['eligibilityRegion'] as String?,
      field: jsonSerialization['field'] as String,
      educationLevel: jsonSerialization['educationLevel'] as String,
      deadline: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['deadline'],
      ),
      fundingDetails: jsonSerialization['fundingDetails'] as String,
      officialUrl: jsonSerialization['officialUrl'] as String,
      verificationStatus: jsonSerialization['verificationStatus'] as String,
      sourceId: jsonSerialization['sourceId'] as int?,
      externalId: jsonSerialization['externalId'] as String?,
      submittedById: jsonSerialization['submittedById'] as int?,
      lastSeenAt: jsonSerialization['lastSeenAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['lastSeenAt']),
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

  String title;

  String opportunityType;

  String provider;

  String country;

  String? eligibilityRegion;

  String field;

  String educationLevel;

  DateTime deadline;

  String fundingDetails;

  String officialUrl;

  String verificationStatus;

  int? sourceId;

  String? externalId;

  int? submittedById;

  DateTime? lastSeenAt;

  DateTime? staleAt;

  DateTime createdAt;

  DateTime updatedAt;

  /// Returns a shallow copy of this [Opportunity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Opportunity copyWith({
    int? id,
    String? title,
    String? opportunityType,
    String? provider,
    String? country,
    String? eligibilityRegion,
    String? field,
    String? educationLevel,
    DateTime? deadline,
    String? fundingDetails,
    String? officialUrl,
    String? verificationStatus,
    int? sourceId,
    String? externalId,
    int? submittedById,
    DateTime? lastSeenAt,
    DateTime? staleAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Opportunity',
      if (id != null) 'id': id,
      'title': title,
      'opportunityType': opportunityType,
      'provider': provider,
      'country': country,
      if (eligibilityRegion != null) 'eligibilityRegion': eligibilityRegion,
      'field': field,
      'educationLevel': educationLevel,
      'deadline': deadline.toJson(),
      'fundingDetails': fundingDetails,
      'officialUrl': officialUrl,
      'verificationStatus': verificationStatus,
      if (sourceId != null) 'sourceId': sourceId,
      if (externalId != null) 'externalId': externalId,
      if (submittedById != null) 'submittedById': submittedById,
      if (lastSeenAt != null) 'lastSeenAt': lastSeenAt?.toJson(),
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

class _OpportunityImpl extends Opportunity {
  _OpportunityImpl({
    int? id,
    required String title,
    required String opportunityType,
    required String provider,
    required String country,
    String? eligibilityRegion,
    required String field,
    required String educationLevel,
    required DateTime deadline,
    required String fundingDetails,
    required String officialUrl,
    required String verificationStatus,
    int? sourceId,
    String? externalId,
    int? submittedById,
    DateTime? lastSeenAt,
    DateTime? staleAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : super._(
          id: id,
          title: title,
          opportunityType: opportunityType,
          provider: provider,
          country: country,
          eligibilityRegion: eligibilityRegion,
          field: field,
          educationLevel: educationLevel,
          deadline: deadline,
          fundingDetails: fundingDetails,
          officialUrl: officialUrl,
          verificationStatus: verificationStatus,
          sourceId: sourceId,
          externalId: externalId,
          submittedById: submittedById,
          lastSeenAt: lastSeenAt,
          staleAt: staleAt,
          createdAt: createdAt,
          updatedAt: updatedAt,
        );

  /// Returns a shallow copy of this [Opportunity]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Opportunity copyWith({
    Object? id = _Undefined,
    String? title,
    String? opportunityType,
    String? provider,
    String? country,
    Object? eligibilityRegion = _Undefined,
    String? field,
    String? educationLevel,
    DateTime? deadline,
    String? fundingDetails,
    String? officialUrl,
    String? verificationStatus,
    Object? sourceId = _Undefined,
    Object? externalId = _Undefined,
    Object? submittedById = _Undefined,
    Object? lastSeenAt = _Undefined,
    Object? staleAt = _Undefined,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Opportunity(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      opportunityType: opportunityType ?? this.opportunityType,
      provider: provider ?? this.provider,
      country: country ?? this.country,
      eligibilityRegion: eligibilityRegion is String?
          ? eligibilityRegion
          : this.eligibilityRegion,
      field: field ?? this.field,
      educationLevel: educationLevel ?? this.educationLevel,
      deadline: deadline ?? this.deadline,
      fundingDetails: fundingDetails ?? this.fundingDetails,
      officialUrl: officialUrl ?? this.officialUrl,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      sourceId: sourceId is int? ? sourceId : this.sourceId,
      externalId: externalId is String? ? externalId : this.externalId,
      submittedById: submittedById is int? ? submittedById : this.submittedById,
      lastSeenAt: lastSeenAt is DateTime? ? lastSeenAt : this.lastSeenAt,
      staleAt: staleAt is DateTime? ? staleAt : this.staleAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
