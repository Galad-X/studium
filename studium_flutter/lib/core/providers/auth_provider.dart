import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serverpod_auth_client/module.dart'; // For UserInfo
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';



/// A simple provider that gives access to the global [SessionManager] instance.
///
/// This allows other providers and widgets to access the session manager
/// without needing a global variable.
final sessionManagerProvider = FutureProvider<SessionManager>((ref) async {
  final manager = await SessionManager.instance;
  await manager.initialize();
  return manager;
});
/// A stream provider that exposes the authentication state of the user.
///
/// Widgets can listen to this provider to reactively rebuild when the user

/// signs in or out. It streams [UserInfo] objects, which will be `null`
/// if the user is signed out.
// Provider that converts ChangeNotifier to Stream for authentication state
final authStateProvider = StreamProvider.autoDispose<UserInfo?>((ref) async* {
  // Get the SessionManager instance
  final manager = await ref.watch(sessionManagerProvider.future);

  // Yield the current user immediately
  yield manager.signedInUser;

  // Create a stream controller to convert ChangeNotifier to Stream
  late final StreamController<UserInfo?> controller;
  controller = StreamController<UserInfo?>(
    onListen: () {
      // Add listener to SessionManager
      void listener() {
        if (!controller.isClosed) {
          controller.add(manager.signedInUser);
        }
      }

      manager.addListener(listener);

      // Clean up when stream is cancelled
      ref.onDispose(() {
        manager.removeListener(listener);
        controller.close();
      });
    },
  );

  // Yield values from the controller stream
  yield* controller.stream;
});
