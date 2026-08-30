// ANALYTICS ENDPOINT
import 'package:serverpod/server.dart';
import '../generated/protocol.dart';

class AnalyticsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<bool> _isPremiumUser(Session session) async {
    final authInfo = session.authenticated;
    final userId = int.tryParse(authInfo?.userIdentifier ?? '');

    if (userId == null) return false;

    final userProfile = await UserProfile.db
        .findFirstRow(session, where: (t) => t.userId.equals(userId));
    return userProfile?.role == 'premium';
  }

  Future<bool> logAction(
      Session session, String action, String? metadata) async {
    final authInfo = session.authenticated;
    final userId = int.tryParse(authInfo?.userIdentifier ?? '');
    if (userId == null) throw Exception('User not authenticated');

    final analytics = UserAnalytics(
      userId: userId,
      action: action,
      metadata: metadata,
      timestamp: DateTime.now(),
    );

    await UserAnalytics.db.insertRow(session, analytics);
    return true;
  }

  Future<List<UserAnalytics>> getAnalytics(Session session) async {
    if (!await _isPremiumUser(session)) {
      throw Exception('Premium access required');
    }

    final authInfo = session.authenticated;
    final userId = int.tryParse(authInfo?.userIdentifier ?? '');
    if (userId == null) throw Exception('User not authenticated');
    return await UserAnalytics.db
        .find(session, where: (t) => t.userId.equals(userId), limit: 500);
  }
}
