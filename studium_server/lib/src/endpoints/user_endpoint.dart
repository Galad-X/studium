import 'package:serverpod/server.dart';
import '../generated/protocol.dart';
import '../util/endpoint_utils.dart'; // Our shared mixin

class UserEndpoint extends Endpoint with EndpointUtils {
  @override
  bool get requireLogin => true;

  /// Fetches the user's profile and their active subscription in one call.
  /// Creates a default profile if none exists (for new users).
  Future<UserProfileBundle> getProfileBundle(Session session) async {
    try {
      final userId = await getAuthenticatedUserId(session);

      // Try to fetch existing UserProfile
      UserProfile? profile = await UserProfile.db.findFirstRow(
        session,
        where: (p) => p.userId.equals(userId),
      );

      // If no profile exists, create a default one for the new user
      if (profile == null) {
        // Get the user's basic info from Serverpod's user table to populate name
        // Note: session.authenticated IS a Future that needs to be awaited
        final userInfo = session.authenticated;

        profile = UserProfile(
          userId: userId,
          name: userInfo?.userIdentifier ?? 'User', // Use appropriate field
          role: 'free', // Default role as specified in your schema
          subscriptionId: null,
          studyHistoryId: null,
          stripeCustomerId: null, // Add this field
          paystackCustomerCode: null, // Add this field
        );

        // Insert the new profile into the database
        profile = await UserProfile.db.insertRow(session, profile);
      }

      // Fetch the active Subscription if it exists
      Subscription? subscription;
      if (profile.role == 'premium' && profile.subscriptionId != null) {
        subscription = await Subscription.db.findFirstRow(
          session,
          where: (s) =>
              s.subscriptionId.equals(profile!.subscriptionId!) &
              s.status.equals('active'),
        );
      }

      return UserProfileBundle(
        profile: profile,
        subscription: subscription,
      );
    } catch (e) {
      // Log the error for debugging
      session.log('Error in getProfileBundle: $e');
      throw Exception('Failed to load user profile: $e');
    }
  }

  /// Updates the user's profile information
  Future<UserProfile> updateProfile(
    Session session, {
    String? name,
  }) async {
    try {
      final userId = await getAuthenticatedUserId(session);

      // Get existing profile or create one if it doesn't exist
      UserProfile? profile = await UserProfile.db.findFirstRow(
        session,
        where: (p) => p.userId.equals(userId),
      );

      if (profile == null) {
        // Create new profile if none exists
        profile = UserProfile(
          userId: userId,
          name: name ?? 'User',
          role: 'free',
          subscriptionId: null,
          studyHistoryId: null,
          stripeCustomerId: null, // Add this field
          paystackCustomerCode: null, // Add this field
        );
        return await UserProfile.db.insertRow(session, profile);
      } else {
        // Update existing profile
        final updatedProfile = profile.copyWith(
          name: name ?? profile.name,
        );
        return await UserProfile.db.updateRow(session, updatedProfile);
      }
    } catch (e) {
      session.log('Error in updateProfile: $e');
      throw Exception('Failed to update profile: $e');
    }
  }

  Future<DashboardBundle> getDashboardBundle(Session session) async {
    try {
      final userId = await getAuthenticatedUserId(session);

      // 1. Fetch the user's study history
      StudyHistory? history = await StudyHistory.db.findFirstRow(
        session,
        where: (h) => h.userId.equals(userId),
      );

      // If no history, create a default one
      if (history == null) {
        history = StudyHistory(
          userId: userId,
          materialIds: <int>[],
          questionIds: <int>[],
          summaryIds: <int>[],
          writingIds: <int>[],
          progress: 0.0,
          lastUpdated: DateTime.now(),
        );

        // Insert the new history record
        history = await StudyHistory.db.insertRow(session, history);
      }

      final materialIds = history.materialIds;
      final summaryIds = history.summaryIds;

      // 2. Fetch the 3 most recent materials from the history
      List<StudyMaterial> recentMaterials = [];
      if (materialIds.isNotEmpty) {
        // Get the last 3 IDs and ensure they're valid
        final recentMaterialIds =
            materialIds.reversed.take(3).where((id) => id > 0).toList();

        if (recentMaterialIds.isNotEmpty) {
          try {
            recentMaterials = await StudyMaterial.db.find(
              session,
              where: (m) => m.id.inSet(Set.from(recentMaterialIds)),
              orderBy: (m) => m.uploadDate,
              orderDescending: true,
            );
          } catch (e) {
            // Log the error but don't fail the entire request
            session.log('Error fetching recent materials: $e');
            recentMaterials = [];
          }
        }
      }

      // 3. Fetch the 3 most recent summaries from the history
      List<Summary> recentSummaries = [];
      if (summaryIds.isNotEmpty) {
        final recentSummaryIds =
            summaryIds.reversed.take(3).where((id) => id > 0).toList();

        if (recentSummaryIds.isNotEmpty) {
          try {
            recentSummaries = await Summary.db.find(
              session,
              where: (s) => s.id.inSet(Set.from(recentSummaryIds)),
              orderBy: (s) => s.createdAt,
              orderDescending: true,
            );
          } catch (e) {
            // Log the error but don't fail the entire request
            session.log('Error fetching recent summaries: $e');
            recentSummaries = [];
          }
        }
      }

      return DashboardBundle(
        history: history,
        recentMaterials: recentMaterials,
        recentSummaries: recentSummaries,
      );
    } catch (e) {
      // Log the full error for debugging
      session.log('Error in getDashboardBundle: $e');
      throw Exception('Failed to load dashboard data: $e');
    }
  }

  /// Helper method to create initial study history for new users
  Future<StudyHistory> createStudyHistory(Session session) async {
    final userId = await getAuthenticatedUserId(session);
    final history = StudyHistory(
      userId: userId,
      materialIds: <int>[],
      questionIds: <int>[],
      summaryIds: <int>[],
      writingIds: <int>[],
      progress: 0.0,
      lastUpdated: DateTime.now(),
    );

    return await StudyHistory.db.insertRow(session, history);
  }
}
