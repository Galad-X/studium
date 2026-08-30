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
import 'package:studium_client/src/protocol/protocol.dart' as _i2;

abstract class Institution implements _i1.SerializableModel {
  Institution._({
    this.id,
    required this.name,
    required this.country,
    this.region,
    required this.domains,
    this.subjects,
    this.languages,
    this.submittedById,
    this.logoUrl,
    required this.verificationStatus,
    required this.createdAt,
  });

  factory Institution({
    int? id,
    required String name,
    required String country,
    String? region,
    required List<String> domains,
    List<String>? subjects,
    List<String>? languages,
    int? submittedById,
    String? logoUrl,
    required String verificationStatus,
    required DateTime createdAt,
  }) = _InstitutionImpl;

  factory Institution.fromJson(Map<String, dynamic> jsonSerialization) {
    return Institution(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      country: jsonSerialization['country'] as String,
      region: jsonSerialization['region'] as String?,
      domains: _i2.Protocol().deserialize<List<String>>(
        jsonSerialization['domains'],
      ),
      subjects: jsonSerialization['subjects'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['subjects'],
            ),
      languages: jsonSerialization['languages'] == null
          ? null
          : _i2.Protocol().deserialize<List<String>>(
              jsonSerialization['languages'],
            ),
      submittedById: jsonSerialization['submittedById'] as int?,
      logoUrl: jsonSerialization['logoUrl'] as String?,
      verificationStatus: jsonSerialization['verificationStatus'] as String,
      createdAt: _i1.DateTimeJsonExtension.fromJson(
        jsonSerialization['createdAt'],
      ),
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  String name;

  String country;

  String? region;

  List<String> domains;

  List<String>? subjects;

  List<String>? languages;

  int? submittedById;

  String? logoUrl;

  String verificationStatus;

  DateTime createdAt;

  /// Returns a shallow copy of this [Institution]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Institution copyWith({
    int? id,
    String? name,
    String? country,
    String? region,
    List<String>? domains,
    List<String>? subjects,
    List<String>? languages,
    int? submittedById,
    String? logoUrl,
    String? verificationStatus,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Institution',
      if (id != null) 'id': id,
      'name': name,
      'country': country,
      if (region != null) 'region': region,
      'domains': domains.toJson(),
      if (subjects != null) 'subjects': subjects?.toJson(),
      if (languages != null) 'languages': languages?.toJson(),
      if (submittedById != null) 'submittedById': submittedById,
      if (logoUrl != null) 'logoUrl': logoUrl,
      'verificationStatus': verificationStatus,
      'createdAt': createdAt.toJson(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _InstitutionImpl extends Institution {
  _InstitutionImpl({
    int? id,
    required String name,
    required String country,
    String? region,
    required List<String> domains,
    List<String>? subjects,
    List<String>? languages,
    int? submittedById,
    String? logoUrl,
    required String verificationStatus,
    required DateTime createdAt,
  }) : super._(
          id: id,
          name: name,
          country: country,
          region: region,
          domains: domains,
          subjects: subjects,
          languages: languages,
          submittedById: submittedById,
          logoUrl: logoUrl,
          verificationStatus: verificationStatus,
          createdAt: createdAt,
        );

  /// Returns a shallow copy of this [Institution]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Institution copyWith({
    Object? id = _Undefined,
    String? name,
    String? country,
    Object? region = _Undefined,
    List<String>? domains,
    Object? subjects = _Undefined,
    Object? languages = _Undefined,
    Object? submittedById = _Undefined,
    Object? logoUrl = _Undefined,
    String? verificationStatus,
    DateTime? createdAt,
  }) {
    return Institution(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      country: country ?? this.country,
      region: region is String? ? region : this.region,
      domains: domains ?? this.domains.map((e0) => e0).toList(),
      subjects: subjects is List<String>?
          ? subjects
          : this.subjects?.map((e0) => e0).toList(),
      languages: languages is List<String>?
          ? languages
          : this.languages?.map((e0) => e0).toList(),
      submittedById: submittedById is int? ? submittedById : this.submittedById,
      logoUrl: logoUrl is String? ? logoUrl : this.logoUrl,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
