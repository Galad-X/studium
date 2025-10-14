// lib/src/endpoints/summary_endpoint.dart
import 'package:serverpod/serverpod.dart';
import '../generated/protocol.dart';

class SummaryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // Helper method to get authenticated user ID
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = await session.authenticated;
    return authInfo?.userId;
  }

  // Fetches all summaries for the logged-in user.
  Future<List<Summary>> getSummaries(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) throw Exception('User not authenticated');

    return await Summary.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
    );
  }
}
