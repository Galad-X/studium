import 'dart:typed_data';

import '../../../api/serverpod_client.dart' as api;
import 'package:studium_client/studium_client.dart';

class CollaborationService {
  CollaborationService([Client? client]) : client = client ?? api.client;

  final Client client;

  Future<List<Institution>> searchInstitutions(String query,
          {int page = 0, int limit = 30}) =>
      client.collaboration.searchInstitutions(query, page, limit);

  Future<List<InstitutionMembership>> getMyMemberships() =>
      client.collaboration.getMyMemberships();

  Future<InstitutionMembership> requestMembership(
    int institutionId,
    String verificationMethod,
  ) =>
      client.collaboration.requestMembership(
        institutionId,
        verificationMethod,
      );

  Future<List<VerificationRequest>> getMyVerificationRequests() =>
      client.collaboration.getMyVerificationRequests();

  Future<AcademicProfile?> getAcademicProfile(int institutionId) =>
      client.collaboration.getAcademicProfile(institutionId);

  Future<AcademicProfile> upsertAcademicProfile({
    required int institutionId,
    String? department,
    String? programme,
    String? level,
    List<String> subjects = const [],
    List<String> interests = const [],
    List<String> languages = const [],
    String? availability,
  }) =>
      client.collaboration.upsertAcademicProfile(
        institutionId,
        department,
        programme,
        level,
        subjects,
        interests,
        languages,
        availability,
      );

  Future<VerificationRequest> submitVerificationEvidence(
    int membershipId,
    String evidenceUrl,
  ) =>
      client.collaboration.submitVerificationEvidence(
        membershipId,
        evidenceUrl,
      );

  Future<List<StudyRoom>> getRooms({
    int page = 0,
    int limit = 30,
    int? institutionId,
    String? subject,
  }) =>
      client.collaboration.getRooms(page, limit, institutionId, subject);

  Future<List<Challenge>> getChallenges({int page = 0, int limit = 30}) =>
      client.collaboration.getChallenges(page, limit, null);

  Future<StudyRoom> createRoom({
    int? institutionId,
    required String title,
    required String description,
    String? subject,
    String visibility = 'public',
  }) =>
      client.collaboration.createRoom(
        institutionId,
        title,
        description,
        subject,
        visibility,
      );

  Future<Challenge> createChallenge({
    int? roomId,
    required String title,
    required String problemStatement,
    required String field,
    List<String> tags = const [],
    String difficulty = 'intermediate',
  }) =>
      client.collaboration.createChallenge(
        roomId,
        title,
        problemStatement,
        field,
        tags,
        difficulty,
      );

  Future<RoomMembership> joinRoom(int roomId) =>
      client.collaboration.joinRoom(roomId);

  Future<RoomMembership?> getMyRoomMembership(int roomId) =>
      client.collaboration.getMyRoomMembership(roomId);

  Future<List<DiscussionPost>> getRoomPosts(int roomId,
          {int page = 0, int limit = 30}) =>
      client.collaboration.getRoomPosts(roomId, page, limit);

  Future<List<RoomResource>> getRoomResources(int roomId,
          {int page = 0, int limit = 30}) =>
      client.collaboration.getRoomResources(roomId, page, limit);

  Future<RoomResource> addRoomResource({
    required int roomId,
    required String resourceType,
    required String title,
    String? uri,
    String? content,
    String? citation,
  }) =>
      client.collaboration.addRoomResource(
        roomId,
        resourceType,
        title,
        uri,
        content,
        citation,
      );

  Future<RoomResource> uploadRoomResource({
    required int roomId,
    required String resourceType,
    required String title,
    required String fileType,
    required ByteData fileData,
    String? citation,
  }) =>
      client.collaboration.uploadRoomResource(
        roomId,
        resourceType,
        title,
        fileType,
        fileData,
        citation,
      );

  Future<List<RoomAiAnswer>> getRoomAiAnswers(int roomId,
          {int page = 0, int limit = 30}) =>
      client.collaboration.getRoomAiAnswers(roomId, page, limit);

  Future<RoomAiAnswer> askRoom(int roomId, String question) =>
      client.collaboration.askRoom(roomId, question);

  Future<DiscussionPost> createPost(int roomId, String body) =>
      client.collaboration.createPost(roomId, body);

  Future<List<Comment>> getPostComments(int postId,
          {int page = 0, int limit = 30}) =>
      client.collaboration.getPostComments(postId, page, limit);

  Future<Comment> createComment(
    int postId,
    String body, {
    int? parentCommentId,
  }) =>
      client.collaboration.createComment(postId, body, parentCommentId);

  Stream<DiscussionPost> roomPostStream(int roomId) =>
      client.collaboration.roomPostStream(roomId);

  Future<List<RoomChatMessage>> getRoomChatMessages(int roomId,
          {int page = 0, int limit = 100}) =>
      client.collaboration.getRoomChatMessages(roomId, page, limit);

  Stream<RoomChatMessage> roomChatStream(int roomId) =>
      client.collaboration.roomChatStream(roomId);

  Future<RoomChatMessage> createRoomChatMessage(int roomId, String body) =>
      client.collaboration.createRoomChatMessage(roomId, body);

  Future<ContentReport> reportContent({
    required String contentType,
    required int contentId,
    required String reason,
    String? details,
  }) =>
      client.collaboration.reportContent(
        contentType,
        contentId,
        reason,
        details,
      );

  Future<List<ContentReport>> getMyContentReports({
    int page = 0,
    int limit = 50,
  }) =>
      client.collaboration.getMyContentReports(page: page, limit: limit);

  Future<ModerationAppeal> submitModerationAppeal(
    int reportId,
    String reason,
  ) =>
      client.collaboration.submitModerationAppeal(reportId, reason);

  Future<List<ModerationAppeal>> getMyModerationAppeals({
    int page = 0,
    int limit = 30,
  }) =>
      client.collaboration.getMyModerationAppeals(page, limit);

  Future<List<ChallengeTeam>> getChallengeTeams(int challengeId) =>
      client.collaboration.getChallengeTeams(challengeId);

  Future<UserReputation> getMyReputation() =>
      client.collaboration.getMyReputation();

  Future<List<ChallengeTeamMember>> getChallengeTeamMembers(int teamId,
          {int page = 0, int limit = 100}) =>
      client.collaboration.getChallengeTeamMembers(teamId, page, limit);

  Future<String> createChallengeTeamInvite(
    int teamId,
    int inviteeId, {
    int expiresInDays = 7,
  }) =>
      client.collaboration
          .createChallengeTeamInvite(teamId, inviteeId, expiresInDays);

  Future<ChallengeTeamMember> acceptChallengeTeamInvite(String token) =>
      client.collaboration.acceptChallengeTeamInvite(token);

  Future<ChallengeTeam> createChallengeTeam(
    int challengeId,
    String name,
    String? description,
  ) =>
      client.collaboration.createChallengeTeam(
        challengeId,
        name,
        description,
      );

  Future<ChallengeTeamMember> joinChallengeTeam(int teamId) =>
      client.collaboration.joinChallengeTeam(teamId);

  Future<List<ChallengeMilestone>> getTeamMilestones(int teamId,
          {int page = 0, int limit = 50}) =>
      client.collaboration.getTeamMilestones(teamId, page, limit);

  Future<List<ChallengeProgressUpdate>> getTeamUpdates(int teamId,
          {int page = 0, int limit = 50}) =>
      client.collaboration.getTeamUpdates(teamId, page, limit);

  Future<ChallengeMilestone> createMilestone(
    int teamId,
    String title,
    String? description,
    DateTime? dueAt,
  ) =>
      client.collaboration.createMilestone(
        teamId,
        title,
        description,
        dueAt,
      );

  Future<ChallengeMilestone> updateChallengeMilestone(
    int milestoneId,
    String title,
    String? description,
    String status,
    DateTime? dueAt,
  ) =>
      client.collaboration.updateChallengeMilestone(
        milestoneId,
        title,
        description,
        status,
        dueAt,
      );

  Future<ChallengeTeamMember> updateChallengeTeamMember(
    int membershipId,
    String role,
    String status,
  ) =>
      client.collaboration.updateChallengeTeamMember(
        membershipId,
        role,
        status,
      );

  Future<ChallengeProgressUpdate> postChallengeUpdate(
          int teamId, String body) =>
      client.collaboration.postChallengeUpdate(teamId, body);

  Future<List<Opportunity>> getOpportunities({
    int page = 0,
    int limit = 30,
    String? country,
    String? field,
    String? educationLevel,
    String? opportunityType,
    DateTime? deadlineBefore,
  }) =>
      client.opportunity.getOpportunities(
        page,
        limit,
        country,
        field,
        educationLevel,
        opportunityType,
        deadlineBefore,
      );

  Future<OpportunitySave> saveOpportunity(
    int opportunityId, {
    bool alertEnabled = true,
  }) =>
      client.opportunity.saveOpportunity(opportunityId, alertEnabled);

  Future<List<OpportunitySave>> getSavedOpportunities({
    int page = 0,
    int limit = 30,
  }) =>
      client.opportunity.getSavedOpportunities(page, limit);

  Future<OpportunityAlert> createOpportunityAlert({
    String? country,
    String? field,
    String? educationLevel,
    List<String> opportunityTypes = const [],
    int deadlineWithinDays = 30,
  }) =>
      client.opportunity.createOpportunityAlert(
        country,
        field,
        educationLevel,
        opportunityTypes,
        deadlineWithinDays,
      );

  Future<List<OpportunityAlert>> getOpportunityAlerts() =>
      client.opportunity.getOpportunityAlerts();

  Future<void> deactivateOpportunityAlert(int alertId) =>
      client.opportunity.deactivateOpportunityAlert(alertId);

  Future<List<OpportunityApplicationTracker>> getApplicationTrackers({
    int page = 0,
    int limit = 50,
  }) =>
      client.opportunity.getApplicationTrackers(page, limit);

  Future<OpportunityApplicationTracker> upsertApplicationTracker({
    required int opportunityId,
    required String status,
    String? notes,
    String? applicationUrl,
  }) =>
      client.opportunity.upsertApplicationTracker(
        opportunityId,
        status,
        notes,
        applicationUrl,
      );

  Future<Conversation> createConversation(
    List<int> participantIds, {
    String? title,
  }) =>
      client.messaging.createConversation(participantIds, title);

  Future<List<Conversation>> getMyConversations() =>
      client.messaging.getMyConversations();

  Future<List<DirectMessage>> getConversationMessages(int conversationId,
          {int page = 0, int limit = 100}) =>
      client.messaging.getConversationMessages(conversationId, page, limit);

  Stream<DirectMessage> conversationStream(int conversationId) =>
      client.messaging.conversationStream(conversationId);

  Future<DirectMessage> sendMessage(int conversationId, String body) =>
      client.messaging.sendMessage(conversationId, body);

  Future<ConversationReadReceipt> markConversationRead(
    int conversationId,
    int messageId,
  ) =>
      client.messaging.markConversationRead(conversationId, messageId);

  Future<List<ConversationReadReceipt>> getConversationReadReceipts(
    int conversationId,
  ) =>
      client.messaging.getConversationReadReceipts(conversationId);

  Future<UserSafetyRelationship> setSafetyRelationship(
    int targetUserId,
    String relationshipType,
  ) =>
      client.messaging.setSafetyRelationship(targetUserId, relationshipType);

  Future<bool> removeSafetyRelationship(
    int targetUserId,
    String relationshipType,
  ) =>
      client.messaging.removeSafetyRelationship(targetUserId, relationshipType);

  Future<List<UserSafetyRelationship>> getMySafetyRelationships({
    int page = 0,
    int limit = 100,
  }) =>
      client.messaging.getMySafetyRelationships(page, limit);

  Future<UserPrivacySettings> getMyPrivacySettings() =>
      client.messaging.getMyPrivacySettings();

  Future<UserPrivacySettings> updateMyPrivacySettings({
    bool? isMinor,
    bool? allowUnknownDirectMessages,
  }) =>
      client.messaging.updateMyPrivacySettings(
        isMinor: isMinor,
        allowUnknownDirectMessages: allowUnknownDirectMessages,
      );

  Future<CollaborationPresence> updateRoomPresence(
    int roomId,
    String state,
  ) =>
      client.collaboration.updateRoomPresence(roomId, state);

  Future<List<CollaborationPresence>> getRoomPresence(int roomId) =>
      client.collaboration.getRoomPresence(roomId);

  Future<ScheduledStudySession> createStudySession({
    required int roomId,
    required String title,
    String? description,
    required DateTime startsAt,
    required DateTime endsAt,
    String? meetingUrl,
  }) =>
      client.collaboration.createStudySession(
        roomId,
        title,
        description,
        startsAt,
        endsAt,
        meetingUrl,
      );

  Future<List<ScheduledStudySession>> getRoomStudySessions(int roomId,
          {int page = 0, int limit = 30}) =>
      client.collaboration.getRoomStudySessions(roomId, page, limit);

  Future<StudySessionParticipant> joinStudySession(int sessionId) =>
      client.collaboration.joinStudySession(sessionId);

  Future<String> createInstitutionInvite(
    int institutionId, {
    int expiresInDays = 7,
    int maxUses = 20,
  }) =>
      client.collaboration.createInstitutionInvite(
        institutionId,
        expiresInDays,
        maxUses,
      );

  Future<InstitutionMembership> acceptInstitutionInvite(String token) =>
      client.collaboration.acceptInstitutionInvite(token);

  Future<List<InstitutionMembership>> getInstitutionMembers(
    int institutionId, {
    int page = 0,
    int limit = 50,
  }) =>
      client.collaboration.getInstitutionMembers(institutionId, page, limit);

  Future<InstitutionMembership> updateInstitutionMember(
    int membershipId,
    String role,
    String status,
  ) =>
      client.collaboration.updateInstitutionMember(
        membershipId,
        role,
        status,
      );

  Future<InstitutionMembership> reviewMembership(
    int membershipId,
    String decision,
  ) =>
      client.collaboration.reviewMembership(membershipId, decision);

  Future<List<CollaborativeDocument>> getRoomDocuments(int roomId,
          {int page = 0, int limit = 30}) =>
      client.collaboration.getRoomDocuments(roomId, page, limit);

  Stream<CollaborativeDocument> documentStream(int documentId) =>
      client.collaboration.documentStream(documentId);

  Future<CollaborativeDocument> createDocument(
    int roomId,
    String title,
    String body,
  ) =>
      client.collaboration.createDocument(roomId, title, body);

  Future<CollaborativeDocument> updateDocument(
    int documentId,
    String title,
    String body,
    int expectedVersion,
  ) =>
      client.collaboration.updateDocument(
        documentId,
        title,
        body,
        expectedVersion,
      );
}
