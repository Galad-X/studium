import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import '../../../api/serverpod_client.dart'; // For sessionManager
import '../../../core/providers/service_providers.dart';

// Provides the user's profile data bundle
final profileProvider = FutureProvider.autoDispose<UserProfileBundle>((ref) {
  final userService = ref.watch(userServiceProvider);
  return userService.getProfileBundle();
});

// A provider for handling sign-out logic
final signOutProvider = Provider((ref) {
  return () async {
    await sessionManager.signOutDevice();
  };
});
