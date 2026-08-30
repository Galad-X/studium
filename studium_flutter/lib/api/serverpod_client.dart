import 'package:flutter/foundation.dart';
import 'package:serverpod_auth_shared_flutter/serverpod_auth_shared_flutter.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:studium_client/studium_client.dart';

late SessionManager sessionManager;
late Client client;

Future<void> initializeServerpodClient() async {
  const configuredServerUrl = String.fromEnvironment('SERVERPOD_URL');
  if (configuredServerUrl.isEmpty) {
    throw StateError(
      'SERVERPOD_URL must be provided with --dart-define for every build.',
    );
  }
  final serverUrl = configuredServerUrl;

  // Initialize the GLOBAL client variable
  try {
    client = Client(serverUrl)
      ..authKeyProvider = FlutterAuthenticationKeyManager()
      ..connectivityMonitor = FlutterConnectivityMonitor();
  } catch (e) {
    debugPrint('Failed to initialize Serverpod client: $e');
    rethrow;
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
