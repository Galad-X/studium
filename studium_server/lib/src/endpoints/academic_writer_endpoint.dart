// lib/src/endpoints/academic_writing_endpoint.dart
import 'package:serverpod/server.dart';
import '../generated/protocol.dart';
import 'ai_endpoint.dart';

class AcademicWritingEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  // Helper method to get authenticated user ID
  Future<int?> _getAuthenticatedUserId(Session session) async {
    final authInfo = session.authenticated;
    return int.tryParse(authInfo?.userIdentifier ?? '');
  }

  Future<bool> _isPremiumUser(Session session) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) return false;
    final userProfile = await UserProfile.db
        .findFirstRow(session, where: (t) => t.userId.equals(userId));
    return userProfile?.role == 'premium';
  }

  Future<AcademicWriting> generateWriting(Session session, int? studyMaterialId,
      String type, String title, String format, int? targetWordCount) async {
    if (!await _isPremiumUser(session)) {
      throw Exception('Premium access required');
    }
    final aiEndpoint = AiEndpoint();
    return await aiEndpoint.generateAcademicWriting(
        session, studyMaterialId, type, title, format, targetWordCount);
  }

  Future<List<AcademicWriting>> getWritings(Session session) async {
    if (!await _isPremiumUser(session)) {
      throw Exception('Premium access required');
    }
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) throw Exception('User not authenticated');
    return await AcademicWriting.db
        .find(session, where: (t) => t.userId.equals(userId));
  }

  // helper to delete a writing
  Future<bool> deleteWriting(Session session, int writingId) async {
    final userId = await _getAuthenticatedUserId(session);
    if (userId == null) throw Exception('User not authenticated');

    final writing = await AcademicWriting.db.findById(session, writingId);
    if (writing == null || writing.userId != userId) {
      throw Exception('Writing not found or unauthorized');
    }

    await AcademicWriting.db.deleteRow(session, writing);
    return true;
  }
}
