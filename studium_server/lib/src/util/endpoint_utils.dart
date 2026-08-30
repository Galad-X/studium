import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';
import 'configuration_secrets.dart';

mixin EndpointUtils on Endpoint {
  Future<void> enforceRateLimit(
    Session session, {
    required int userId,
    required String action,
    required int maximum,
    required Duration window,
  }) async {
    if (maximum < 1 || window.inMilliseconds < 1) {
      throw ArgumentError('Invalid rate-limit configuration.');
    }
    final now = DateTime.now().toUtc();
    final windowMilliseconds = window.inMilliseconds;
    final windowStart = DateTime.fromMillisecondsSinceEpoch(
      (now.millisecondsSinceEpoch ~/ windowMilliseconds) * windowMilliseconds,
      isUtc: true,
    );
    final scopeKey = '${action.trim()}:$userId';
    await session.db.transaction((transaction) async {
      final bucket = await ApiRateLimitBucket.db.findFirstRow(
        session,
        where: (t) =>
            t.scopeKey.equals(scopeKey) & t.windowStart.equals(windowStart),
        transaction: transaction,
      );
      if (bucket == null) {
        await ApiRateLimitBucket.db.insertRow(
          session,
          ApiRateLimitBucket(
            scopeKey: scopeKey,
            windowStart: windowStart,
            requestCount: 1,
            updatedAt: now,
          ),
          transaction: transaction,
        );
        return;
      }
      if (bucket.requestCount >= maximum) {
        throw Exception('Rate limit exceeded. Try again later.');
      }
      bucket.requestCount += 1;
      bucket.updatedAt = now;
      await ApiRateLimitBucket.db.updateRow(
        session,
        bucket,
        transaction: transaction,
      );
    });
  }

  Future<void> recordAuditEvent(
    Session session, {
    required int actorId,
    required String action,
    required String targetType,
    required int targetId,
    int? institutionId,
    String? metadata,
    dynamic transaction,
  }) async {
    await AuditEvent.db.insertRow(
      session,
      AuditEvent(
        actorId: actorId,
        institutionId: institutionId,
        action: action,
        targetType: targetType,
        targetId: targetId,
        metadata: metadata,
        createdAt: DateTime.now(),
      ),
      transaction: transaction,
    );
  }

  /// A consistent and safe way to get the authenticated user's ID.
  Future<int> getAuthenticatedUserId(Session session) async {
    final authInfo = session.authenticated;
    final userId = int.tryParse(authInfo?.userIdentifier ?? '');
    if (userId == null) {
      throw Exception('User not authenticated.');
    }
    return userId;
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
    final key = ConfigurationSecrets.read(session, keyName);

    if (key == null || key.trim().isEmpty || key == 'replace-me') {
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
