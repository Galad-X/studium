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

import 'package:serverpod/serverpod.dart' as _i1;
import 'user_profile.dart' as _i2;
import 'subscriptions.dart' as _i3;
import 'package:studium_server/src/generated/protocol.dart' as _i4;

abstract class UserProfileBundle
    implements _i1.SerializableModel, _i1.ProtocolSerialization {
  UserProfileBundle._({
    required this.profile,
    this.subscription,
  });

  factory UserProfileBundle({
    required _i2.UserProfile profile,
    _i3.Subscription? subscription,
  }) = _UserProfileBundleImpl;

  factory UserProfileBundle.fromJson(Map<String, dynamic> jsonSerialization) {
    return UserProfileBundle(
      profile: _i4.Protocol().deserialize<_i2.UserProfile>(
        jsonSerialization['profile'],
      ),
      subscription: jsonSerialization['subscription'] == null
          ? null
          : _i4.Protocol().deserialize<_i3.Subscription>(
              jsonSerialization['subscription'],
            ),
    );
  }

  _i2.UserProfile profile;

  _i3.Subscription? subscription;

  /// Returns a shallow copy of this [UserProfileBundle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  UserProfileBundle copyWith({
    _i2.UserProfile? profile,
    _i3.Subscription? subscription,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'UserProfileBundle',
      'profile': profile.toJson(),
      if (subscription != null) 'subscription': subscription?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'UserProfileBundle',
      'profile': profile.toJsonForProtocol(),
      if (subscription != null)
        'subscription': subscription?.toJsonForProtocol(),
    };
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _UserProfileBundleImpl extends UserProfileBundle {
  _UserProfileBundleImpl({
    required _i2.UserProfile profile,
    _i3.Subscription? subscription,
  }) : super._(
         profile: profile,
         subscription: subscription,
       );

  /// Returns a shallow copy of this [UserProfileBundle]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  UserProfileBundle copyWith({
    _i2.UserProfile? profile,
    Object? subscription = _Undefined,
  }) {
    return UserProfileBundle(
      profile: profile ?? this.profile.copyWith(),
      subscription: subscription is _i3.Subscription?
          ? subscription
          : this.subscription?.copyWith(),
    );
  }
}
