import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/providers/service_providers.dart';
import '../services/collaboration_service.dart';

final collaborationServiceProvider = Provider<CollaborationService>(
  (ref) => CollaborationService(ref.watch(clientProvider)),
);

final institutionSearchProvider =
    FutureProvider.autoDispose.family<List<Institution>, String>(
  (ref, query) =>
      ref.watch(collaborationServiceProvider).searchInstitutions(query),
);

final myMembershipsProvider =
    FutureProvider.autoDispose<List<InstitutionMembership>>(
  (ref) => ref.watch(collaborationServiceProvider).getMyMemberships(),
);

final myReputationProvider = FutureProvider.autoDispose<UserReputation>(
  (ref) => ref.watch(collaborationServiceProvider).getMyReputation(),
);

final userReputationProvider =
    FutureProvider.autoDispose.family<UserReputation, int>(
  (ref, userId) =>
      ref.watch(collaborationServiceProvider).getUserReputation(userId),
);

final studyRoomsProvider =
    FutureProvider.autoDispose.family<List<StudyRoom>, String?>(
  (ref, subject) async {
    final cache = ref.read(collaborationCacheProvider);
    final key = 'collaboration.rooms.${subject ?? 'all'}';
    try {
      final rooms = await ref
          .read(collaborationServiceProvider)
          .getRooms(subject: subject);
      await cache.writeList(key, rooms, (room) => room.toJson());
      return rooms;
    } catch (_) {
      return cache.readList(key, StudyRoom.fromJson);
    }
  },
);

final challengesProvider = FutureProvider.autoDispose<List<Challenge>>(
  (ref) async {
    final cache = ref.read(collaborationCacheProvider);
    const key = 'collaboration.challenges.all';
    try {
      final values =
          await ref.read(collaborationServiceProvider).getChallenges();
      await cache.writeList(key, values, (value) => value.toJson());
      return values;
    } catch (_) {
      return cache.readList(key, Challenge.fromJson);
    }
  },
);

final challengeTeamsProvider =
    FutureProvider.autoDispose.family<List<ChallengeTeam>, int>(
  (ref, challengeId) =>
      ref.watch(collaborationServiceProvider).getChallengeTeams(challengeId),
);

final challengeTeamMembersProvider =
    FutureProvider.autoDispose.family<List<ChallengeTeamMember>, int>(
  (ref, teamId) =>
      ref.watch(collaborationServiceProvider).getChallengeTeamMembers(teamId),
);

final teamMilestonesProvider =
    FutureProvider.autoDispose.family<List<ChallengeMilestone>, int>(
  (ref, teamId) =>
      ref.watch(collaborationServiceProvider).getTeamMilestones(teamId),
);

final teamUpdatesProvider =
    FutureProvider.autoDispose.family<List<ChallengeProgressUpdate>, int>(
  (ref, teamId) =>
      ref.watch(collaborationServiceProvider).getTeamUpdates(teamId),
);

class OpportunityFilters {
  const OpportunityFilters({
    this.country,
    this.field,
    this.educationLevel,
    this.opportunityType,
    this.deadlineBefore,
  });

  final String? country;
  final String? field;
  final String? educationLevel;
  final String? opportunityType;
  final DateTime? deadlineBefore;

  @override
  bool operator ==(Object other) =>
      other is OpportunityFilters &&
      other.country == country &&
      other.field == field &&
      other.educationLevel == educationLevel &&
      other.opportunityType == opportunityType &&
      other.deadlineBefore == deadlineBefore;

  @override
  int get hashCode => Object.hash(
        country,
        field,
        educationLevel,
        opportunityType,
        deadlineBefore,
      );
}

final opportunitiesQueryProvider =
    FutureProvider.autoDispose.family<List<Opportunity>, OpportunityFilters>(
  (ref, filters) async {
    final cache = ref.read(collaborationCacheProvider);
    final key = 'collaboration.opportunities.${filters.hashCode}';
    try {
      final values =
          await ref.read(collaborationServiceProvider).getOpportunities(
                country: filters.country,
                field: filters.field,
                educationLevel: filters.educationLevel,
                opportunityType: filters.opportunityType,
                deadlineBefore: filters.deadlineBefore,
              );
      await cache.writeList(key, values, (value) => value.toJson());
      return values;
    } catch (_) {
      return cache.readList(key, Opportunity.fromJson);
    }
  },
);

final opportunitiesProvider = FutureProvider.autoDispose<List<Opportunity>>(
  (ref) =>
      ref.watch(opportunitiesQueryProvider(const OpportunityFilters()).future),
);

final roomPostsProvider =
    FutureProvider.autoDispose.family<List<DiscussionPost>, int>(
  (ref, roomId) => ref.watch(collaborationServiceProvider).getRoomPosts(roomId),
);

final roomResourcesProvider =
    FutureProvider.autoDispose.family<List<RoomResource>, int>(
  (ref, roomId) async {
    final cache = ref.read(collaborationCacheProvider);
    final key = 'collaboration.room_resources.$roomId';
    try {
      final values =
          await ref.read(collaborationServiceProvider).getRoomResources(roomId);
      await cache.writeList(key, values, (value) => value.toJson());
      return values;
    } catch (_) {
      return cache.readList(key, RoomResource.fromJson);
    }
  },
);

final myRoomMembershipProvider =
    FutureProvider.autoDispose.family<RoomMembership?, int>(
  (ref, roomId) =>
      ref.watch(collaborationServiceProvider).getMyRoomMembership(roomId),
);

final postCommentsProvider =
    FutureProvider.autoDispose.family<List<Comment>, int>(
  (ref, postId) =>
      ref.watch(collaborationServiceProvider).getPostComments(postId),
);

final roomPostStreamProvider =
    StreamProvider.autoDispose.family<DiscussionPost, int>(
  (ref, roomId) =>
      ref.watch(collaborationServiceProvider).roomPostStream(roomId),
);

final roomChatMessagesProvider =
    FutureProvider.autoDispose.family<List<RoomChatMessage>, int>(
  (ref, roomId) =>
      ref.watch(collaborationServiceProvider).getRoomChatMessages(roomId),
);

final roomChatStreamProvider =
    StreamProvider.autoDispose.family<RoomChatMessage, int>(
  (ref, roomId) =>
      ref.watch(collaborationServiceProvider).roomChatStream(roomId),
);

final roomPresenceProvider =
    FutureProvider.autoDispose.family<List<CollaborationPresence>, int>(
  (ref, roomId) =>
      ref.watch(collaborationServiceProvider).getRoomPresence(roomId),
);

/// Coordinates presence mutations while [roomPresenceProvider] remains the
/// durable read model rendered by the room screen.
class RoomPresenceController {
  const RoomPresenceController(this._service, this.roomId);

  final CollaborationService _service;
  final int roomId;

  Future<void> setState(String state) async {
    await _service.updateRoomPresence(roomId, state);
  }
}

final roomPresenceControllerProvider =
    Provider.autoDispose.family<RoomPresenceController, int>(
  (ref, roomId) =>
      RoomPresenceController(ref.watch(collaborationServiceProvider), roomId),
);

final roomWhiteboardProvider =
    FutureProvider.autoDispose.family<RoomWhiteboardState?, int>(
  (ref, roomId) =>
      ref.watch(collaborationServiceProvider).getRoomWhiteboard(roomId),
);

final roomStudySessionsProvider =
    FutureProvider.autoDispose.family<List<ScheduledStudySession>, int>(
  (ref, roomId) =>
      ref.watch(collaborationServiceProvider).getRoomStudySessions(roomId),
);

final roomDocumentsProvider =
    FutureProvider.autoDispose.family<List<CollaborativeDocument>, int>(
  (ref, roomId) =>
      ref.watch(collaborationServiceProvider).getRoomDocuments(roomId),
);

final savedOpportunitiesProvider =
    FutureProvider.autoDispose<List<OpportunitySave>>(
  (ref) => ref.watch(collaborationServiceProvider).getSavedOpportunities(),
);

final opportunityAlertsProvider =
    FutureProvider.autoDispose<List<OpportunityAlert>>(
  (ref) => ref.watch(collaborationServiceProvider).getOpportunityAlerts(),
);

final myModerationAppealsProvider =
    FutureProvider.autoDispose<List<ModerationAppeal>>(
  (ref) => ref.watch(collaborationServiceProvider).getMyModerationAppeals(),
);

final myContentReportsProvider =
    FutureProvider.autoDispose<List<ContentReport>>(
  (ref) => ref.watch(collaborationServiceProvider).getMyContentReports(),
);

final applicationTrackersProvider =
    FutureProvider.autoDispose<List<OpportunityApplicationTracker>>(
  (ref) => ref.watch(collaborationServiceProvider).getApplicationTrackers(),
);

final conversationsProvider = FutureProvider.autoDispose<List<Conversation>>(
  (ref) => ref.watch(collaborationServiceProvider).getMyConversations(),
);

final conversationMessagesProvider =
    FutureProvider.autoDispose.family<List<DirectMessage>, int>(
  (ref, conversationId) async {
    final cache = ref.read(collaborationCacheProvider);
    final key = 'collaboration.conversation_messages.$conversationId';
    try {
      final values = await ref
          .read(collaborationServiceProvider)
          .getConversationMessages(conversationId);
      await cache.writeList(key, values, (value) => value.toJson());
      return values;
    } catch (_) {
      return cache.readList(key, DirectMessage.fromJson);
    }
  },
);

final conversationStreamProvider =
    StreamProvider.autoDispose.family<DirectMessage, int>(
  (ref, conversationId) => ref
      .watch(collaborationServiceProvider)
      .conversationStream(conversationId),
);

final conversationReadReceiptsProvider =
    FutureProvider.autoDispose.family<List<ConversationReadReceipt>, int>(
  (ref, conversationId) => ref
      .watch(collaborationServiceProvider)
      .getConversationReadReceipts(conversationId),
);

final mySafetyRelationshipsProvider =
    FutureProvider.autoDispose<List<UserSafetyRelationship>>(
  (ref) => ref.watch(collaborationServiceProvider).getMySafetyRelationships(),
);

final myPrivacySettingsProvider =
    FutureProvider.autoDispose<UserPrivacySettings>(
  (ref) => ref.watch(collaborationServiceProvider).getMyPrivacySettings(),
);
