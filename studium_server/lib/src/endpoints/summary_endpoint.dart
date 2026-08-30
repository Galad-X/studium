// lib/src/endpoints/summary_endpoint.dart
import 'package:serverpod/server.dart';
import '../generated/protocol.dart';

class SummaryEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // Helper method to get authenticated user ID
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = session.authenticated;
    return int.tryParse(authInfo?.userIdentifier ?? '');
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
      limit: 500,
    );
  }

  Future<bool> deleteSummary(Session session, int summaryId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) throw Exception('User not authenticated');

    final summary = await Summary.db.findById(session, summaryId);
    if (summary == null || summary.userId != userId) {
      throw Exception('Summary not found.');
    }

    await Summary.db.deleteRow(session, summary);
    return true;
  }
}
