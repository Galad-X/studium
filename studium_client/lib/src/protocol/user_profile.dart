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

abstract class UserProfile implements _i1.SerializableModel {
  UserProfile._({
    this.id,
    required this.userId,
    this.name,
    String? role,
    this.subscriptionId,
    this.studyHistoryId,
    this.stripeCustomerId,
    this.paystackCustomerCode,
  }) : role = role ?? 'free';

  factory UserProfile({
    int? id,
    required int userId,
    String? name,
    String? role,
    String? subscriptionId,
    int? studyHistoryId,
    String? stripeCustomerId,
    String? paystackCustomerCode,
  }) = _UserProfileImpl;

  factory UserProfile.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfile(
      id: jsonSerialization['id'] as int?,
      userId: jsonSerialization['userId'] as int,
      name: jsonSerialization['name'] as String?,
      role: jsonSerialization['role'] as String?,
      subscriptionId: jsonSerialization['subscriptionId'] as String?,
      studyHistoryId: jsonSerialization['studyHistoryId'] as int?,
      stripeCustomerId: jsonSerialization['stripeCustomerId'] as String?,
      paystackCustomerCode:
          jsonSerialization['paystackCustomerCode'] as String?,
    );
  }

  /// The database id, set if the object has been inserted into the
  /// database or if it has been fetched from the database. Otherwise,
  /// the id will be null.
  int? id;

  int userId;

  String? name;

  String role;

  String? subscriptionId;

  int? studyHistoryId;

  String? stripeCustomerId;

  String? paystackCustomerCode;

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserProfile copyWith({
    int? id,
    int? userId,
    String? name,
    String? role,
    String? subscriptionId,
    int? studyHistoryId,
    String? stripeCustomerId,
    String? paystackCustomerCode,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserProfile',
      if (id != null) 'id': id,
      'userId': userId,
      if (name != null) 'name': name,
      'role': role,
      if (subscriptionId != null) 'subscriptionId': subscriptionId,
      if (studyHistoryId != null) 'studyHistoryId': studyHistoryId,
      if (stripeCustomerId != null) 'stripeCustomerId': stripeCustomerId,
      if (paystackCustomerCode != null)
        'paystackCustomerCode': paystackCustomerCode,
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserProfileImpl extends UserProfile {
  _UserProfileImpl({
    int? id,
    required int userId,
    String? name,
    String? role,
    String? subscriptionId,
    int? studyHistoryId,
    String? stripeCustomerId,
    String? paystackCustomerCode,
  }) : super._(
         id: id,
         userId: userId,
         name: name,
         role: role,
         subscriptionId: subscriptionId,
         studyHistoryId: studyHistoryId,
         stripeCustomerId: stripeCustomerId,
         paystackCustomerCode: paystackCustomerCode,
       );

  /// Returns a shallow copy of this [UserProfile]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserProfile copyWith({
    Object? id = _Undefined,
    int? userId,
    Object? name = _Undefined,
    String? role,
    Object? subscriptionId = _Undefined,
    Object? studyHistoryId = _Undefined,
    Object? stripeCustomerId = _Undefined,
    Object? paystackCustomerCode = _Undefined,
  }) {
    return UserProfile(
      id: id is int? ? id : this.id,
      userId: userId ?? this.userId,
      name: name is String? ? name : this.name,
      role: role ?? this.role,
      subscriptionId: subscriptionId is String?
          ? subscriptionId
          : this.subscriptionId,
      studyHistoryId: studyHistoryId is int?
          ? studyHistoryId
          : this.studyHistoryId,
      stripeCustomerId: stripeCustomerId is String?
          ? stripeCustomerId
          : this.stripeCustomerId,
      paystackCustomerCode: paystackCustomerCode is String?
          ? paystackCustomerCode
          : this.paystackCustomerCode,
    );
  }
}
