import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:studium_client/studium_client.dart';
import 'package:studium_flutter/core/providers/service_providers.dart';

import 'package:studium_flutter/features/collaboration/providers/collaboration_provider.dart';
import 'package:studium_flutter/features/collaboration/services/collaboration_service.dart';
import 'package:studium_flutter/features/collaboration/screens/collaboration_screen.dart';
import 'package:studium_flutter/features/collaboration/state/collaboration_cache.dart';

class _FakeCollaborationService extends CollaborationService {
  _FakeCollaborationService({
    this.institutions = const [],
    this.memberships = const [],
    this.rooms = const [],
    this.challenges = const [],
    this.posts = const [],
  }) : super(Client('http://127.0.0.1:1'));

  final List<Institution> institutions;
  final List<InstitutionMembership> memberships;
  final List<StudyRoom> rooms;
  final List<Challenge> challenges;
  final List<DiscussionPost> posts;

  @override
  Future<UserReputation> getUserReputation(int userId) async => UserReputation(
        userId: userId,
        score: userId * 10,
        acceptedSolutions: 1,
        verifiedContributions: 2,
        updatedAt: DateTime(2026),
      );

  @override
  Future<List<Institution>> searchInstitutions(String query,
      {int page = 0, int limit = 30}) async {
    return institutions
        .where((institution) =>
            institution.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  @override
  Future<List<InstitutionMembership>> getMyMemberships() async => memberships;

  @override
  Future<List<StudyRoom>> getRooms({
    int page = 0,
    int limit = 30,
    int? institutionId,
    String? subject,
  }) async =>
      rooms;

  @override
  Future<List<Challenge>> getChallenges({int page = 0, int limit = 30}) async =>
      challenges;

  @override
  Future<List<DiscussionPost>> getRoomPosts(int roomId,
          {int page = 0, int limit = 30}) async =>
      posts.where((post) => post.roomId == roomId).toList();

  @override
  Future<List<ChallengeTeam>> getChallengeTeams(int challengeId) async =>
      const [];

  @override
  Future<RoomMembership?> getMyRoomMembership(int roomId) async => null;

  @override
  Future<List<ChallengeMilestone>> getTeamMilestones(int teamId,
          {int page = 0, int limit = 50}) async =>
      const [];

  @override
  Future<List<ChallengeProgressUpdate>> getTeamUpdates(int teamId,
          {int page = 0, int limit = 50}) async =>
      const [];

  @override
  Future<List<Comment>> getPostComments(int postId,
          {int page = 0, int limit = 30}) async =>
      const [];

  @override
  Future<List<ModerationAppeal>> getMyModerationAppeals({
    int page = 0,
    int limit = 30,
  }) async =>
      const [];

  @override
  Future<List<OpportunityApplicationTracker>> getApplicationTrackers({
    int page = 0,
    int limit = 50,
  }) async =>
      const [];

  @override
  Future<List<Conversation>> getMyConversations() async => const [];

  @override
  Future<List<DirectMessage>> getConversationMessages(int conversationId,
          {int page = 0, int limit = 100}) async =>
      const [];

  @override
  Future<List<UserSafetyRelationship>> getMySafetyRelationships({
    int page = 0,
    int limit = 100,
  }) async =>
      const [];
}

void main() {
  test('institution providers use the injected collaboration service',
      () async {
    final institution = Institution(
      id: 1,
      name: 'Global University',
      country: 'Nigeria',
      domains: ['global.edu'],
      verificationStatus: 'verified',
      createdAt: DateTime(2026),
    );
    final membership = InstitutionMembership(
      id: 2,
      userId: 7,
      institutionId: 1,
      role: 'student',
      verificationMethod: 'institution_email',
      status: 'verified',
      createdAt: DateTime(2026),
    );
    final container = ProviderContainer(
      overrides: [
        collaborationCacheProvider.overrideWithValue(CollaborationCache()),
        collaborationServiceProvider.overrideWithValue(
          _FakeCollaborationService(
            institutions: [institution],
            memberships: [membership],
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(
      await container.read(institutionSearchProvider('global').future),
      [institution],
    );
    expect(await container.read(myMembershipsProvider.future), [membership]);
  });

  test('challenge and team providers expose injected collaboration data',
      () async {
    final container = ProviderContainer(
      overrides: [
        collaborationCacheProvider.overrideWithValue(CollaborationCache()),
        collaborationServiceProvider.overrideWithValue(
          _FakeCollaborationService(),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(await container.read(challengeTeamsProvider(1).future), isEmpty);
    expect(await container.read(teamMilestonesProvider(2).future), isEmpty);
    expect(await container.read(teamUpdatesProvider(2).future), isEmpty);
    expect(await container.read(postCommentsProvider(3).future), isEmpty);
    expect(await container.read(myRoomMembershipProvider(4).future), isNull);
    expect(await container.read(myModerationAppealsProvider.future), isEmpty);
    expect(await container.read(applicationTrackersProvider.future), isEmpty);
    expect(await container.read(conversationsProvider.future), isEmpty);
    expect(
        await container.read(conversationMessagesProvider(4).future), isEmpty);
    expect(await container.read(mySafetyRelationshipsProvider.future), isEmpty);
  });

  test('loads reputation for a displayed member through the provider',
      () async {
    final container = ProviderContainer(
      overrides: [
        collaborationServiceProvider.overrideWithValue(
          _FakeCollaborationService(),
        ),
      ],
    );
    addTearDown(container.dispose);

    final value = await container.read(userReputationProvider(12).future);
    expect(value.userId, 12);
    expect(value.score, 120);
    expect(value.verifiedContributions, 2);
  });

  test(
      'pilot workflow loads verified identity, room feed, and challenge team data',
      () async {
    final now = DateTime(2026);
    final institution = Institution(
      id: 1,
      name: 'Global University',
      country: 'Nigeria',
      domains: ['global.edu'],
      verificationStatus: 'verified',
      createdAt: now,
    );
    final membership = InstitutionMembership(
      id: 2,
      userId: 7,
      institutionId: 1,
      role: 'student',
      verificationMethod: 'institution_email',
      status: 'verified',
      createdAt: now,
    );
    final room = StudyRoom(
      id: 3,
      institutionId: 1,
      ownerId: 7,
      title: 'Distributed Systems',
      description: 'Cross-campus study room',
      subject: 'Computer Science',
      visibility: 'institution',
      membershipPolicy: 'approval',
      status: 'active',
      createdAt: now,
      updatedAt: now,
    );
    final post = DiscussionPost(
      id: 4,
      roomId: 3,
      authorId: 7,
      body: 'Let us compare consensus approaches.',
      status: 'active',
      createdAt: now,
      updatedAt: now,
    );
    final challenge = Challenge(
      id: 5,
      roomId: 3,
      ownerId: 7,
      title: 'Fault-tolerant consensus',
      problemStatement: 'Find a lower-cost approach.',
      field: 'Computer Science',
      tags: ['systems'],
      difficulty: 'advanced',
      status: 'open',
      createdAt: now,
      updatedAt: now,
    );

    final container = ProviderContainer(
      overrides: [
        collaborationCacheProvider.overrideWithValue(CollaborationCache()),
        collaborationServiceProvider.overrideWithValue(
          _FakeCollaborationService(
            institutions: [institution],
            memberships: [membership],
            rooms: [room],
            challenges: [challenge],
            posts: [post],
          ),
        ),
      ],
    );
    addTearDown(container.dispose);

    expect(await container.read(institutionSearchProvider('global').future),
        [institution]);
    expect(await container.read(myMembershipsProvider.future), [membership]);
    expect(await container.read(studyRoomsProvider(null).future), [room]);
    expect(await container.read(roomPostsProvider(3).future), [post]);
    expect(await container.read(challengesProvider.future), [challenge]);
  });

  testWidgets('pilot collaboration surface renders rooms and challenges',
      (tester) async {
    final now = DateTime(2026);
    final room = StudyRoom(
      id: 3,
      ownerId: 7,
      title: 'Distributed Systems',
      description: 'Cross-campus study room',
      visibility: 'public',
      membershipPolicy: 'open',
      status: 'active',
      createdAt: now,
      updatedAt: now,
    );
    final challenge = Challenge(
      id: 5,
      ownerId: 7,
      title: 'Fault-tolerant consensus',
      problemStatement: 'Find a lower-cost approach.',
      field: 'Computer Science',
      tags: const ['systems'],
      difficulty: 'advanced',
      status: 'open',
      createdAt: now,
      updatedAt: now,
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          collaborationCacheProvider.overrideWithValue(CollaborationCache()),
          collaborationServiceProvider.overrideWithValue(
            _FakeCollaborationService(rooms: [room], challenges: [challenge]),
          ),
        ],
        child: const MaterialApp(home: CollaborationScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Study Communities'), findsOneWidget);
    expect(find.text('Distributed Systems'), findsOneWidget);
    await tester.tap(find.text('Challenges'));
    await tester.pumpAndSettle();
    expect(find.text('Fault-tolerant consensus'), findsOneWidget);
  });
}
