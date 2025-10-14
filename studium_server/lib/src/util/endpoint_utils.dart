import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

mixin EndpointUtils on Endpoint {
  /// A consistent and safe way to get the authenticated user's ID.
  Future<int> getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    if (authInfo?.userId == null) {
      throw Exception('User not authenticated.');
    }
    return authInfo!.userId;
  }

  /// Checks if the user has a premium role.
  Future<bool> isPremiumUser(Session session, int userId) async {
    final userProfile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    return userProfile?.role == 'premium';
  }

  /// Securely retrieves API keys from the server configuration.
 Future<String> getApiKey(Session session, String keyName) async {
    final key = session.serverpod.getPassword(keyName);

    if (key == null) {
      session.log(
        'FATAL: API key "$keyName" not found in passwords.yaml.',
        level: LogLevel.error,
      );
      throw Exception(
        'Server configuration error. Could not find required API key.',
      );
    }

    return key;
  }
}
