import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:studium_client/studium_client.dart';

late SessionManager sessionManager;
late Client client;

Future<void> initializeServerpodClient() async {
  // Configure server URL from environment or default to localhost
  // const serverUrlFromEnv = String.fromEnvironment('SERVERPOD_URL');
  // final serverUrl =
  //     serverUrlFromEnv.isEmpty ? 'http://$localhost:7080/' : serverUrlFromEnv;

  // Initialize the GLOBAL client variable
  try {
    client = Client(
      'http://$localhost:7080/', // Use the configured serverUrl variable
      authenticationKeyManager: FlutterAuthenticationKeyManager(),
    )..connectivityMonitor = FlutterConnectivityMonitor();
  } catch (e) {
    debugPrint('Failed to initialize Serverpod client: $e');
    return;
  }

  // Initialize session manager
  sessionManager = SessionManager(
    caller: client.modules.auth,
  );

  try {
    await sessionManager.initialize();
  } catch (e) {
    debugPrint('Session manager init failed: $e');
  }
}
