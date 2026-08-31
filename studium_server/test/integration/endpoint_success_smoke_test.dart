import 'package:test/test.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import 'test_tools/serverpod_test_tools.dart';

/// Authenticated read-path smoke coverage across the generated endpoint
/// surface. Mutation workflows remain covered by the domain integration suite.
void main() {
  withServerpod('Authenticated endpoint success-path smoke coverage',
      (sessionBuilder, endpoints) {
    test('collaboration, messaging, opportunities, and notifications load',
        () async {
      final authenticated = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo('1001', {}),
      );

      expect(
          await endpoints.collaboration
              .searchInstitutions(authenticated, '', 0, 20),
          isA<List>());
      expect(await endpoints.collaboration.getMyMemberships(authenticated),
          isA<List>());
      expect(await endpoints.collaboration.getMyReputation(authenticated),
          isNotNull);
      expect(await endpoints.collaboration.getRooms(authenticated, 0, 20),
          isA<List>());
      expect(
          await endpoints.collaboration
              .getChallenges(authenticated, 0, 20, null),
          isA<List>());
      expect(await endpoints.messaging.getMyPrivacySettings(authenticated),
          isNotNull);
      expect(await endpoints.messaging.getMyConversations(authenticated),
          isA<List>());
      expect(
          await endpoints.opportunity.getOpportunities(
              authenticated, 0, 20, null, null, null, null, null),
          isA<List>());
      expect(
          await endpoints.opportunity
              .getSavedOpportunities(authenticated, 0, 20),
          isA<List>());
      expect(await endpoints.opportunity.getOpportunityAlerts(authenticated),
          isA<List>());
      expect(
          await endpoints.notification.getNotifications(authenticated,
              isRead: false, page: 0, limit: 20),
          isA<List>());
    });

    test(
        'legacy profile, history, material, writing, analytics, and billing reads',
        () async {
      final authenticated = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo('1001', {}),
      );
      final session = authenticated.build();
      try {
        if (await UserInfo.db.findById(session, 1001) == null) {
          await UserInfo.db.insertRow(
            session,
            UserInfo(
              id: 1001,
              userIdentifier: '1001',
              userName: 'success-smoke-user',
              email: 'success-smoke@example.edu',
              created: DateTime.now(),
              scopeNames: const [],
              blocked: false,
            ),
          );
        }
      } finally {
        await session.close();
      }

      expect(await endpoints.user.getProfileBundle(authenticated), isNotNull);
      expect(await endpoints.user.getDashboardBundle(authenticated), isNotNull);
      expect(await endpoints.summary.getSummaries(authenticated), isA<List>());
      expect(await endpoints.studyMaterial.getMaterials(authenticated),
          isA<List>());
      expect(await endpoints.studyMaterial.getMaterialStats(authenticated),
          isA<Map>());
      expect(await endpoints.subscription.getSubscriptionStatus(authenticated),
          anyOf(isNull, isNotNull));
    });
  });
}
