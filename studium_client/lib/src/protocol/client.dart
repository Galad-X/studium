/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:studium_client/src/protocol/academic_writings.dart' as _i3;
import 'package:studium_client/src/protocol/questions.dart' as _i4;
import 'package:studium_client/src/protocol/answers.dart' as _i5;
import 'package:studium_client/src/protocol/summaries.dart' as _i6;
import 'package:studium_client/src/protocol/research_comparisons.dart' as _i7;
import 'package:studium_client/src/protocol/user_analytics.dart' as _i8;
import 'package:studium_client/src/protocol/user_reputation.dart' as _i9;
import 'package:studium_client/src/protocol/institution.dart' as _i10;
import 'package:studium_client/src/protocol/institution_membership.dart'
    as _i11;
import 'package:studium_client/src/protocol/verification_request.dart' as _i12;
import 'package:studium_client/src/protocol/academic_profile.dart' as _i13;
import 'package:studium_client/src/protocol/study_room.dart' as _i14;
import 'package:studium_client/src/protocol/room_membership.dart' as _i15;
import 'package:studium_client/src/protocol/discussion_post.dart' as _i16;
import 'package:studium_client/src/protocol/challenge.dart' as _i17;
import 'package:studium_client/src/protocol/room_resource.dart' as _i18;
import 'dart:typed_data' as _i19;
import 'package:studium_client/src/protocol/room_resource_chunk.dart' as _i20;
import 'package:studium_client/src/protocol/challenge_team.dart' as _i21;
import 'package:studium_client/src/protocol/challenge_team_member.dart' as _i22;
import 'package:studium_client/src/protocol/challenge_milestone.dart' as _i23;
import 'package:studium_client/src/protocol/challenge_update.dart' as _i24;
import 'package:studium_client/src/protocol/comment.dart' as _i25;
import 'package:studium_client/src/protocol/discussion_reaction.dart' as _i26;
import 'package:studium_client/src/protocol/room_chat_message.dart' as _i27;
import 'package:studium_client/src/protocol/room_ai_answer.dart' as _i28;
import 'package:studium_client/src/protocol/collaboration_presence.dart'
    as _i29;
import 'package:studium_client/src/protocol/scheduled_study_session.dart'
    as _i30;
import 'package:studium_client/src/protocol/study_session_participant.dart'
    as _i31;
import 'package:studium_client/src/protocol/content_report.dart' as _i32;
import 'package:studium_client/src/protocol/audit_event.dart' as _i33;
import 'package:studium_client/src/protocol/moderation_appeal.dart' as _i34;
import 'package:studium_client/src/protocol/collaborative_document.dart'
    as _i35;
import 'package:studium_client/src/protocol/user_privacy_settings.dart' as _i36;
import 'package:studium_client/src/protocol/user_safety_relationship.dart'
    as _i37;
import 'package:studium_client/src/protocol/conversation.dart' as _i38;
import 'package:studium_client/src/protocol/direct_message.dart' as _i39;
import 'package:studium_client/src/protocol/conversation_read_receipt.dart'
    as _i40;
import 'package:studium_client/src/protocol/notifications.dart' as _i41;
import 'package:studium_client/src/protocol/push_device.dart' as _i42;
import 'package:studium_client/src/protocol/opportunity_source.dart' as _i43;
import 'package:studium_client/src/protocol/opportunity.dart' as _i44;
import 'package:studium_client/src/protocol/opportunity_save.dart' as _i45;
import 'package:studium_client/src/protocol/opportunity_alert.dart' as _i46;
import 'package:studium_client/src/protocol/opportunity_application_tracker.dart'
    as _i47;
import 'package:studium_client/src/protocol/study_materials.dart' as _i48;
import 'package:studium_client/src/protocol/file_processing.dart' as _i49;
import 'package:studium_client/src/protocol/subscriptions.dart' as _i50;
import 'package:studium_client/src/protocol/user_profile_bundle.dart' as _i51;
import 'package:studium_client/src/protocol/user_profile.dart' as _i52;
import 'package:studium_client/src/protocol/dashboard_bundle.dart' as _i53;
import 'package:studium_client/src/protocol/study_history.dart' as _i54;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i55;
import 'protocol.dart' as _i56;

/// {@category Endpoint}
class EndpointAcademicWriting extends _i1.EndpointRef {
  EndpointAcademicWriting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'academicWriting';

  _i2.Future<_i3.AcademicWriting> generateWriting(
    int? studyMaterialId,
    String type,
    String title,
    String format,
    int? targetWordCount,
  ) => caller.callServerEndpoint<_i3.AcademicWriting>(
    'academicWriting',
    'generateWriting',
    {
      'studyMaterialId': studyMaterialId,
      'type': type,
      'title': title,
      'format': format,
      'targetWordCount': targetWordCount,
    },
  );

  _i2.Future<List<_i3.AcademicWriting>> getWritings() =>
      caller.callServerEndpoint<List<_i3.AcademicWriting>>(
        'academicWriting',
        'getWritings',
        {},
      );

  _i2.Future<bool> deleteWriting(int writingId) =>
      caller.callServerEndpoint<bool>(
        'academicWriting',
        'deleteWriting',
        {'writingId': writingId},
      );
}

/// {@category Endpoint}
class EndpointAi extends _i1.EndpointRef {
  EndpointAi(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ai';

  _i2.Future<List<_i4.Question>> generateQuestions(
    int studyMaterialId,
    List<String>? questionTypes,
    int count,
  ) => caller.callServerEndpoint<List<_i4.Question>>(
    'ai',
    'generateQuestions',
    {
      'studyMaterialId': studyMaterialId,
      'questionTypes': questionTypes,
      'count': count,
    },
  );

  /// Submit and evaluate an answer
  _i2.Future<_i5.Answer> submitAnswer(
    int questionId,
    String answerText,
  ) => caller.callServerEndpoint<_i5.Answer>(
    'ai',
    'submitAnswer',
    {
      'questionId': questionId,
      'answerText': answerText,
    },
  );

  _i2.Future<_i6.Summary> generateSummary(
    int studyMaterialId,
    int? maxWords,
  ) => caller.callServerEndpoint<_i6.Summary>(
    'ai',
    'generateSummary',
    {
      'studyMaterialId': studyMaterialId,
      'maxWords': maxWords,
    },
  );

  _i2.Future<_i6.Summary> generateSampleSummary(int maxWords) =>
      caller.callServerEndpoint<_i6.Summary>(
        'ai',
        'generateSampleSummary',
        {'maxWords': maxWords},
      );

  _i2.Future<_i3.AcademicWriting> generateAcademicWriting(
    int? studyMaterialId,
    String type,
    String title,
    String format,
    int? targetWordCount,
  ) => caller.callServerEndpoint<_i3.AcademicWriting>(
    'ai',
    'generateAcademicWriting',
    {
      'studyMaterialId': studyMaterialId,
      'type': type,
      'title': title,
      'format': format,
      'targetWordCount': targetWordCount,
    },
  );

  _i2.Future<_i7.ResearchComparison> generateResearchComparison(
    int studyMaterialId,
  ) => caller.callServerEndpoint<_i7.ResearchComparison>(
    'ai',
    'generateResearchComparison',
    {'studyMaterialId': studyMaterialId},
  );
}

/// {@category Endpoint}
class EndpointAnalytics extends _i1.EndpointRef {
  EndpointAnalytics(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'analytics';

  _i2.Future<bool> logAction(
    String action,
    String? metadata,
  ) => caller.callServerEndpoint<bool>(
    'analytics',
    'logAction',
    {
      'action': action,
      'metadata': metadata,
    },
  );

  _i2.Future<List<_i8.UserAnalytics>> getAnalytics() =>
      caller.callServerEndpoint<List<_i8.UserAnalytics>>(
        'analytics',
        'getAnalytics',
        {},
      );
}

/// {@category Endpoint}
class EndpointBillingWebhook extends _i1.EndpointRef {
  EndpointBillingWebhook(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'billingWebhook';

  _i2.Future<bool> handleWebhook(
    String gateway,
    String eventId,
    String eventType,
    String payload,
    String signature,
  ) => caller.callServerEndpoint<bool>(
    'billingWebhook',
    'handleWebhook',
    {
      'gateway': gateway,
      'eventId': eventId,
      'eventType': eventType,
      'payload': payload,
      'signature': signature,
    },
  );
}

/// {@category Endpoint}
class EndpointCollaboration extends _i1.EndpointRef {
  EndpointCollaboration(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'collaboration';

  _i2.Future<_i9.UserReputation> getMyReputation() =>
      caller.callServerEndpoint<_i9.UserReputation>(
        'collaboration',
        'getMyReputation',
        {},
      );

  _i2.Future<List<_i10.Institution>> searchInstitutions(
    String query,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i10.Institution>>(
    'collaboration',
    'searchInstitutions',
    {
      'query': query,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i10.Institution> submitInstitution(
    String name,
    String country,
    String? region,
    List<String> domains,
    String? logoUrl,
  ) => caller.callServerEndpoint<_i10.Institution>(
    'collaboration',
    'submitInstitution',
    {
      'name': name,
      'country': country,
      'region': region,
      'domains': domains,
      'logoUrl': logoUrl,
    },
  );

  _i2.Future<_i10.Institution> reviewInstitution(
    int institutionId,
    String decision,
  ) => caller.callServerEndpoint<_i10.Institution>(
    'collaboration',
    'reviewInstitution',
    {
      'institutionId': institutionId,
      'decision': decision,
    },
  );

  _i2.Future<List<_i10.Institution>> getPendingInstitutionReviews(
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i10.Institution>>(
    'collaboration',
    'getPendingInstitutionReviews',
    {
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<List<_i11.InstitutionMembership>> getMyMemberships() =>
      caller.callServerEndpoint<List<_i11.InstitutionMembership>>(
        'collaboration',
        'getMyMemberships',
        {},
      );

  _i2.Future<List<_i12.VerificationRequest>> getMyVerificationRequests() =>
      caller.callServerEndpoint<List<_i12.VerificationRequest>>(
        'collaboration',
        'getMyVerificationRequests',
        {},
      );

  _i2.Future<_i13.AcademicProfile?> getAcademicProfile(int institutionId) =>
      caller.callServerEndpoint<_i13.AcademicProfile?>(
        'collaboration',
        'getAcademicProfile',
        {'institutionId': institutionId},
      );

  _i2.Future<_i13.AcademicProfile> upsertAcademicProfile(
    int institutionId,
    String? department,
    String? programme,
    String? level,
    List<String> subjects,
    List<String> interests,
    List<String> languages,
    String? availability,
  ) => caller.callServerEndpoint<_i13.AcademicProfile>(
    'collaboration',
    'upsertAcademicProfile',
    {
      'institutionId': institutionId,
      'department': department,
      'programme': programme,
      'level': level,
      'subjects': subjects,
      'interests': interests,
      'languages': languages,
      'availability': availability,
    },
  );

  _i2.Future<String> createInstitutionInvite(
    int institutionId,
    int expiresInDays,
    int maxUses,
  ) => caller.callServerEndpoint<String>(
    'collaboration',
    'createInstitutionInvite',
    {
      'institutionId': institutionId,
      'expiresInDays': expiresInDays,
      'maxUses': maxUses,
    },
  );

  _i2.Future<_i11.InstitutionMembership> acceptInstitutionInvite(
    String token,
  ) => caller.callServerEndpoint<_i11.InstitutionMembership>(
    'collaboration',
    'acceptInstitutionInvite',
    {'token': token},
  );

  _i2.Future<List<_i11.InstitutionMembership>> getInstitutionMembers(
    int institutionId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i11.InstitutionMembership>>(
    'collaboration',
    'getInstitutionMembers',
    {
      'institutionId': institutionId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<List<_i12.VerificationRequest>> getInstitutionVerificationRequests(
    int institutionId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i12.VerificationRequest>>(
    'collaboration',
    'getInstitutionVerificationRequests',
    {
      'institutionId': institutionId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i11.InstitutionMembership> updateInstitutionMember(
    int membershipId,
    String role,
    String status,
  ) => caller.callServerEndpoint<_i11.InstitutionMembership>(
    'collaboration',
    'updateInstitutionMember',
    {
      'membershipId': membershipId,
      'role': role,
      'status': status,
    },
  );

  _i2.Future<_i11.InstitutionMembership> requestMembership(
    int institutionId,
    String verificationMethod,
  ) => caller.callServerEndpoint<_i11.InstitutionMembership>(
    'collaboration',
    'requestMembership',
    {
      'institutionId': institutionId,
      'verificationMethod': verificationMethod,
    },
  );

  _i2.Future<_i12.VerificationRequest> submitVerificationEvidence(
    int membershipId,
    String evidenceUrl,
  ) => caller.callServerEndpoint<_i12.VerificationRequest>(
    'collaboration',
    'submitVerificationEvidence',
    {
      'membershipId': membershipId,
      'evidenceUrl': evidenceUrl,
    },
  );

  _i2.Future<_i11.InstitutionMembership> reviewMembership(
    int membershipId,
    String decision,
  ) => caller.callServerEndpoint<_i11.InstitutionMembership>(
    'collaboration',
    'reviewMembership',
    {
      'membershipId': membershipId,
      'decision': decision,
    },
  );

  _i2.Future<List<_i14.StudyRoom>> getRooms(
    int page,
    int limit, [
    int? institutionId,
    String? subject,
  ]) => caller.callServerEndpoint<List<_i14.StudyRoom>>(
    'collaboration',
    'getRooms',
    {
      'page': page,
      'limit': limit,
      'institutionId': institutionId,
      'subject': subject,
    },
  );

  _i2.Future<_i14.StudyRoom> createRoom(
    int? institutionId,
    String title,
    String description,
    String? subject,
    String visibility,
  ) => caller.callServerEndpoint<_i14.StudyRoom>(
    'collaboration',
    'createRoom',
    {
      'institutionId': institutionId,
      'title': title,
      'description': description,
      'subject': subject,
      'visibility': visibility,
    },
  );

  _i2.Future<_i15.RoomMembership> joinRoom(int roomId) =>
      caller.callServerEndpoint<_i15.RoomMembership>(
        'collaboration',
        'joinRoom',
        {'roomId': roomId},
      );

  _i2.Future<_i15.RoomMembership?> getMyRoomMembership(int roomId) =>
      caller.callServerEndpoint<_i15.RoomMembership?>(
        'collaboration',
        'getMyRoomMembership',
        {'roomId': roomId},
      );

  _i2.Future<List<_i16.DiscussionPost>> getRoomPosts(
    int roomId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i16.DiscussionPost>>(
    'collaboration',
    'getRoomPosts',
    {
      'roomId': roomId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i16.DiscussionPost> createPost(
    int roomId,
    String body,
  ) => caller.callServerEndpoint<_i16.DiscussionPost>(
    'collaboration',
    'createPost',
    {
      'roomId': roomId,
      'body': body,
    },
  );

  _i2.Future<List<_i17.Challenge>> getChallenges(
    int page,
    int limit,
    int? roomId,
  ) => caller.callServerEndpoint<List<_i17.Challenge>>(
    'collaboration',
    'getChallenges',
    {
      'page': page,
      'limit': limit,
      'roomId': roomId,
    },
  );

  _i2.Future<_i17.Challenge> createChallenge(
    int? roomId,
    String title,
    String problemStatement,
    String field,
    List<String> tags,
    String difficulty,
  ) => caller.callServerEndpoint<_i17.Challenge>(
    'collaboration',
    'createChallenge',
    {
      'roomId': roomId,
      'title': title,
      'problemStatement': problemStatement,
      'field': field,
      'tags': tags,
      'difficulty': difficulty,
    },
  );

  _i2.Future<List<_i18.RoomResource>> getRoomResources(
    int roomId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i18.RoomResource>>(
    'collaboration',
    'getRoomResources',
    {
      'roomId': roomId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i18.RoomResource> addRoomResource(
    int roomId,
    String resourceType,
    String title,
    String? uri,
    String? content,
    String? citation,
  ) => caller.callServerEndpoint<_i18.RoomResource>(
    'collaboration',
    'addRoomResource',
    {
      'roomId': roomId,
      'resourceType': resourceType,
      'title': title,
      'uri': uri,
      'content': content,
      'citation': citation,
    },
  );

  _i2.Future<_i18.RoomResource> uploadRoomResource(
    int roomId,
    String resourceType,
    String title,
    String fileType,
    _i19.ByteData fileData,
    String? citation,
  ) => caller.callServerEndpoint<_i18.RoomResource>(
    'collaboration',
    'uploadRoomResource',
    {
      'roomId': roomId,
      'resourceType': resourceType,
      'title': title,
      'fileType': fileType,
      'fileData': fileData,
      'citation': citation,
    },
  );

  _i2.Future<List<_i20.RoomResourceChunk>> getRoomResourceChunks(
    int roomId,
    int resourceId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i20.RoomResourceChunk>>(
    'collaboration',
    'getRoomResourceChunks',
    {
      'roomId': roomId,
      'resourceId': resourceId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<int> indexRoomResourceEmbeddings(
    int roomId,
    int resourceId,
  ) => caller.callServerEndpoint<int>(
    'collaboration',
    'indexRoomResourceEmbeddings',
    {
      'roomId': roomId,
      'resourceId': resourceId,
    },
  );

  _i2.Future<List<_i20.RoomResourceChunk>> searchRoomKnowledge(
    int roomId,
    String query,
    int limit,
  ) => caller.callServerEndpoint<List<_i20.RoomResourceChunk>>(
    'collaboration',
    'searchRoomKnowledge',
    {
      'roomId': roomId,
      'query': query,
      'limit': limit,
    },
  );

  _i2.Future<List<_i21.ChallengeTeam>> getChallengeTeams(int challengeId) =>
      caller.callServerEndpoint<List<_i21.ChallengeTeam>>(
        'collaboration',
        'getChallengeTeams',
        {'challengeId': challengeId},
      );

  _i2.Future<List<_i22.ChallengeTeamMember>> getChallengeTeamMembers(
    int teamId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i22.ChallengeTeamMember>>(
    'collaboration',
    'getChallengeTeamMembers',
    {
      'teamId': teamId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i21.ChallengeTeam> createChallengeTeam(
    int challengeId,
    String name,
    String? description,
  ) => caller.callServerEndpoint<_i21.ChallengeTeam>(
    'collaboration',
    'createChallengeTeam',
    {
      'challengeId': challengeId,
      'name': name,
      'description': description,
    },
  );

  _i2.Future<_i22.ChallengeTeamMember> joinChallengeTeam(int teamId) =>
      caller.callServerEndpoint<_i22.ChallengeTeamMember>(
        'collaboration',
        'joinChallengeTeam',
        {'teamId': teamId},
      );

  _i2.Future<String> createChallengeTeamInvite(
    int teamId,
    int inviteeId,
    int expiresInDays,
  ) => caller.callServerEndpoint<String>(
    'collaboration',
    'createChallengeTeamInvite',
    {
      'teamId': teamId,
      'inviteeId': inviteeId,
      'expiresInDays': expiresInDays,
    },
  );

  _i2.Future<_i22.ChallengeTeamMember> acceptChallengeTeamInvite(
    String token,
  ) => caller.callServerEndpoint<_i22.ChallengeTeamMember>(
    'collaboration',
    'acceptChallengeTeamInvite',
    {'token': token},
  );

  _i2.Future<List<_i23.ChallengeMilestone>> getTeamMilestones(
    int teamId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i23.ChallengeMilestone>>(
    'collaboration',
    'getTeamMilestones',
    {
      'teamId': teamId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i23.ChallengeMilestone> createMilestone(
    int teamId,
    String title,
    String? description,
    DateTime? dueAt,
  ) => caller.callServerEndpoint<_i23.ChallengeMilestone>(
    'collaboration',
    'createMilestone',
    {
      'teamId': teamId,
      'title': title,
      'description': description,
      'dueAt': dueAt,
    },
  );

  _i2.Future<_i23.ChallengeMilestone> updateChallengeMilestone(
    int milestoneId,
    String title,
    String? description,
    String status,
    DateTime? dueAt,
  ) => caller.callServerEndpoint<_i23.ChallengeMilestone>(
    'collaboration',
    'updateChallengeMilestone',
    {
      'milestoneId': milestoneId,
      'title': title,
      'description': description,
      'status': status,
      'dueAt': dueAt,
    },
  );

  _i2.Future<_i22.ChallengeTeamMember> updateChallengeTeamMember(
    int membershipId,
    String role,
    String status,
  ) => caller.callServerEndpoint<_i22.ChallengeTeamMember>(
    'collaboration',
    'updateChallengeTeamMember',
    {
      'membershipId': membershipId,
      'role': role,
      'status': status,
    },
  );

  _i2.Future<List<_i24.ChallengeProgressUpdate>> getTeamUpdates(
    int teamId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i24.ChallengeProgressUpdate>>(
    'collaboration',
    'getTeamUpdates',
    {
      'teamId': teamId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i24.ChallengeProgressUpdate> postChallengeUpdate(
    int teamId,
    String body,
  ) => caller.callServerEndpoint<_i24.ChallengeProgressUpdate>(
    'collaboration',
    'postChallengeUpdate',
    {
      'teamId': teamId,
      'body': body,
    },
  );

  _i2.Future<List<_i25.Comment>> getPostComments(
    int postId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i25.Comment>>(
    'collaboration',
    'getPostComments',
    {
      'postId': postId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i25.Comment> createComment(
    int postId,
    String body,
    int? parentCommentId,
  ) => caller.callServerEndpoint<_i25.Comment>(
    'collaboration',
    'createComment',
    {
      'postId': postId,
      'body': body,
      'parentCommentId': parentCommentId,
    },
  );

  _i2.Future<_i16.DiscussionPost> acceptPostComment(
    int postId,
    int? commentId,
  ) => caller.callServerEndpoint<_i16.DiscussionPost>(
    'collaboration',
    'acceptPostComment',
    {
      'postId': postId,
      'commentId': commentId,
    },
  );

  _i2.Future<_i26.DiscussionReaction?> setPostReaction(
    int postId,
    String? reaction,
  ) => caller.callServerEndpoint<_i26.DiscussionReaction?>(
    'collaboration',
    'setPostReaction',
    {
      'postId': postId,
      'reaction': reaction,
    },
  );

  _i2.Stream<_i16.DiscussionPost> roomPostStream(int roomId) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i16.DiscussionPost>,
        _i16.DiscussionPost
      >(
        'collaboration',
        'roomPostStream',
        {'roomId': roomId},
        {},
      );

  _i2.Future<List<_i27.RoomChatMessage>> getRoomChatMessages(
    int roomId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i27.RoomChatMessage>>(
    'collaboration',
    'getRoomChatMessages',
    {
      'roomId': roomId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Stream<_i27.RoomChatMessage> roomChatStream(int roomId) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i27.RoomChatMessage>,
        _i27.RoomChatMessage
      >(
        'collaboration',
        'roomChatStream',
        {'roomId': roomId},
        {},
      );

  _i2.Future<_i27.RoomChatMessage> createRoomChatMessage(
    int roomId,
    String body,
  ) => caller.callServerEndpoint<_i27.RoomChatMessage>(
    'collaboration',
    'createRoomChatMessage',
    {
      'roomId': roomId,
      'body': body,
    },
  );

  _i2.Future<List<_i28.RoomAiAnswer>> getRoomAiAnswers(
    int roomId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i28.RoomAiAnswer>>(
    'collaboration',
    'getRoomAiAnswers',
    {
      'roomId': roomId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i28.RoomAiAnswer> askRoom(
    int roomId,
    String question,
  ) => caller.callServerEndpoint<_i28.RoomAiAnswer>(
    'collaboration',
    'askRoom',
    {
      'roomId': roomId,
      'question': question,
    },
  );

  _i2.Future<_i29.CollaborationPresence> updateRoomPresence(
    int roomId,
    String state,
  ) => caller.callServerEndpoint<_i29.CollaborationPresence>(
    'collaboration',
    'updateRoomPresence',
    {
      'roomId': roomId,
      'state': state,
    },
  );

  _i2.Future<List<_i29.CollaborationPresence>> getRoomPresence(int roomId) =>
      caller.callServerEndpoint<List<_i29.CollaborationPresence>>(
        'collaboration',
        'getRoomPresence',
        {'roomId': roomId},
      );

  _i2.Future<List<_i30.ScheduledStudySession>> getRoomStudySessions(
    int roomId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i30.ScheduledStudySession>>(
    'collaboration',
    'getRoomStudySessions',
    {
      'roomId': roomId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i30.ScheduledStudySession> createStudySession(
    int roomId,
    String title,
    String? description,
    DateTime startsAt,
    DateTime endsAt,
    String? meetingUrl,
  ) => caller.callServerEndpoint<_i30.ScheduledStudySession>(
    'collaboration',
    'createStudySession',
    {
      'roomId': roomId,
      'title': title,
      'description': description,
      'startsAt': startsAt,
      'endsAt': endsAt,
      'meetingUrl': meetingUrl,
    },
  );

  _i2.Future<_i31.StudySessionParticipant> joinStudySession(int sessionId) =>
      caller.callServerEndpoint<_i31.StudySessionParticipant>(
        'collaboration',
        'joinStudySession',
        {'sessionId': sessionId},
      );

  _i2.Future<_i32.ContentReport> reportContent(
    String contentType,
    int contentId,
    String reason,
    String? details,
  ) => caller.callServerEndpoint<_i32.ContentReport>(
    'collaboration',
    'reportContent',
    {
      'contentType': contentType,
      'contentId': contentId,
      'reason': reason,
      'details': details,
    },
  );

  _i2.Future<List<_i32.ContentReport>> getOpenReports({
    required int page,
    required int limit,
  }) => caller.callServerEndpoint<List<_i32.ContentReport>>(
    'collaboration',
    'getOpenReports',
    {
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<List<_i32.ContentReport>> getMyContentReports({
    required int page,
    required int limit,
  }) => caller.callServerEndpoint<List<_i32.ContentReport>>(
    'collaboration',
    'getMyContentReports',
    {
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<List<_i33.AuditEvent>> getAuditEvents({
    String? targetType,
    int? targetId,
    required int page,
    required int limit,
  }) => caller.callServerEndpoint<List<_i33.AuditEvent>>(
    'collaboration',
    'getAuditEvents',
    {
      'targetType': targetType,
      'targetId': targetId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<List<_i33.AuditEvent>> getInstitutionAuditEvents(
    int institutionId, {
    required int page,
    required int limit,
  }) => caller.callServerEndpoint<List<_i33.AuditEvent>>(
    'collaboration',
    'getInstitutionAuditEvents',
    {
      'institutionId': institutionId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i34.ModerationAppeal> submitModerationAppeal(
    int reportId,
    String reason,
  ) => caller.callServerEndpoint<_i34.ModerationAppeal>(
    'collaboration',
    'submitModerationAppeal',
    {
      'reportId': reportId,
      'reason': reason,
    },
  );

  _i2.Future<List<_i34.ModerationAppeal>> getMyModerationAppeals(
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i34.ModerationAppeal>>(
    'collaboration',
    'getMyModerationAppeals',
    {
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<List<_i34.ModerationAppeal>> getPendingModerationAppeals({
    required int page,
    required int limit,
  }) => caller.callServerEndpoint<List<_i34.ModerationAppeal>>(
    'collaboration',
    'getPendingModerationAppeals',
    {
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i34.ModerationAppeal> reviewModerationAppeal(
    int appealId,
    String decision,
    String? notes,
  ) => caller.callServerEndpoint<_i34.ModerationAppeal>(
    'collaboration',
    'reviewModerationAppeal',
    {
      'appealId': appealId,
      'decision': decision,
      'notes': notes,
    },
  );

  _i2.Future<_i32.ContentReport> resolveReport(
    int reportId,
    String action,
    String? notes,
  ) => caller.callServerEndpoint<_i32.ContentReport>(
    'collaboration',
    'resolveReport',
    {
      'reportId': reportId,
      'action': action,
      'notes': notes,
    },
  );

  _i2.Future<List<_i35.CollaborativeDocument>> getRoomDocuments(
    int roomId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i35.CollaborativeDocument>>(
    'collaboration',
    'getRoomDocuments',
    {
      'roomId': roomId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Stream<_i35.CollaborativeDocument> documentStream(int documentId) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i35.CollaborativeDocument>,
        _i35.CollaborativeDocument
      >(
        'collaboration',
        'documentStream',
        {'documentId': documentId},
        {},
      );

  _i2.Future<_i35.CollaborativeDocument> createDocument(
    int roomId,
    String title,
    String body,
  ) => caller.callServerEndpoint<_i35.CollaborativeDocument>(
    'collaboration',
    'createDocument',
    {
      'roomId': roomId,
      'title': title,
      'body': body,
    },
  );

  _i2.Future<_i35.CollaborativeDocument> updateDocument(
    int documentId,
    String title,
    String body,
    int expectedVersion,
  ) => caller.callServerEndpoint<_i35.CollaborativeDocument>(
    'collaboration',
    'updateDocument',
    {
      'documentId': documentId,
      'title': title,
      'body': body,
      'expectedVersion': expectedVersion,
    },
  );
}

/// {@category Endpoint}
class EndpointMessaging extends _i1.EndpointRef {
  EndpointMessaging(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'messaging';

  _i2.Future<_i36.UserPrivacySettings> getMyPrivacySettings() =>
      caller.callServerEndpoint<_i36.UserPrivacySettings>(
        'messaging',
        'getMyPrivacySettings',
        {},
      );

  _i2.Future<_i36.UserPrivacySettings> updateMyPrivacySettings({
    bool? isMinor,
    bool? allowUnknownDirectMessages,
  }) => caller.callServerEndpoint<_i36.UserPrivacySettings>(
    'messaging',
    'updateMyPrivacySettings',
    {
      'isMinor': isMinor,
      'allowUnknownDirectMessages': allowUnknownDirectMessages,
    },
  );

  _i2.Future<_i37.UserSafetyRelationship> setSafetyRelationship(
    int targetUserId,
    String relationshipType,
  ) => caller.callServerEndpoint<_i37.UserSafetyRelationship>(
    'messaging',
    'setSafetyRelationship',
    {
      'targetUserId': targetUserId,
      'relationshipType': relationshipType,
    },
  );

  _i2.Future<bool> removeSafetyRelationship(
    int targetUserId,
    String relationshipType,
  ) => caller.callServerEndpoint<bool>(
    'messaging',
    'removeSafetyRelationship',
    {
      'targetUserId': targetUserId,
      'relationshipType': relationshipType,
    },
  );

  _i2.Future<List<_i37.UserSafetyRelationship>> getMySafetyRelationships(
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i37.UserSafetyRelationship>>(
    'messaging',
    'getMySafetyRelationships',
    {
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i38.Conversation> createConversation(
    List<int> participantIds,
    String? title,
  ) => caller.callServerEndpoint<_i38.Conversation>(
    'messaging',
    'createConversation',
    {
      'participantIds': participantIds,
      'title': title,
    },
  );

  _i2.Future<List<_i38.Conversation>> getMyConversations() =>
      caller.callServerEndpoint<List<_i38.Conversation>>(
        'messaging',
        'getMyConversations',
        {},
      );

  _i2.Future<List<_i39.DirectMessage>> getConversationMessages(
    int conversationId,
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i39.DirectMessage>>(
    'messaging',
    'getConversationMessages',
    {
      'conversationId': conversationId,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i40.ConversationReadReceipt> markConversationRead(
    int conversationId,
    int messageId,
  ) => caller.callServerEndpoint<_i40.ConversationReadReceipt>(
    'messaging',
    'markConversationRead',
    {
      'conversationId': conversationId,
      'messageId': messageId,
    },
  );

  _i2.Future<List<_i40.ConversationReadReceipt>> getConversationReadReceipts(
    int conversationId,
  ) => caller.callServerEndpoint<List<_i40.ConversationReadReceipt>>(
    'messaging',
    'getConversationReadReceipts',
    {'conversationId': conversationId},
  );

  _i2.Stream<_i39.DirectMessage> conversationStream(int conversationId) =>
      caller.callStreamingServerEndpoint<
        _i2.Stream<_i39.DirectMessage>,
        _i39.DirectMessage
      >(
        'messaging',
        'conversationStream',
        {'conversationId': conversationId},
        {},
      );

  _i2.Future<_i39.DirectMessage> sendMessage(
    int conversationId,
    String body,
  ) => caller.callServerEndpoint<_i39.DirectMessage>(
    'messaging',
    'sendMessage',
    {
      'conversationId': conversationId,
      'body': body,
    },
  );
}

/// {@category Endpoint}
class EndpointNotification extends _i1.EndpointRef {
  EndpointNotification(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _i2.Future<List<_i41.Notification>> getNotifications({
    required bool isRead,
    required int page,
    required int limit,
  }) => caller.callServerEndpoint<List<_i41.Notification>>(
    'notification',
    'getNotifications',
    {
      'isRead': isRead,
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<bool> markNotificationRead(int notificationId) =>
      caller.callServerEndpoint<bool>(
        'notification',
        'markNotificationRead',
        {'notificationId': notificationId},
      );

  _i2.Future<int> markAllNotificationsRead() => caller.callServerEndpoint<int>(
    'notification',
    'markAllNotificationsRead',
    {},
  );

  _i2.Future<_i42.PushDevice> registerPushDevice(
    String token,
    String platform,
  ) => caller.callServerEndpoint<_i42.PushDevice>(
    'notification',
    'registerPushDevice',
    {
      'token': token,
      'platform': platform,
    },
  );

  _i2.Future<bool> unregisterPushDevice(String token) =>
      caller.callServerEndpoint<bool>(
        'notification',
        'unregisterPushDevice',
        {'token': token},
      );
}

/// {@category Endpoint}
class EndpointOperations extends _i1.EndpointRef {
  EndpointOperations(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'operations';

  _i2.Future<Map<String, int>> getQueueHealth() =>
      caller.callServerEndpoint<Map<String, int>>(
        'operations',
        'getQueueHealth',
        {},
      );

  _i2.Future<Map<String, int>> getSchedulerHealth() =>
      caller.callServerEndpoint<Map<String, int>>(
        'operations',
        'getSchedulerHealth',
        {},
      );
}

/// {@category Endpoint}
class EndpointOpportunity extends _i1.EndpointRef {
  EndpointOpportunity(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'opportunity';

  _i2.Future<_i43.OpportunitySource> registerOpportunitySource(
    String name,
    String provider,
    String feedUrl,
  ) => caller.callServerEndpoint<_i43.OpportunitySource>(
    'opportunity',
    'registerOpportunitySource',
    {
      'name': name,
      'provider': provider,
      'feedUrl': feedUrl,
    },
  );

  _i2.Future<_i44.Opportunity> ingestOpportunity(
    int sourceId,
    String externalId,
    String title,
    String opportunityType,
    String provider,
    String country,
    String? eligibilityRegion,
    String field,
    String educationLevel,
    DateTime deadline,
    String fundingDetails,
    String officialUrl,
  ) => caller.callServerEndpoint<_i44.Opportunity>(
    'opportunity',
    'ingestOpportunity',
    {
      'sourceId': sourceId,
      'externalId': externalId,
      'title': title,
      'opportunityType': opportunityType,
      'provider': provider,
      'country': country,
      'eligibilityRegion': eligibilityRegion,
      'field': field,
      'educationLevel': educationLevel,
      'deadline': deadline,
      'fundingDetails': fundingDetails,
      'officialUrl': officialUrl,
    },
  );

  _i2.Future<int> syncOpportunitySource(int sourceId) =>
      caller.callServerEndpoint<int>(
        'opportunity',
        'syncOpportunitySource',
        {'sourceId': sourceId},
      );

  _i2.Future<List<_i44.Opportunity>> getOpportunities(
    int page,
    int limit,
    String? country,
    String? field,
    String? educationLevel,
    String? opportunityType,
    DateTime? deadlineBefore,
  ) => caller.callServerEndpoint<List<_i44.Opportunity>>(
    'opportunity',
    'getOpportunities',
    {
      'page': page,
      'limit': limit,
      'country': country,
      'field': field,
      'educationLevel': educationLevel,
      'opportunityType': opportunityType,
      'deadlineBefore': deadlineBefore,
    },
  );

  _i2.Future<_i44.Opportunity> submitOpportunity(
    String title,
    String opportunityType,
    String provider,
    String country,
    String? eligibilityRegion,
    String field,
    String educationLevel,
    DateTime deadline,
    String fundingDetails,
    String officialUrl,
  ) => caller.callServerEndpoint<_i44.Opportunity>(
    'opportunity',
    'submitOpportunity',
    {
      'title': title,
      'opportunityType': opportunityType,
      'provider': provider,
      'country': country,
      'eligibilityRegion': eligibilityRegion,
      'field': field,
      'educationLevel': educationLevel,
      'deadline': deadline,
      'fundingDetails': fundingDetails,
      'officialUrl': officialUrl,
    },
  );

  _i2.Future<_i45.OpportunitySave> saveOpportunity(
    int opportunityId,
    bool alertEnabled,
  ) => caller.callServerEndpoint<_i45.OpportunitySave>(
    'opportunity',
    'saveOpportunity',
    {
      'opportunityId': opportunityId,
      'alertEnabled': alertEnabled,
    },
  );

  _i2.Future<List<_i45.OpportunitySave>> getSavedOpportunities(
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i45.OpportunitySave>>(
    'opportunity',
    'getSavedOpportunities',
    {
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i44.Opportunity> reviewOpportunity(
    int opportunityId,
    String verificationStatus,
  ) => caller.callServerEndpoint<_i44.Opportunity>(
    'opportunity',
    'reviewOpportunity',
    {
      'opportunityId': opportunityId,
      'verificationStatus': verificationStatus,
    },
  );

  _i2.Future<List<_i44.Opportunity>> getPendingOpportunityReviews({
    required int page,
    required int limit,
  }) => caller.callServerEndpoint<List<_i44.Opportunity>>(
    'opportunity',
    'getPendingOpportunityReviews',
    {
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i46.OpportunityAlert> createOpportunityAlert(
    String? country,
    String? field,
    String? educationLevel,
    List<String> opportunityTypes,
    int deadlineWithinDays,
  ) => caller.callServerEndpoint<_i46.OpportunityAlert>(
    'opportunity',
    'createOpportunityAlert',
    {
      'country': country,
      'field': field,
      'educationLevel': educationLevel,
      'opportunityTypes': opportunityTypes,
      'deadlineWithinDays': deadlineWithinDays,
    },
  );

  _i2.Future<List<_i46.OpportunityAlert>> getOpportunityAlerts() =>
      caller.callServerEndpoint<List<_i46.OpportunityAlert>>(
        'opportunity',
        'getOpportunityAlerts',
        {},
      );

  _i2.Future<void> deactivateOpportunityAlert(int alertId) =>
      caller.callServerEndpoint<void>(
        'opportunity',
        'deactivateOpportunityAlert',
        {'alertId': alertId},
      );

  _i2.Future<List<_i47.OpportunityApplicationTracker>> getApplicationTrackers(
    int page,
    int limit,
  ) => caller.callServerEndpoint<List<_i47.OpportunityApplicationTracker>>(
    'opportunity',
    'getApplicationTrackers',
    {
      'page': page,
      'limit': limit,
    },
  );

  _i2.Future<_i47.OpportunityApplicationTracker> upsertApplicationTracker(
    int opportunityId,
    String status,
    String? notes,
    String? applicationUrl,
  ) => caller.callServerEndpoint<_i47.OpportunityApplicationTracker>(
    'opportunity',
    'upsertApplicationTracker',
    {
      'opportunityId': opportunityId,
      'status': status,
      'notes': notes,
      'applicationUrl': applicationUrl,
    },
  );
}

/// {@category Endpoint}
class EndpointQuestion extends _i1.EndpointRef {
  EndpointQuestion(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'question';

  /// Generate sample questions for unauthorized/demo users
  _i2.Future<List<_i4.Question>> getSampleQuestions(int count) =>
      caller.callServerEndpoint<List<_i4.Question>>(
        'question',
        'getSampleQuestions',
        {'count': count},
      );
}

/// {@category Endpoint}
class EndpointStudyMaterial extends _i1.EndpointRef {
  EndpointStudyMaterial(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'studyMaterial';

  /// Upload study material
  _i2.Future<_i48.StudyMaterial> uploadMaterial(
    String title,
    String fileType,
    _i19.ByteData? fileData,
    String? fileUrl,
  ) => caller.callServerEndpoint<_i48.StudyMaterial>(
    'studyMaterial',
    'uploadMaterial',
    {
      'title': title,
      'fileType': fileType,
      'fileData': fileData,
      'fileUrl': fileUrl,
    },
  );

  /// Get all materials for authenticated user
  _i2.Future<List<_i48.StudyMaterial>> getMaterials() =>
      caller.callServerEndpoint<List<_i48.StudyMaterial>>(
        'studyMaterial',
        'getMaterials',
        {},
      );

  /// Get sample material for demo purposes
  _i2.Future<_i48.StudyMaterial> getSampleMaterial() =>
      caller.callServerEndpoint<_i48.StudyMaterial>(
        'studyMaterial',
        'getSampleMaterial',
        {},
      );

  /// Delete a study material
  _i2.Future<void> deleteMaterial(int materialId) =>
      caller.callServerEndpoint<void>(
        'studyMaterial',
        'deleteMaterial',
        {'materialId': materialId},
      );

  /// Update study material metadata
  _i2.Future<_i48.StudyMaterial> updateMaterial(
    int materialId,
    String? title,
    Map<String, dynamic>? metadata,
  ) => caller.callServerEndpoint<_i48.StudyMaterial>(
    'studyMaterial',
    'updateMaterial',
    {
      'materialId': materialId,
      'title': title,
      'metadata': metadata,
    },
  );

  /// Get processing status of a material
  _i2.Future<_i49.FileProcessing?> getProcessingStatus(int materialId) =>
      caller.callServerEndpoint<_i49.FileProcessing?>(
        'studyMaterial',
        'getProcessingStatus',
        {'materialId': materialId},
      );

  /// Get materials by file type (for authenticated user)
  _i2.Future<List<_i48.StudyMaterial>> getMaterialsByType(String fileType) =>
      caller.callServerEndpoint<List<_i48.StudyMaterial>>(
        'studyMaterial',
        'getMaterialsByType',
        {'fileType': fileType},
      );

  /// Search materials by title
  _i2.Future<List<_i48.StudyMaterial>> searchMaterials(String query) =>
      caller.callServerEndpoint<List<_i48.StudyMaterial>>(
        'studyMaterial',
        'searchMaterials',
        {'query': query},
      );

  /// Get material statistics for user
  _i2.Future<Map<String, dynamic>> getMaterialStats() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'studyMaterial',
        'getMaterialStats',
        {},
      );

  /// Requeues a failed or dead-lettered material for its owner.
  _i2.Future<_i49.FileProcessing> retryFileProcessing(int materialId) =>
      caller.callServerEndpoint<_i49.FileProcessing>(
        'studyMaterial',
        'retryFileProcessing',
        {'materialId': materialId},
      );
}

/// {@category Endpoint}
class EndpointSubscription extends _i1.EndpointRef {
  EndpointSubscription(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subscription';

  _i2.Future<_i50.Subscription> createSubscription(
    String gateway,
    String paymentToken, [
    String? idempotencyKey,
  ]) => caller.callServerEndpoint<_i50.Subscription>(
    'subscription',
    'createSubscription',
    {
      'gateway': gateway,
      'paymentToken': paymentToken,
      'idempotencyKey': idempotencyKey,
    },
  );

  /// Cancels the user's active subscription.
  _i2.Future<bool> cancelSubscription() => caller.callServerEndpoint<bool>(
    'subscription',
    'cancelSubscription',
    {},
  );

  _i2.Future<_i50.Subscription?> getSubscriptionStatus() =>
      caller.callServerEndpoint<_i50.Subscription?>(
        'subscription',
        'getSubscriptionStatus',
        {},
      );
}

/// {@category Endpoint}
class EndpointSummary extends _i1.EndpointRef {
  EndpointSummary(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'summary';

  _i2.Future<List<_i6.Summary>> getSummaries() =>
      caller.callServerEndpoint<List<_i6.Summary>>(
        'summary',
        'getSummaries',
        {},
      );

  _i2.Future<bool> deleteSummary(int summaryId) =>
      caller.callServerEndpoint<bool>(
        'summary',
        'deleteSummary',
        {'summaryId': summaryId},
      );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// Fetches the user's profile and their active subscription in one call.
  /// Creates a default profile if none exists (for new users).
  _i2.Future<_i51.UserProfileBundle> getProfileBundle() =>
      caller.callServerEndpoint<_i51.UserProfileBundle>(
        'user',
        'getProfileBundle',
        {},
      );

  /// Updates the user's profile information
  _i2.Future<_i52.UserProfile> updateProfile({String? name}) =>
      caller.callServerEndpoint<_i52.UserProfile>(
        'user',
        'updateProfile',
        {'name': name},
      );

  _i2.Future<_i53.DashboardBundle> getDashboardBundle() =>
      caller.callServerEndpoint<_i53.DashboardBundle>(
        'user',
        'getDashboardBundle',
        {},
      );

  /// Helper method to create initial study history for new users
  _i2.Future<_i54.StudyHistory> createStudyHistory() =>
      caller.callServerEndpoint<_i54.StudyHistory>(
        'user',
        'createStudyHistory',
        {},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i55.Caller(client);
  }

  late final _i55.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i56.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    academicWriting = EndpointAcademicWriting(this);
    ai = EndpointAi(this);
    analytics = EndpointAnalytics(this);
    billingWebhook = EndpointBillingWebhook(this);
    collaboration = EndpointCollaboration(this);
    messaging = EndpointMessaging(this);
    notification = EndpointNotification(this);
    operations = EndpointOperations(this);
    opportunity = EndpointOpportunity(this);
    question = EndpointQuestion(this);
    studyMaterial = EndpointStudyMaterial(this);
    subscription = EndpointSubscription(this);
    summary = EndpointSummary(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAcademicWriting academicWriting;

  late final EndpointAi ai;

  late final EndpointAnalytics analytics;

  late final EndpointBillingWebhook billingWebhook;

  late final EndpointCollaboration collaboration;

  late final EndpointMessaging messaging;

  late final EndpointNotification notification;

  late final EndpointOperations operations;

  late final EndpointOpportunity opportunity;

  late final EndpointQuestion question;

  late final EndpointStudyMaterial studyMaterial;

  late final EndpointSubscription subscription;

  late final EndpointSummary summary;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
    'academicWriting': academicWriting,
    'ai': ai,
    'analytics': analytics,
    'billingWebhook': billingWebhook,
    'collaboration': collaboration,
    'messaging': messaging,
    'notification': notification,
    'operations': operations,
    'opportunity': opportunity,
    'question': question,
    'studyMaterial': studyMaterial,
    'subscription': subscription,
    'summary': summary,
    'user': user,
  };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'auth': modules.auth,
  };
}
