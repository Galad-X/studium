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
import 'academic_profile.dart' as _i2;
import 'academic_writings.dart' as _i3;
import 'answers.dart' as _i4;
import 'api_rate_limit_bucket.dart' as _i5;
import 'audit_event.dart' as _i6;
import 'background_job.dart' as _i7;
import 'challenge.dart' as _i8;
import 'challenge_milestone.dart' as _i9;
import 'challenge_team.dart' as _i10;
import 'challenge_team_invite.dart' as _i11;
import 'challenge_team_member.dart' as _i12;
import 'challenge_update.dart' as _i13;
import 'collaboration_presence.dart' as _i14;
import 'collaborative_document.dart' as _i15;
import 'collaborative_document_revision.dart' as _i16;
import 'comment.dart' as _i17;
import 'content_report.dart' as _i18;
import 'conversation.dart' as _i19;
import 'conversation_member.dart' as _i20;
import 'conversation_read_receipt.dart' as _i21;
import 'dashboard_bundle.dart' as _i22;
import 'direct_message.dart' as _i23;
import 'discussion_post.dart' as _i24;
import 'discussion_reaction.dart' as _i25;
import 'email_delivery.dart' as _i26;
import 'file_processing.dart' as _i27;
import 'institution.dart' as _i28;
import 'institution_invite.dart' as _i29;
import 'institution_membership.dart' as _i30;
import 'moderation_appeal.dart' as _i31;
import 'moderation_log.dart' as _i32;
import 'notifications.dart' as _i33;
import 'opportunity.dart' as _i34;
import 'opportunity_alert.dart' as _i35;
import 'opportunity_application_tracker.dart' as _i36;
import 'opportunity_save.dart' as _i37;
import 'opportunity_source.dart' as _i38;
import 'payment_transactions.dart' as _i39;
import 'payment_webhook_event.dart' as _i40;
import 'push_delivery.dart' as _i41;
import 'push_device.dart' as _i42;
import 'questions.dart' as _i43;
import 'research_comparisons.dart' as _i44;
import 'room_ai_answer.dart' as _i45;
import 'room_chat_message.dart' as _i46;
import 'room_membership.dart' as _i47;
import 'room_resource.dart' as _i48;
import 'room_resource_chunk.dart' as _i49;
import 'scheduled_study_session.dart' as _i50;
import 'study_history.dart' as _i51;
import 'study_materials.dart' as _i52;
import 'study_room.dart' as _i53;
import 'study_session_participant.dart' as _i54;
import 'subscription_operation.dart' as _i55;
import 'subscriptions.dart' as _i56;
import 'summaries.dart' as _i57;
import 'tags.dart' as _i58;
import 'user_analytics.dart' as _i59;
import 'user_privacy_settings.dart' as _i60;
import 'user_profile.dart' as _i61;
import 'user_profile_bundle.dart' as _i62;
import 'user_reputation.dart' as _i63;
import 'user_restriction.dart' as _i64;
import 'user_safety_relationship.dart' as _i65;
import 'verification_request.dart' as _i66;
import 'package:studium_client/src/protocol/academic_writings.dart' as _i67;
import 'package:studium_client/src/protocol/questions.dart' as _i68;
import 'package:studium_client/src/protocol/user_analytics.dart' as _i69;
import 'package:studium_client/src/protocol/institution.dart' as _i70;
import 'package:studium_client/src/protocol/institution_membership.dart'
    as _i71;
import 'package:studium_client/src/protocol/verification_request.dart' as _i72;
import 'package:studium_client/src/protocol/study_room.dart' as _i73;
import 'package:studium_client/src/protocol/discussion_post.dart' as _i74;
import 'package:studium_client/src/protocol/challenge.dart' as _i75;
import 'package:studium_client/src/protocol/room_resource.dart' as _i76;
import 'package:studium_client/src/protocol/room_resource_chunk.dart' as _i77;
import 'package:studium_client/src/protocol/challenge_team.dart' as _i78;
import 'package:studium_client/src/protocol/challenge_team_member.dart' as _i79;
import 'package:studium_client/src/protocol/challenge_milestone.dart' as _i80;
import 'package:studium_client/src/protocol/challenge_update.dart' as _i81;
import 'package:studium_client/src/protocol/comment.dart' as _i82;
import 'package:studium_client/src/protocol/room_chat_message.dart' as _i83;
import 'package:studium_client/src/protocol/room_ai_answer.dart' as _i84;
import 'package:studium_client/src/protocol/collaboration_presence.dart'
    as _i85;
import 'package:studium_client/src/protocol/scheduled_study_session.dart'
    as _i86;
import 'package:studium_client/src/protocol/content_report.dart' as _i87;
import 'package:studium_client/src/protocol/audit_event.dart' as _i88;
import 'package:studium_client/src/protocol/moderation_appeal.dart' as _i89;
import 'package:studium_client/src/protocol/collaborative_document.dart'
    as _i90;
import 'package:studium_client/src/protocol/user_safety_relationship.dart'
    as _i91;
import 'package:studium_client/src/protocol/conversation.dart' as _i92;
import 'package:studium_client/src/protocol/direct_message.dart' as _i93;
import 'package:studium_client/src/protocol/conversation_read_receipt.dart'
    as _i94;
import 'package:studium_client/src/protocol/notifications.dart' as _i95;
import 'package:studium_client/src/protocol/opportunity.dart' as _i96;
import 'package:studium_client/src/protocol/opportunity_save.dart' as _i97;
import 'package:studium_client/src/protocol/opportunity_alert.dart' as _i98;
import 'package:studium_client/src/protocol/opportunity_application_tracker.dart'
    as _i99;
import 'package:studium_client/src/protocol/study_materials.dart' as _i100;
import 'package:studium_client/src/protocol/summaries.dart' as _i101;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i102;
export 'academic_profile.dart';
export 'academic_writings.dart';
export 'answers.dart';
export 'api_rate_limit_bucket.dart';
export 'audit_event.dart';
export 'background_job.dart';
export 'challenge.dart';
export 'challenge_milestone.dart';
export 'challenge_team.dart';
export 'challenge_team_invite.dart';
export 'challenge_team_member.dart';
export 'challenge_update.dart';
export 'collaboration_presence.dart';
export 'collaborative_document.dart';
export 'collaborative_document_revision.dart';
export 'comment.dart';
export 'content_report.dart';
export 'conversation.dart';
export 'conversation_member.dart';
export 'conversation_read_receipt.dart';
export 'dashboard_bundle.dart';
export 'direct_message.dart';
export 'discussion_post.dart';
export 'discussion_reaction.dart';
export 'email_delivery.dart';
export 'file_processing.dart';
export 'institution.dart';
export 'institution_invite.dart';
export 'institution_membership.dart';
export 'moderation_appeal.dart';
export 'moderation_log.dart';
export 'notifications.dart';
export 'opportunity.dart';
export 'opportunity_alert.dart';
export 'opportunity_application_tracker.dart';
export 'opportunity_save.dart';
export 'opportunity_source.dart';
export 'payment_transactions.dart';
export 'payment_webhook_event.dart';
export 'push_delivery.dart';
export 'push_device.dart';
export 'questions.dart';
export 'research_comparisons.dart';
export 'room_ai_answer.dart';
export 'room_chat_message.dart';
export 'room_membership.dart';
export 'room_resource.dart';
export 'room_resource_chunk.dart';
export 'scheduled_study_session.dart';
export 'study_history.dart';
export 'study_materials.dart';
export 'study_room.dart';
export 'study_session_participant.dart';
export 'subscription_operation.dart';
export 'subscriptions.dart';
export 'summaries.dart';
export 'tags.dart';
export 'user_analytics.dart';
export 'user_privacy_settings.dart';
export 'user_profile.dart';
export 'user_profile_bundle.dart';
export 'user_reputation.dart';
export 'user_restriction.dart';
export 'user_safety_relationship.dart';
export 'verification_request.dart';
export 'client.dart';

class Protocol extends _i1.SerializationManager {
  Protocol._();

  factory Protocol() => _instance;

  static final Protocol _instance = Protocol._();

  static String? getClassNameFromObjectJson(dynamic data) {
    if (data is! Map) return null;
    final className = data['__className__'] as String?;
    return className;
  }

  @override
  T deserialize<T>(
    dynamic data, [
    Type? t,
  ]) {
    t ??= T;

    final dataClassName = getClassNameFromObjectJson(data);
    if (dataClassName != null && dataClassName != getClassNameForType(t)) {
      try {
        return deserializeByClassName({
          'className': dataClassName,
          'data': data,
        });
      } on FormatException catch (_) {
        // If the className is not recognized (e.g., older client receiving
        // data with a new subtype), fall back to deserializing without the
        // className, using the expected type T.
      }
    }

    if (t == _i2.AcademicProfile) {
      return _i2.AcademicProfile.fromJson(data) as T;
    }
    if (t == _i3.AcademicWriting) {
      return _i3.AcademicWriting.fromJson(data) as T;
    }
    if (t == _i4.Answer) {
      return _i4.Answer.fromJson(data) as T;
    }
    if (t == _i5.ApiRateLimitBucket) {
      return _i5.ApiRateLimitBucket.fromJson(data) as T;
    }
    if (t == _i6.AuditEvent) {
      return _i6.AuditEvent.fromJson(data) as T;
    }
    if (t == _i7.BackgroundJob) {
      return _i7.BackgroundJob.fromJson(data) as T;
    }
    if (t == _i8.Challenge) {
      return _i8.Challenge.fromJson(data) as T;
    }
    if (t == _i9.ChallengeMilestone) {
      return _i9.ChallengeMilestone.fromJson(data) as T;
    }
    if (t == _i10.ChallengeTeam) {
      return _i10.ChallengeTeam.fromJson(data) as T;
    }
    if (t == _i11.ChallengeTeamInvite) {
      return _i11.ChallengeTeamInvite.fromJson(data) as T;
    }
    if (t == _i12.ChallengeTeamMember) {
      return _i12.ChallengeTeamMember.fromJson(data) as T;
    }
    if (t == _i13.ChallengeProgressUpdate) {
      return _i13.ChallengeProgressUpdate.fromJson(data) as T;
    }
    if (t == _i14.CollaborationPresence) {
      return _i14.CollaborationPresence.fromJson(data) as T;
    }
    if (t == _i15.CollaborativeDocument) {
      return _i15.CollaborativeDocument.fromJson(data) as T;
    }
    if (t == _i16.CollaborativeDocumentRevision) {
      return _i16.CollaborativeDocumentRevision.fromJson(data) as T;
    }
    if (t == _i17.Comment) {
      return _i17.Comment.fromJson(data) as T;
    }
    if (t == _i18.ContentReport) {
      return _i18.ContentReport.fromJson(data) as T;
    }
    if (t == _i19.Conversation) {
      return _i19.Conversation.fromJson(data) as T;
    }
    if (t == _i20.ConversationMember) {
      return _i20.ConversationMember.fromJson(data) as T;
    }
    if (t == _i21.ConversationReadReceipt) {
      return _i21.ConversationReadReceipt.fromJson(data) as T;
    }
    if (t == _i22.DashboardBundle) {
      return _i22.DashboardBundle.fromJson(data) as T;
    }
    if (t == _i23.DirectMessage) {
      return _i23.DirectMessage.fromJson(data) as T;
    }
    if (t == _i24.DiscussionPost) {
      return _i24.DiscussionPost.fromJson(data) as T;
    }
    if (t == _i25.DiscussionReaction) {
      return _i25.DiscussionReaction.fromJson(data) as T;
    }
    if (t == _i26.EmailDelivery) {
      return _i26.EmailDelivery.fromJson(data) as T;
    }
    if (t == _i27.FileProcessing) {
      return _i27.FileProcessing.fromJson(data) as T;
    }
    if (t == _i28.Institution) {
      return _i28.Institution.fromJson(data) as T;
    }
    if (t == _i29.InstitutionInvite) {
      return _i29.InstitutionInvite.fromJson(data) as T;
    }
    if (t == _i30.InstitutionMembership) {
      return _i30.InstitutionMembership.fromJson(data) as T;
    }
    if (t == _i31.ModerationAppeal) {
      return _i31.ModerationAppeal.fromJson(data) as T;
    }
    if (t == _i32.ModerationLog) {
      return _i32.ModerationLog.fromJson(data) as T;
    }
    if (t == _i33.Notification) {
      return _i33.Notification.fromJson(data) as T;
    }
    if (t == _i34.Opportunity) {
      return _i34.Opportunity.fromJson(data) as T;
    }
    if (t == _i35.OpportunityAlert) {
      return _i35.OpportunityAlert.fromJson(data) as T;
    }
    if (t == _i36.OpportunityApplicationTracker) {
      return _i36.OpportunityApplicationTracker.fromJson(data) as T;
    }
    if (t == _i37.OpportunitySave) {
      return _i37.OpportunitySave.fromJson(data) as T;
    }
    if (t == _i38.OpportunitySource) {
      return _i38.OpportunitySource.fromJson(data) as T;
    }
    if (t == _i39.PaymentTransaction) {
      return _i39.PaymentTransaction.fromJson(data) as T;
    }
    if (t == _i40.PaymentWebhookEvent) {
      return _i40.PaymentWebhookEvent.fromJson(data) as T;
    }
    if (t == _i41.PushDelivery) {
      return _i41.PushDelivery.fromJson(data) as T;
    }
    if (t == _i42.PushDevice) {
      return _i42.PushDevice.fromJson(data) as T;
    }
    if (t == _i43.Question) {
      return _i43.Question.fromJson(data) as T;
    }
    if (t == _i44.ResearchComparison) {
      return _i44.ResearchComparison.fromJson(data) as T;
    }
    if (t == _i45.RoomAiAnswer) {
      return _i45.RoomAiAnswer.fromJson(data) as T;
    }
    if (t == _i46.RoomChatMessage) {
      return _i46.RoomChatMessage.fromJson(data) as T;
    }
    if (t == _i47.RoomMembership) {
      return _i47.RoomMembership.fromJson(data) as T;
    }
    if (t == _i48.RoomResource) {
      return _i48.RoomResource.fromJson(data) as T;
    }
    if (t == _i49.RoomResourceChunk) {
      return _i49.RoomResourceChunk.fromJson(data) as T;
    }
    if (t == _i50.ScheduledStudySession) {
      return _i50.ScheduledStudySession.fromJson(data) as T;
    }
    if (t == _i51.StudyHistory) {
      return _i51.StudyHistory.fromJson(data) as T;
    }
    if (t == _i52.StudyMaterial) {
      return _i52.StudyMaterial.fromJson(data) as T;
    }
    if (t == _i53.StudyRoom) {
      return _i53.StudyRoom.fromJson(data) as T;
    }
    if (t == _i54.StudySessionParticipant) {
      return _i54.StudySessionParticipant.fromJson(data) as T;
    }
    if (t == _i55.SubscriptionOperation) {
      return _i55.SubscriptionOperation.fromJson(data) as T;
    }
    if (t == _i56.Subscription) {
      return _i56.Subscription.fromJson(data) as T;
    }
    if (t == _i57.Summary) {
      return _i57.Summary.fromJson(data) as T;
    }
    if (t == _i58.Tag) {
      return _i58.Tag.fromJson(data) as T;
    }
    if (t == _i59.UserAnalytics) {
      return _i59.UserAnalytics.fromJson(data) as T;
    }
    if (t == _i60.UserPrivacySettings) {
      return _i60.UserPrivacySettings.fromJson(data) as T;
    }
    if (t == _i61.UserProfile) {
      return _i61.UserProfile.fromJson(data) as T;
    }
    if (t == _i62.UserProfileBundle) {
      return _i62.UserProfileBundle.fromJson(data) as T;
    }
    if (t == _i63.UserReputation) {
      return _i63.UserReputation.fromJson(data) as T;
    }
    if (t == _i64.UserRestriction) {
      return _i64.UserRestriction.fromJson(data) as T;
    }
    if (t == _i65.UserSafetyRelationship) {
      return _i65.UserSafetyRelationship.fromJson(data) as T;
    }
    if (t == _i66.VerificationRequest) {
      return _i66.VerificationRequest.fromJson(data) as T;
    }
    if (t == _i1.getType<_i2.AcademicProfile?>()) {
      return (data != null ? _i2.AcademicProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i3.AcademicWriting?>()) {
      return (data != null ? _i3.AcademicWriting.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i4.Answer?>()) {
      return (data != null ? _i4.Answer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i5.ApiRateLimitBucket?>()) {
      return (data != null ? _i5.ApiRateLimitBucket.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i6.AuditEvent?>()) {
      return (data != null ? _i6.AuditEvent.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i7.BackgroundJob?>()) {
      return (data != null ? _i7.BackgroundJob.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i8.Challenge?>()) {
      return (data != null ? _i8.Challenge.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i9.ChallengeMilestone?>()) {
      return (data != null ? _i9.ChallengeMilestone.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i10.ChallengeTeam?>()) {
      return (data != null ? _i10.ChallengeTeam.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i11.ChallengeTeamInvite?>()) {
      return (data != null ? _i11.ChallengeTeamInvite.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i12.ChallengeTeamMember?>()) {
      return (data != null ? _i12.ChallengeTeamMember.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i13.ChallengeProgressUpdate?>()) {
      return (data != null ? _i13.ChallengeProgressUpdate.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i14.CollaborationPresence?>()) {
      return (data != null ? _i14.CollaborationPresence.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i15.CollaborativeDocument?>()) {
      return (data != null ? _i15.CollaborativeDocument.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i16.CollaborativeDocumentRevision?>()) {
      return (data != null
          ? _i16.CollaborativeDocumentRevision.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i17.Comment?>()) {
      return (data != null ? _i17.Comment.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i18.ContentReport?>()) {
      return (data != null ? _i18.ContentReport.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i19.Conversation?>()) {
      return (data != null ? _i19.Conversation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i20.ConversationMember?>()) {
      return (data != null ? _i20.ConversationMember.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i21.ConversationReadReceipt?>()) {
      return (data != null ? _i21.ConversationReadReceipt.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i22.DashboardBundle?>()) {
      return (data != null ? _i22.DashboardBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i23.DirectMessage?>()) {
      return (data != null ? _i23.DirectMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i24.DiscussionPost?>()) {
      return (data != null ? _i24.DiscussionPost.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i25.DiscussionReaction?>()) {
      return (data != null ? _i25.DiscussionReaction.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i26.EmailDelivery?>()) {
      return (data != null ? _i26.EmailDelivery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i27.FileProcessing?>()) {
      return (data != null ? _i27.FileProcessing.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i28.Institution?>()) {
      return (data != null ? _i28.Institution.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i29.InstitutionInvite?>()) {
      return (data != null ? _i29.InstitutionInvite.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i30.InstitutionMembership?>()) {
      return (data != null ? _i30.InstitutionMembership.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i31.ModerationAppeal?>()) {
      return (data != null ? _i31.ModerationAppeal.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i32.ModerationLog?>()) {
      return (data != null ? _i32.ModerationLog.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i33.Notification?>()) {
      return (data != null ? _i33.Notification.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i34.Opportunity?>()) {
      return (data != null ? _i34.Opportunity.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i35.OpportunityAlert?>()) {
      return (data != null ? _i35.OpportunityAlert.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i36.OpportunityApplicationTracker?>()) {
      return (data != null
          ? _i36.OpportunityApplicationTracker.fromJson(data)
          : null) as T;
    }
    if (t == _i1.getType<_i37.OpportunitySave?>()) {
      return (data != null ? _i37.OpportunitySave.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i38.OpportunitySource?>()) {
      return (data != null ? _i38.OpportunitySource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i39.PaymentTransaction?>()) {
      return (data != null ? _i39.PaymentTransaction.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i40.PaymentWebhookEvent?>()) {
      return (data != null ? _i40.PaymentWebhookEvent.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i41.PushDelivery?>()) {
      return (data != null ? _i41.PushDelivery.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i42.PushDevice?>()) {
      return (data != null ? _i42.PushDevice.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i43.Question?>()) {
      return (data != null ? _i43.Question.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i44.ResearchComparison?>()) {
      return (data != null ? _i44.ResearchComparison.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i45.RoomAiAnswer?>()) {
      return (data != null ? _i45.RoomAiAnswer.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i46.RoomChatMessage?>()) {
      return (data != null ? _i46.RoomChatMessage.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i47.RoomMembership?>()) {
      return (data != null ? _i47.RoomMembership.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i48.RoomResource?>()) {
      return (data != null ? _i48.RoomResource.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i49.RoomResourceChunk?>()) {
      return (data != null ? _i49.RoomResourceChunk.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i50.ScheduledStudySession?>()) {
      return (data != null ? _i50.ScheduledStudySession.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i51.StudyHistory?>()) {
      return (data != null ? _i51.StudyHistory.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i52.StudyMaterial?>()) {
      return (data != null ? _i52.StudyMaterial.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i53.StudyRoom?>()) {
      return (data != null ? _i53.StudyRoom.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i54.StudySessionParticipant?>()) {
      return (data != null ? _i54.StudySessionParticipant.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i55.SubscriptionOperation?>()) {
      return (data != null ? _i55.SubscriptionOperation.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i56.Subscription?>()) {
      return (data != null ? _i56.Subscription.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i57.Summary?>()) {
      return (data != null ? _i57.Summary.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i58.Tag?>()) {
      return (data != null ? _i58.Tag.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i59.UserAnalytics?>()) {
      return (data != null ? _i59.UserAnalytics.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i60.UserPrivacySettings?>()) {
      return (data != null ? _i60.UserPrivacySettings.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i61.UserProfile?>()) {
      return (data != null ? _i61.UserProfile.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i62.UserProfileBundle?>()) {
      return (data != null ? _i62.UserProfileBundle.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i63.UserReputation?>()) {
      return (data != null ? _i63.UserReputation.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i64.UserRestriction?>()) {
      return (data != null ? _i64.UserRestriction.fromJson(data) : null) as T;
    }
    if (t == _i1.getType<_i65.UserSafetyRelationship?>()) {
      return (data != null ? _i65.UserSafetyRelationship.fromJson(data) : null)
          as T;
    }
    if (t == _i1.getType<_i66.VerificationRequest?>()) {
      return (data != null ? _i66.VerificationRequest.fromJson(data) : null)
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == List<_i52.StudyMaterial>) {
      return (data as List)
          .map((e) => deserialize<_i52.StudyMaterial>(e))
          .toList() as T;
    }
    if (t == List<_i57.Summary>) {
      return (data as List).map((e) => deserialize<_i57.Summary>(e)).toList()
          as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i67.AcademicWriting>) {
      return (data as List)
          .map((e) => deserialize<_i67.AcademicWriting>(e))
          .toList() as T;
    }
    if (t == List<_i68.Question>) {
      return (data as List).map((e) => deserialize<_i68.Question>(e)).toList()
          as T;
    }
    if (t == List<String>) {
      return (data as List).map((e) => deserialize<String>(e)).toList() as T;
    }
    if (t == _i1.getType<List<String>?>()) {
      return (data != null
          ? (data as List).map((e) => deserialize<String>(e)).toList()
          : null) as T;
    }
    if (t == List<_i69.UserAnalytics>) {
      return (data as List)
          .map((e) => deserialize<_i69.UserAnalytics>(e))
          .toList() as T;
    }
    if (t == List<_i70.Institution>) {
      return (data as List)
          .map((e) => deserialize<_i70.Institution>(e))
          .toList() as T;
    }
    if (t == List<_i71.InstitutionMembership>) {
      return (data as List)
          .map((e) => deserialize<_i71.InstitutionMembership>(e))
          .toList() as T;
    }
    if (t == List<_i72.VerificationRequest>) {
      return (data as List)
          .map((e) => deserialize<_i72.VerificationRequest>(e))
          .toList() as T;
    }
    if (t == List<_i73.StudyRoom>) {
      return (data as List).map((e) => deserialize<_i73.StudyRoom>(e)).toList()
          as T;
    }
    if (t == List<_i74.DiscussionPost>) {
      return (data as List)
          .map((e) => deserialize<_i74.DiscussionPost>(e))
          .toList() as T;
    }
    if (t == List<_i75.Challenge>) {
      return (data as List).map((e) => deserialize<_i75.Challenge>(e)).toList()
          as T;
    }
    if (t == List<_i76.RoomResource>) {
      return (data as List)
          .map((e) => deserialize<_i76.RoomResource>(e))
          .toList() as T;
    }
    if (t == List<_i77.RoomResourceChunk>) {
      return (data as List)
          .map((e) => deserialize<_i77.RoomResourceChunk>(e))
          .toList() as T;
    }
    if (t == List<_i78.ChallengeTeam>) {
      return (data as List)
          .map((e) => deserialize<_i78.ChallengeTeam>(e))
          .toList() as T;
    }
    if (t == List<_i79.ChallengeTeamMember>) {
      return (data as List)
          .map((e) => deserialize<_i79.ChallengeTeamMember>(e))
          .toList() as T;
    }
    if (t == List<_i80.ChallengeMilestone>) {
      return (data as List)
          .map((e) => deserialize<_i80.ChallengeMilestone>(e))
          .toList() as T;
    }
    if (t == List<_i81.ChallengeProgressUpdate>) {
      return (data as List)
          .map((e) => deserialize<_i81.ChallengeProgressUpdate>(e))
          .toList() as T;
    }
    if (t == List<_i82.Comment>) {
      return (data as List).map((e) => deserialize<_i82.Comment>(e)).toList()
          as T;
    }
    if (t == List<_i83.RoomChatMessage>) {
      return (data as List)
          .map((e) => deserialize<_i83.RoomChatMessage>(e))
          .toList() as T;
    }
    if (t == List<_i84.RoomAiAnswer>) {
      return (data as List)
          .map((e) => deserialize<_i84.RoomAiAnswer>(e))
          .toList() as T;
    }
    if (t == List<_i85.CollaborationPresence>) {
      return (data as List)
          .map((e) => deserialize<_i85.CollaborationPresence>(e))
          .toList() as T;
    }
    if (t == List<_i86.ScheduledStudySession>) {
      return (data as List)
          .map((e) => deserialize<_i86.ScheduledStudySession>(e))
          .toList() as T;
    }
    if (t == List<_i87.ContentReport>) {
      return (data as List)
          .map((e) => deserialize<_i87.ContentReport>(e))
          .toList() as T;
    }
    if (t == List<_i88.AuditEvent>) {
      return (data as List).map((e) => deserialize<_i88.AuditEvent>(e)).toList()
          as T;
    }
    if (t == List<_i89.ModerationAppeal>) {
      return (data as List)
          .map((e) => deserialize<_i89.ModerationAppeal>(e))
          .toList() as T;
    }
    if (t == List<_i90.CollaborativeDocument>) {
      return (data as List)
          .map((e) => deserialize<_i90.CollaborativeDocument>(e))
          .toList() as T;
    }
    if (t == List<_i91.UserSafetyRelationship>) {
      return (data as List)
          .map((e) => deserialize<_i91.UserSafetyRelationship>(e))
          .toList() as T;
    }
    if (t == List<int>) {
      return (data as List).map((e) => deserialize<int>(e)).toList() as T;
    }
    if (t == List<_i92.Conversation>) {
      return (data as List)
          .map((e) => deserialize<_i92.Conversation>(e))
          .toList() as T;
    }
    if (t == List<_i93.DirectMessage>) {
      return (data as List)
          .map((e) => deserialize<_i93.DirectMessage>(e))
          .toList() as T;
    }
    if (t == List<_i94.ConversationReadReceipt>) {
      return (data as List)
          .map((e) => deserialize<_i94.ConversationReadReceipt>(e))
          .toList() as T;
    }
    if (t == List<_i95.Notification>) {
      return (data as List)
          .map((e) => deserialize<_i95.Notification>(e))
          .toList() as T;
    }
    if (t == Map<String, int>) {
      return (data as Map).map(
        (k, v) => MapEntry(deserialize<String>(k), deserialize<int>(v)),
      ) as T;
    }
    if (t == List<_i96.Opportunity>) {
      return (data as List)
          .map((e) => deserialize<_i96.Opportunity>(e))
          .toList() as T;
    }
    if (t == List<_i97.OpportunitySave>) {
      return (data as List)
          .map((e) => deserialize<_i97.OpportunitySave>(e))
          .toList() as T;
    }
    if (t == List<_i98.OpportunityAlert>) {
      return (data as List)
          .map((e) => deserialize<_i98.OpportunityAlert>(e))
          .toList() as T;
    }
    if (t == List<_i99.OpportunityApplicationTracker>) {
      return (data as List)
          .map((e) => deserialize<_i99.OpportunityApplicationTracker>(e))
          .toList() as T;
    }
    if (t == List<_i100.StudyMaterial>) {
      return (data as List)
          .map((e) => deserialize<_i100.StudyMaterial>(e))
          .toList() as T;
    }
    if (t == Map<String, dynamic>) {
      return (data as Map).map(
        (k, v) => MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
      ) as T;
    }
    if (t == _i1.getType<Map<String, dynamic>?>()) {
      return (data != null
          ? (data as Map).map(
              (k, v) =>
                  MapEntry(deserialize<String>(k), deserialize<dynamic>(v)),
            )
          : null) as T;
    }
    if (t == List<_i101.Summary>) {
      return (data as List).map((e) => deserialize<_i101.Summary>(e)).toList()
          as T;
    }
    try {
      return _i102.Protocol().deserialize<T>(data, t);
    } on _i1.DeserializationTypeNotFoundException catch (_) {}
    return super.deserialize<T>(data, t);
  }

  static String? getClassNameForType(Type type) {
    return switch (type) {
      _i2.AcademicProfile => 'AcademicProfile',
      _i3.AcademicWriting => 'AcademicWriting',
      _i4.Answer => 'Answer',
      _i5.ApiRateLimitBucket => 'ApiRateLimitBucket',
      _i6.AuditEvent => 'AuditEvent',
      _i7.BackgroundJob => 'BackgroundJob',
      _i8.Challenge => 'Challenge',
      _i9.ChallengeMilestone => 'ChallengeMilestone',
      _i10.ChallengeTeam => 'ChallengeTeam',
      _i11.ChallengeTeamInvite => 'ChallengeTeamInvite',
      _i12.ChallengeTeamMember => 'ChallengeTeamMember',
      _i13.ChallengeProgressUpdate => 'ChallengeProgressUpdate',
      _i14.CollaborationPresence => 'CollaborationPresence',
      _i15.CollaborativeDocument => 'CollaborativeDocument',
      _i16.CollaborativeDocumentRevision => 'CollaborativeDocumentRevision',
      _i17.Comment => 'Comment',
      _i18.ContentReport => 'ContentReport',
      _i19.Conversation => 'Conversation',
      _i20.ConversationMember => 'ConversationMember',
      _i21.ConversationReadReceipt => 'ConversationReadReceipt',
      _i22.DashboardBundle => 'DashboardBundle',
      _i23.DirectMessage => 'DirectMessage',
      _i24.DiscussionPost => 'DiscussionPost',
      _i25.DiscussionReaction => 'DiscussionReaction',
      _i26.EmailDelivery => 'EmailDelivery',
      _i27.FileProcessing => 'FileProcessing',
      _i28.Institution => 'Institution',
      _i29.InstitutionInvite => 'InstitutionInvite',
      _i30.InstitutionMembership => 'InstitutionMembership',
      _i31.ModerationAppeal => 'ModerationAppeal',
      _i32.ModerationLog => 'ModerationLog',
      _i33.Notification => 'Notification',
      _i34.Opportunity => 'Opportunity',
      _i35.OpportunityAlert => 'OpportunityAlert',
      _i36.OpportunityApplicationTracker => 'OpportunityApplicationTracker',
      _i37.OpportunitySave => 'OpportunitySave',
      _i38.OpportunitySource => 'OpportunitySource',
      _i39.PaymentTransaction => 'PaymentTransaction',
      _i40.PaymentWebhookEvent => 'PaymentWebhookEvent',
      _i41.PushDelivery => 'PushDelivery',
      _i42.PushDevice => 'PushDevice',
      _i43.Question => 'Question',
      _i44.ResearchComparison => 'ResearchComparison',
      _i45.RoomAiAnswer => 'RoomAiAnswer',
      _i46.RoomChatMessage => 'RoomChatMessage',
      _i47.RoomMembership => 'RoomMembership',
      _i48.RoomResource => 'RoomResource',
      _i49.RoomResourceChunk => 'RoomResourceChunk',
      _i50.ScheduledStudySession => 'ScheduledStudySession',
      _i51.StudyHistory => 'StudyHistory',
      _i52.StudyMaterial => 'StudyMaterial',
      _i53.StudyRoom => 'StudyRoom',
      _i54.StudySessionParticipant => 'StudySessionParticipant',
      _i55.SubscriptionOperation => 'SubscriptionOperation',
      _i56.Subscription => 'Subscription',
      _i57.Summary => 'Summary',
      _i58.Tag => 'Tag',
      _i59.UserAnalytics => 'UserAnalytics',
      _i60.UserPrivacySettings => 'UserPrivacySettings',
      _i61.UserProfile => 'UserProfile',
      _i62.UserProfileBundle => 'UserProfileBundle',
      _i63.UserReputation => 'UserReputation',
      _i64.UserRestriction => 'UserRestriction',
      _i65.UserSafetyRelationship => 'UserSafetyRelationship',
      _i66.VerificationRequest => 'VerificationRequest',
      _ => null,
    };
  }

  @override
  String? getClassNameForObject(Object? data) {
    String? className = super.getClassNameForObject(data);
    if (className != null) return className;

    if (data is Map<String, dynamic> && data['__className__'] is String) {
      return (data['__className__'] as String).replaceFirst('studium.', '');
    }

    switch (data) {
      case _i2.AcademicProfile():
        return 'AcademicProfile';
      case _i3.AcademicWriting():
        return 'AcademicWriting';
      case _i4.Answer():
        return 'Answer';
      case _i5.ApiRateLimitBucket():
        return 'ApiRateLimitBucket';
      case _i6.AuditEvent():
        return 'AuditEvent';
      case _i7.BackgroundJob():
        return 'BackgroundJob';
      case _i8.Challenge():
        return 'Challenge';
      case _i9.ChallengeMilestone():
        return 'ChallengeMilestone';
      case _i10.ChallengeTeam():
        return 'ChallengeTeam';
      case _i11.ChallengeTeamInvite():
        return 'ChallengeTeamInvite';
      case _i12.ChallengeTeamMember():
        return 'ChallengeTeamMember';
      case _i13.ChallengeProgressUpdate():
        return 'ChallengeProgressUpdate';
      case _i14.CollaborationPresence():
        return 'CollaborationPresence';
      case _i15.CollaborativeDocument():
        return 'CollaborativeDocument';
      case _i16.CollaborativeDocumentRevision():
        return 'CollaborativeDocumentRevision';
      case _i17.Comment():
        return 'Comment';
      case _i18.ContentReport():
        return 'ContentReport';
      case _i19.Conversation():
        return 'Conversation';
      case _i20.ConversationMember():
        return 'ConversationMember';
      case _i21.ConversationReadReceipt():
        return 'ConversationReadReceipt';
      case _i22.DashboardBundle():
        return 'DashboardBundle';
      case _i23.DirectMessage():
        return 'DirectMessage';
      case _i24.DiscussionPost():
        return 'DiscussionPost';
      case _i25.DiscussionReaction():
        return 'DiscussionReaction';
      case _i26.EmailDelivery():
        return 'EmailDelivery';
      case _i27.FileProcessing():
        return 'FileProcessing';
      case _i28.Institution():
        return 'Institution';
      case _i29.InstitutionInvite():
        return 'InstitutionInvite';
      case _i30.InstitutionMembership():
        return 'InstitutionMembership';
      case _i31.ModerationAppeal():
        return 'ModerationAppeal';
      case _i32.ModerationLog():
        return 'ModerationLog';
      case _i33.Notification():
        return 'Notification';
      case _i34.Opportunity():
        return 'Opportunity';
      case _i35.OpportunityAlert():
        return 'OpportunityAlert';
      case _i36.OpportunityApplicationTracker():
        return 'OpportunityApplicationTracker';
      case _i37.OpportunitySave():
        return 'OpportunitySave';
      case _i38.OpportunitySource():
        return 'OpportunitySource';
      case _i39.PaymentTransaction():
        return 'PaymentTransaction';
      case _i40.PaymentWebhookEvent():
        return 'PaymentWebhookEvent';
      case _i41.PushDelivery():
        return 'PushDelivery';
      case _i42.PushDevice():
        return 'PushDevice';
      case _i43.Question():
        return 'Question';
      case _i44.ResearchComparison():
        return 'ResearchComparison';
      case _i45.RoomAiAnswer():
        return 'RoomAiAnswer';
      case _i46.RoomChatMessage():
        return 'RoomChatMessage';
      case _i47.RoomMembership():
        return 'RoomMembership';
      case _i48.RoomResource():
        return 'RoomResource';
      case _i49.RoomResourceChunk():
        return 'RoomResourceChunk';
      case _i50.ScheduledStudySession():
        return 'ScheduledStudySession';
      case _i51.StudyHistory():
        return 'StudyHistory';
      case _i52.StudyMaterial():
        return 'StudyMaterial';
      case _i53.StudyRoom():
        return 'StudyRoom';
      case _i54.StudySessionParticipant():
        return 'StudySessionParticipant';
      case _i55.SubscriptionOperation():
        return 'SubscriptionOperation';
      case _i56.Subscription():
        return 'Subscription';
      case _i57.Summary():
        return 'Summary';
      case _i58.Tag():
        return 'Tag';
      case _i59.UserAnalytics():
        return 'UserAnalytics';
      case _i60.UserPrivacySettings():
        return 'UserPrivacySettings';
      case _i61.UserProfile():
        return 'UserProfile';
      case _i62.UserProfileBundle():
        return 'UserProfileBundle';
      case _i63.UserReputation():
        return 'UserReputation';
      case _i64.UserRestriction():
        return 'UserRestriction';
      case _i65.UserSafetyRelationship():
        return 'UserSafetyRelationship';
      case _i66.VerificationRequest():
        return 'VerificationRequest';
    }
    className = _i102.Protocol().getClassNameForObject(data);
    if (className != null) {
      return 'serverpod_auth.$className';
    }
    return null;
  }

  @override
  dynamic deserializeByClassName(Map<String, dynamic> data) {
    var dataClassName = data['className'];
    if (dataClassName is! String) {
      return super.deserializeByClassName(data);
    }
    if (dataClassName == 'AcademicProfile') {
      return deserialize<_i2.AcademicProfile>(data['data']);
    }
    if (dataClassName == 'AcademicWriting') {
      return deserialize<_i3.AcademicWriting>(data['data']);
    }
    if (dataClassName == 'Answer') {
      return deserialize<_i4.Answer>(data['data']);
    }
    if (dataClassName == 'ApiRateLimitBucket') {
      return deserialize<_i5.ApiRateLimitBucket>(data['data']);
    }
    if (dataClassName == 'AuditEvent') {
      return deserialize<_i6.AuditEvent>(data['data']);
    }
    if (dataClassName == 'BackgroundJob') {
      return deserialize<_i7.BackgroundJob>(data['data']);
    }
    if (dataClassName == 'Challenge') {
      return deserialize<_i8.Challenge>(data['data']);
    }
    if (dataClassName == 'ChallengeMilestone') {
      return deserialize<_i9.ChallengeMilestone>(data['data']);
    }
    if (dataClassName == 'ChallengeTeam') {
      return deserialize<_i10.ChallengeTeam>(data['data']);
    }
    if (dataClassName == 'ChallengeTeamInvite') {
      return deserialize<_i11.ChallengeTeamInvite>(data['data']);
    }
    if (dataClassName == 'ChallengeTeamMember') {
      return deserialize<_i12.ChallengeTeamMember>(data['data']);
    }
    if (dataClassName == 'ChallengeProgressUpdate') {
      return deserialize<_i13.ChallengeProgressUpdate>(data['data']);
    }
    if (dataClassName == 'CollaborationPresence') {
      return deserialize<_i14.CollaborationPresence>(data['data']);
    }
    if (dataClassName == 'CollaborativeDocument') {
      return deserialize<_i15.CollaborativeDocument>(data['data']);
    }
    if (dataClassName == 'CollaborativeDocumentRevision') {
      return deserialize<_i16.CollaborativeDocumentRevision>(data['data']);
    }
    if (dataClassName == 'Comment') {
      return deserialize<_i17.Comment>(data['data']);
    }
    if (dataClassName == 'ContentReport') {
      return deserialize<_i18.ContentReport>(data['data']);
    }
    if (dataClassName == 'Conversation') {
      return deserialize<_i19.Conversation>(data['data']);
    }
    if (dataClassName == 'ConversationMember') {
      return deserialize<_i20.ConversationMember>(data['data']);
    }
    if (dataClassName == 'ConversationReadReceipt') {
      return deserialize<_i21.ConversationReadReceipt>(data['data']);
    }
    if (dataClassName == 'DashboardBundle') {
      return deserialize<_i22.DashboardBundle>(data['data']);
    }
    if (dataClassName == 'DirectMessage') {
      return deserialize<_i23.DirectMessage>(data['data']);
    }
    if (dataClassName == 'DiscussionPost') {
      return deserialize<_i24.DiscussionPost>(data['data']);
    }
    if (dataClassName == 'DiscussionReaction') {
      return deserialize<_i25.DiscussionReaction>(data['data']);
    }
    if (dataClassName == 'EmailDelivery') {
      return deserialize<_i26.EmailDelivery>(data['data']);
    }
    if (dataClassName == 'FileProcessing') {
      return deserialize<_i27.FileProcessing>(data['data']);
    }
    if (dataClassName == 'Institution') {
      return deserialize<_i28.Institution>(data['data']);
    }
    if (dataClassName == 'InstitutionInvite') {
      return deserialize<_i29.InstitutionInvite>(data['data']);
    }
    if (dataClassName == 'InstitutionMembership') {
      return deserialize<_i30.InstitutionMembership>(data['data']);
    }
    if (dataClassName == 'ModerationAppeal') {
      return deserialize<_i31.ModerationAppeal>(data['data']);
    }
    if (dataClassName == 'ModerationLog') {
      return deserialize<_i32.ModerationLog>(data['data']);
    }
    if (dataClassName == 'Notification') {
      return deserialize<_i33.Notification>(data['data']);
    }
    if (dataClassName == 'Opportunity') {
      return deserialize<_i34.Opportunity>(data['data']);
    }
    if (dataClassName == 'OpportunityAlert') {
      return deserialize<_i35.OpportunityAlert>(data['data']);
    }
    if (dataClassName == 'OpportunityApplicationTracker') {
      return deserialize<_i36.OpportunityApplicationTracker>(data['data']);
    }
    if (dataClassName == 'OpportunitySave') {
      return deserialize<_i37.OpportunitySave>(data['data']);
    }
    if (dataClassName == 'OpportunitySource') {
      return deserialize<_i38.OpportunitySource>(data['data']);
    }
    if (dataClassName == 'PaymentTransaction') {
      return deserialize<_i39.PaymentTransaction>(data['data']);
    }
    if (dataClassName == 'PaymentWebhookEvent') {
      return deserialize<_i40.PaymentWebhookEvent>(data['data']);
    }
    if (dataClassName == 'PushDelivery') {
      return deserialize<_i41.PushDelivery>(data['data']);
    }
    if (dataClassName == 'PushDevice') {
      return deserialize<_i42.PushDevice>(data['data']);
    }
    if (dataClassName == 'Question') {
      return deserialize<_i43.Question>(data['data']);
    }
    if (dataClassName == 'ResearchComparison') {
      return deserialize<_i44.ResearchComparison>(data['data']);
    }
    if (dataClassName == 'RoomAiAnswer') {
      return deserialize<_i45.RoomAiAnswer>(data['data']);
    }
    if (dataClassName == 'RoomChatMessage') {
      return deserialize<_i46.RoomChatMessage>(data['data']);
    }
    if (dataClassName == 'RoomMembership') {
      return deserialize<_i47.RoomMembership>(data['data']);
    }
    if (dataClassName == 'RoomResource') {
      return deserialize<_i48.RoomResource>(data['data']);
    }
    if (dataClassName == 'RoomResourceChunk') {
      return deserialize<_i49.RoomResourceChunk>(data['data']);
    }
    if (dataClassName == 'ScheduledStudySession') {
      return deserialize<_i50.ScheduledStudySession>(data['data']);
    }
    if (dataClassName == 'StudyHistory') {
      return deserialize<_i51.StudyHistory>(data['data']);
    }
    if (dataClassName == 'StudyMaterial') {
      return deserialize<_i52.StudyMaterial>(data['data']);
    }
    if (dataClassName == 'StudyRoom') {
      return deserialize<_i53.StudyRoom>(data['data']);
    }
    if (dataClassName == 'StudySessionParticipant') {
      return deserialize<_i54.StudySessionParticipant>(data['data']);
    }
    if (dataClassName == 'SubscriptionOperation') {
      return deserialize<_i55.SubscriptionOperation>(data['data']);
    }
    if (dataClassName == 'Subscription') {
      return deserialize<_i56.Subscription>(data['data']);
    }
    if (dataClassName == 'Summary') {
      return deserialize<_i57.Summary>(data['data']);
    }
    if (dataClassName == 'Tag') {
      return deserialize<_i58.Tag>(data['data']);
    }
    if (dataClassName == 'UserAnalytics') {
      return deserialize<_i59.UserAnalytics>(data['data']);
    }
    if (dataClassName == 'UserPrivacySettings') {
      return deserialize<_i60.UserPrivacySettings>(data['data']);
    }
    if (dataClassName == 'UserProfile') {
      return deserialize<_i61.UserProfile>(data['data']);
    }
    if (dataClassName == 'UserProfileBundle') {
      return deserialize<_i62.UserProfileBundle>(data['data']);
    }
    if (dataClassName == 'UserReputation') {
      return deserialize<_i63.UserReputation>(data['data']);
    }
    if (dataClassName == 'UserRestriction') {
      return deserialize<_i64.UserRestriction>(data['data']);
    }
    if (dataClassName == 'UserSafetyRelationship') {
      return deserialize<_i65.UserSafetyRelationship>(data['data']);
    }
    if (dataClassName == 'VerificationRequest') {
      return deserialize<_i66.VerificationRequest>(data['data']);
    }
    if (dataClassName.startsWith('serverpod_auth.')) {
      data['className'] = dataClassName.substring(15);
      return _i102.Protocol().deserializeByClassName(data);
    }
    return super.deserializeByClassName(data);
  }

  /// Maps any `Record`s known to this [Protocol] to their JSON representation
  ///
  /// Throws in case the record type is not known.
  ///
  /// This method will return `null` (only) for `null` inputs.
  Map<String, dynamic>? mapRecordToJson(Record? record) {
    if (record == null) {
      return null;
    }
    try {
      return _i102.Protocol().mapRecordToJson(record);
    } catch (_) {}
    throw Exception('Unsupported record type ${record.runtimeType}');
  }
}
