BEGIN;

--
-- Class AcademicProfile as table academic_profiles
--
CREATE TABLE "academic_profiles" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "institutionId" bigint NOT NULL,
    "department" text,
    "programme" text,
    "level" text,
    "subjects" json NOT NULL,
    "interests" json NOT NULL,
    "languages" json NOT NULL,
    "availability" text,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "academic_profile_user_institution_idx" ON "academic_profiles" USING btree ("userId", "institutionId");

--
-- Class AcademicWriting as table academic_writings
--
CREATE TABLE "academic_writings" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "studyMaterialId" bigint,
    "type" text NOT NULL,
    "title" text NOT NULL,
    "wordCount" bigint,
    "content" text NOT NULL,
    "format" text NOT NULL,
    "fileUrl" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class Answer as table answers
--
CREATE TABLE "answers" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "questionId" bigint NOT NULL,
    "answerText" text NOT NULL,
    "score" double precision,
    "feedback" text,
    "submittedAt" timestamp without time zone NOT NULL
);

--
-- Class ChallengeMilestone as table challenge_milestones
--
CREATE TABLE "challenge_milestones" (
    "id" bigserial PRIMARY KEY,
    "teamId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "status" text NOT NULL,
    "dueAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "challenge_milestone_team_idx" ON "challenge_milestones" USING btree ("teamId", "status");

--
-- Class ChallengeTeamMember as table challenge_team_members
--
CREATE TABLE "challenge_team_members" (
    "id" bigserial PRIMARY KEY,
    "teamId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "status" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "challenge_team_member_unique_idx" ON "challenge_team_members" USING btree ("teamId", "userId");

--
-- Class ChallengeTeam as table challenge_teams
--
CREATE TABLE "challenge_teams" (
    "id" bigserial PRIMARY KEY,
    "challengeId" bigint NOT NULL,
    "ownerId" bigint NOT NULL,
    "name" text NOT NULL,
    "description" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "challenge_team_challenge_idx" ON "challenge_teams" USING btree ("challengeId", "status");

--
-- Class ChallengeProgressUpdate as table challenge_updates
--
CREATE TABLE "challenge_updates" (
    "id" bigserial PRIMARY KEY,
    "teamId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "body" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "challenge_update_team_created_idx" ON "challenge_updates" USING btree ("teamId", "createdAt");

--
-- Class Challenge as table challenges
--
CREATE TABLE "challenges" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint,
    "ownerId" bigint NOT NULL,
    "title" text NOT NULL,
    "problemStatement" text NOT NULL,
    "field" text NOT NULL,
    "tags" json NOT NULL,
    "difficulty" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "challenge_room_status_idx" ON "challenges" USING btree ("roomId", "status");

--
-- Class CollaborationPresence as table collaboration_presence
--
CREATE TABLE "collaboration_presence" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "scopeType" text NOT NULL,
    "scopeId" bigint NOT NULL,
    "state" text NOT NULL,
    "lastSeenAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "collaboration_presence_unique_idx" ON "collaboration_presence" USING btree ("userId", "scopeType", "scopeId");
CREATE INDEX "collaboration_presence_scope_seen_idx" ON "collaboration_presence" USING btree ("scopeType", "scopeId", "lastSeenAt");

--
-- Class CollaborativeDocumentRevision as table collaborative_document_revisions
--
CREATE TABLE "collaborative_document_revisions" (
    "id" bigserial PRIMARY KEY,
    "documentId" bigint NOT NULL,
    "editorId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "body" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "collaborative_revision_document_version_idx" ON "collaborative_document_revisions" USING btree ("documentId", "version");

--
-- Class CollaborativeDocument as table collaborative_documents
--
CREATE TABLE "collaborative_documents" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "ownerId" bigint NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "version" bigint NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "collaborative_document_room_updated_idx" ON "collaborative_documents" USING btree ("roomId", "updatedAt");

--
-- Class Comment as table comments
--
CREATE TABLE "comments" (
    "id" bigserial PRIMARY KEY,
    "postId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "parentCommentId" bigint,
    "body" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "comment_post_created_idx" ON "comments" USING btree ("postId", "createdAt");
CREATE INDEX "comment_parent_idx" ON "comments" USING btree ("parentCommentId");

--
-- Class ContentReport as table content_reports
--
CREATE TABLE "content_reports" (
    "id" bigserial PRIMARY KEY,
    "reporterId" bigint NOT NULL,
    "contentType" text NOT NULL,
    "contentId" bigint NOT NULL,
    "reason" text NOT NULL,
    "details" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "resolvedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "content_report_status_created_idx" ON "content_reports" USING btree ("status", "createdAt");
CREATE INDEX "content_report_reporter_idx" ON "content_reports" USING btree ("reporterId", "createdAt");

--
-- Class ConversationMember as table conversation_members
--
CREATE TABLE "conversation_members" (
    "id" bigserial PRIMARY KEY,
    "conversationId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "status" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "conversation_member_unique_idx" ON "conversation_members" USING btree ("conversationId", "userId");
CREATE INDEX "conversation_member_user_idx" ON "conversation_members" USING btree ("userId", "status");

--
-- Class Conversation as table conversations
--
CREATE TABLE "conversations" (
    "id" bigserial PRIMARY KEY,
    "conversationType" text NOT NULL,
    "title" text,
    "createdById" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "conversation_updated_idx" ON "conversations" USING btree ("updatedAt");

--
-- Class DirectMessage as table direct_messages
--
CREATE TABLE "direct_messages" (
    "id" bigserial PRIMARY KEY,
    "conversationId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "body" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "direct_message_conversation_created_idx" ON "direct_messages" USING btree ("conversationId", "createdAt");

--
-- Class DiscussionPost as table discussion_posts
--
CREATE TABLE "discussion_posts" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "body" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "discussion_post_room_created_idx" ON "discussion_posts" USING btree ("roomId", "createdAt");

--
-- Class FileProcessing as table file_processing
--
CREATE TABLE "file_processing" (
    "id" bigserial PRIMARY KEY,
    "studyMaterialId" bigint NOT NULL,
    "status" text NOT NULL,
    "processedText" text,
    "errorMessage" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- Class InstitutionMembership as table institution_memberships
--
CREATE TABLE "institution_memberships" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "institutionId" bigint NOT NULL,
    "role" text NOT NULL,
    "verificationMethod" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "verifiedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "institution_membership_user_institution_idx" ON "institution_memberships" USING btree ("userId", "institutionId");

--
-- Class Institution as table institutions
--
CREATE TABLE "institutions" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "country" text NOT NULL,
    "region" text,
    "domains" json NOT NULL,
    "logoUrl" text,
    "verificationStatus" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "institution_name_idx" ON "institutions" USING btree ("name");

--
-- Class ModerationLog as table moderation_logs
--
CREATE TABLE "moderation_logs" (
    "id" bigserial PRIMARY KEY,
    "reportId" bigint NOT NULL,
    "moderatorId" bigint NOT NULL,
    "action" text NOT NULL,
    "targetType" text NOT NULL,
    "targetId" bigint NOT NULL,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "moderation_log_report_idx" ON "moderation_logs" USING btree ("reportId", "createdAt");

--
-- Class Notification as table notifications
--
CREATE TABLE "notifications" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "message" text NOT NULL,
    "relatedId" bigint,
    "type" text NOT NULL,
    "isRead" boolean NOT NULL DEFAULT false,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class Opportunity as table opportunities
--
CREATE TABLE "opportunities" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "opportunityType" text NOT NULL,
    "provider" text NOT NULL,
    "country" text NOT NULL,
    "eligibilityRegion" text,
    "field" text NOT NULL,
    "educationLevel" text NOT NULL,
    "deadline" timestamp without time zone NOT NULL,
    "fundingDetails" text NOT NULL,
    "officialUrl" text NOT NULL,
    "verificationStatus" text NOT NULL,
    "submittedById" bigint,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "opportunity_status_deadline_idx" ON "opportunities" USING btree ("verificationStatus", "deadline");
CREATE INDEX "opportunity_filter_idx" ON "opportunities" USING btree ("country", "field", "educationLevel");

--
-- Class OpportunityAlert as table opportunity_alerts
--
CREATE TABLE "opportunity_alerts" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "country" text,
    "field" text,
    "educationLevel" text,
    "opportunityTypes" json NOT NULL,
    "deadlineWithinDays" bigint NOT NULL,
    "active" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "opportunity_alert_user_active_idx" ON "opportunity_alerts" USING btree ("userId", "active");
CREATE INDEX "opportunity_alert_user_updated_idx" ON "opportunity_alerts" USING btree ("userId", "updatedAt");

--
-- Class OpportunitySave as table opportunity_saves
--
CREATE TABLE "opportunity_saves" (
    "id" bigserial PRIMARY KEY,
    "opportunityId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "alertEnabled" boolean NOT NULL,
    "savedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "opportunity_save_user_opportunity_idx" ON "opportunity_saves" USING btree ("userId", "opportunityId");
CREATE INDEX "opportunity_save_user_saved_idx" ON "opportunity_saves" USING btree ("userId", "savedAt");

--
-- Class PaymentTransaction as table payment_transactions
--
CREATE TABLE "payment_transactions" (
    "id" bigserial PRIMARY KEY,
    "subscriptionId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "amount" double precision NOT NULL,
    "status" text NOT NULL,
    "gateway" text NOT NULL,
    "transactionId" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class PaymentWebhookEvent as table payment_webhook_events
--
CREATE TABLE "payment_webhook_events" (
    "id" bigserial PRIMARY KEY,
    "gateway" text NOT NULL,
    "eventId" text NOT NULL,
    "eventType" text NOT NULL,
    "payload" text NOT NULL,
    "status" text NOT NULL,
    "receivedAt" timestamp without time zone NOT NULL,
    "processedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "payment_webhook_gateway_event_idx" ON "payment_webhook_events" USING btree ("gateway", "eventId");
CREATE INDEX "payment_webhook_received_idx" ON "payment_webhook_events" USING btree ("receivedAt");

--
-- Class Question as table questions
--
CREATE TABLE "questions" (
    "id" bigserial PRIMARY KEY,
    "studyMaterialId" bigint NOT NULL,
    "type" text NOT NULL,
    "questionText" text NOT NULL,
    "correctAnswer" text,
    "options" json,
    "explanation" text,
    "difficulty" text NOT NULL,
    "bloomsLevel" text NOT NULL,
    "estimatedTime" bigint NOT NULL,
    "tags" json,
    "diagramImageUrl" text,
    "labelingPoints" json,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class ResearchComparison as table research_comparisons
--
CREATE TABLE "research_comparisons" (
    "id" bigserial PRIMARY KEY,
    "summaryId" bigint,
    "studyMaterialId" bigint NOT NULL,
    "newerFindings" text NOT NULL,
    "unsolvedProblems" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class RoomAiAnswer as table room_ai_answers
--
CREATE TABLE "room_ai_answers" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "askerId" bigint NOT NULL,
    "question" text NOT NULL,
    "answer" text NOT NULL,
    "sourceResourceIds" json NOT NULL,
    "citations" json NOT NULL,
    "confidence" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "room_ai_answer_room_created_idx" ON "room_ai_answers" USING btree ("roomId", "createdAt");
CREATE INDEX "room_ai_answer_asker_created_idx" ON "room_ai_answers" USING btree ("askerId", "createdAt");

--
-- Class RoomChatMessage as table room_chat_messages
--
CREATE TABLE "room_chat_messages" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "body" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "room_chat_room_created_idx" ON "room_chat_messages" USING btree ("roomId", "createdAt");

--
-- Class RoomMembership as table room_memberships
--
CREATE TABLE "room_memberships" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "status" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "room_membership_room_user_idx" ON "room_memberships" USING btree ("roomId", "userId");

--
-- Class RoomResource as table room_resources
--
CREATE TABLE "room_resources" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "ownerId" bigint NOT NULL,
    "resourceType" text NOT NULL,
    "title" text NOT NULL,
    "uri" text,
    "content" text,
    "citation" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "room_resource_room_status_created_idx" ON "room_resources" USING btree ("roomId", "status", "createdAt");

--
-- Class ScheduledStudySession as table scheduled_study_sessions
--
CREATE TABLE "scheduled_study_sessions" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "organizerId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text,
    "startsAt" timestamp without time zone NOT NULL,
    "endsAt" timestamp without time zone NOT NULL,
    "meetingUrl" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "scheduled_session_room_start_idx" ON "scheduled_study_sessions" USING btree ("roomId", "startsAt");
CREATE INDEX "scheduled_session_organizer_idx" ON "scheduled_study_sessions" USING btree ("organizerId", "startsAt");

--
-- Class StudyHistory as table study_history
--
CREATE TABLE "study_history" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "materialIds" json NOT NULL,
    "questionIds" json NOT NULL,
    "summaryIds" json NOT NULL,
    "writingIds" json NOT NULL,
    "progress" double precision,
    "lastUpdated" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "unique_user" ON "study_history" USING btree ("userId");

--
-- Class StudyMaterial as table study_materials
--
CREATE TABLE "study_materials" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "fileType" text NOT NULL,
    "fileUrl" text NOT NULL,
    "uploadDate" timestamp without time zone NOT NULL,
    "size" bigint,
    "contentText" text
);

--
-- Class StudyRoom as table study_rooms
--
CREATE TABLE "study_rooms" (
    "id" bigserial PRIMARY KEY,
    "institutionId" bigint,
    "ownerId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "subject" text,
    "visibility" text NOT NULL,
    "membershipPolicy" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "study_room_institution_status_idx" ON "study_rooms" USING btree ("institutionId", "status");

--
-- Class StudySessionParticipant as table study_session_participants
--
CREATE TABLE "study_session_participants" (
    "id" bigserial PRIMARY KEY,
    "sessionId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "status" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "study_session_participant_unique_idx" ON "study_session_participants" USING btree ("sessionId", "userId");
CREATE INDEX "study_session_participant_user_idx" ON "study_session_participants" USING btree ("userId", "status");

--
-- Class Subscription as table subscriptions
--
CREATE TABLE "subscriptions" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "gateway" text NOT NULL,
    "subscriptionId" text NOT NULL,
    "gatewayToken" text,
    "status" text NOT NULL,
    "startDate" timestamp without time zone NOT NULL,
    "endDate" timestamp without time zone
);

--
-- Class Summary as table summaries
--
CREATE TABLE "summaries" (
    "id" bigserial PRIMARY KEY,
    "studyMaterialId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "isPremium" boolean NOT NULL,
    "subject" text NOT NULL,
    "topic" text NOT NULL,
    "wordCount" bigint,
    "introduction" text,
    "subtopics" json NOT NULL,
    "nuggets" json NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class Tag as table tags
--
CREATE TABLE "tags" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "studyMaterialId" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- Class UserAnalytics as table user_analytics
--
CREATE TABLE "user_analytics" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "action" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "metadata" text
);

--
-- Class UserProfile as table user_profile
--
CREATE TABLE "user_profile" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "name" text,
    "role" text NOT NULL DEFAULT 'free'::text,
    "subscriptionId" text,
    "studyHistoryId" bigint,
    "stripeCustomerId" text,
    "paystackCustomerCode" text
);

-- Indexes
CREATE UNIQUE INDEX "user_profile_user_id_idx" ON "user_profile" USING btree ("userId");
CREATE UNIQUE INDEX "user_profile_stripe_customer_id_idx" ON "user_profile" USING btree ("stripeCustomerId");
CREATE UNIQUE INDEX "user_profile_paystack_customer_code_idx" ON "user_profile" USING btree ("paystackCustomerCode");

--
-- Class UserRestriction as table user_restrictions
--
CREATE TABLE "user_restrictions" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "restrictionType" text NOT NULL,
    "reason" text NOT NULL,
    "expiresAt" timestamp without time zone,
    "active" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "user_restriction_user_active_idx" ON "user_restrictions" USING btree ("userId", "active");

--
-- Class VerificationRequest as table verification_requests
--
CREATE TABLE "verification_requests" (
    "id" bigserial PRIMARY KEY,
    "membershipId" bigint NOT NULL,
    "method" text NOT NULL,
    "evidenceUrl" text,
    "status" text NOT NULL,
    "reviewerId" bigint,
    "createdAt" timestamp without time zone NOT NULL,
    "reviewedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "verification_request_membership_idx" ON "verification_requests" USING btree ("membershipId");

--
-- Class CloudStorageEntry as table serverpod_cloud_storage
--
CREATE TABLE "serverpod_cloud_storage" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "addedTime" timestamp without time zone NOT NULL,
    "expiration" timestamp without time zone,
    "byteData" bytea NOT NULL,
    "verified" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_path_idx" ON "serverpod_cloud_storage" USING btree ("storageId", "path");
CREATE INDEX "serverpod_cloud_storage_expiration" ON "serverpod_cloud_storage" USING btree ("expiration");

--
-- Class CloudStorageDirectUploadEntry as table serverpod_cloud_storage_direct_upload
--
CREATE TABLE "serverpod_cloud_storage_direct_upload" (
    "id" bigserial PRIMARY KEY,
    "storageId" text NOT NULL,
    "path" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL,
    "authKey" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_cloud_storage_direct_upload_storage_path" ON "serverpod_cloud_storage_direct_upload" USING btree ("storageId", "path");

--
-- Class FutureCallEntry as table serverpod_future_call
--
CREATE TABLE "serverpod_future_call" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "serializedObject" text,
    "serverId" text NOT NULL,
    "identifier" text
);

-- Indexes
CREATE INDEX "serverpod_future_call_time_idx" ON "serverpod_future_call" USING btree ("time");
CREATE INDEX "serverpod_future_call_serverId_idx" ON "serverpod_future_call" USING btree ("serverId");
CREATE INDEX "serverpod_future_call_identifier_idx" ON "serverpod_future_call" USING btree ("identifier");

--
-- Class ServerHealthConnectionInfo as table serverpod_health_connection_info
--
CREATE TABLE "serverpod_health_connection_info" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "active" bigint NOT NULL,
    "closing" bigint NOT NULL,
    "idle" bigint NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_connection_info_timestamp_idx" ON "serverpod_health_connection_info" USING btree ("timestamp", "serverId", "granularity");

--
-- Class ServerHealthMetric as table serverpod_health_metric
--
CREATE TABLE "serverpod_health_metric" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "serverId" text NOT NULL,
    "timestamp" timestamp without time zone NOT NULL,
    "isHealthy" boolean NOT NULL,
    "value" double precision NOT NULL,
    "granularity" bigint NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_health_metric_timestamp_idx" ON "serverpod_health_metric" USING btree ("timestamp", "serverId", "name", "granularity");

--
-- Class LogEntry as table serverpod_log
--
CREATE TABLE "serverpod_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "reference" text,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "logLevel" bigint NOT NULL,
    "message" text NOT NULL,
    "error" text,
    "stackTrace" text,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_log_sessionLogId_idx" ON "serverpod_log" USING btree ("sessionLogId");

--
-- Class MessageLogEntry as table serverpod_message_log
--
CREATE TABLE "serverpod_message_log" (
    "id" bigserial PRIMARY KEY,
    "sessionLogId" bigint NOT NULL,
    "serverId" text NOT NULL,
    "messageId" bigint NOT NULL,
    "endpoint" text NOT NULL,
    "messageName" text NOT NULL,
    "duration" double precision NOT NULL,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

--
-- Class MethodInfo as table serverpod_method
--
CREATE TABLE "serverpod_method" (
    "id" bigserial PRIMARY KEY,
    "endpoint" text NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_method_endpoint_method_idx" ON "serverpod_method" USING btree ("endpoint", "method");

--
-- Class DatabaseMigrationVersion as table serverpod_migrations
--
CREATE TABLE "serverpod_migrations" (
    "id" bigserial PRIMARY KEY,
    "module" text NOT NULL,
    "version" text NOT NULL,
    "timestamp" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_migrations_ids" ON "serverpod_migrations" USING btree ("module");

--
-- Class QueryLogEntry as table serverpod_query_log
--
CREATE TABLE "serverpod_query_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "sessionLogId" bigint NOT NULL,
    "messageId" bigint,
    "query" text NOT NULL,
    "duration" double precision NOT NULL,
    "numRows" bigint,
    "error" text,
    "stackTrace" text,
    "slow" boolean NOT NULL,
    "order" bigint NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_query_log_sessionLogId_idx" ON "serverpod_query_log" USING btree ("sessionLogId");

--
-- Class ReadWriteTestEntry as table serverpod_readwrite_test
--
CREATE TABLE "serverpod_readwrite_test" (
    "id" bigserial PRIMARY KEY,
    "number" bigint NOT NULL
);

--
-- Class RuntimeSettings as table serverpod_runtime_settings
--
CREATE TABLE "serverpod_runtime_settings" (
    "id" bigserial PRIMARY KEY,
    "logSettings" json NOT NULL,
    "logSettingsOverrides" json NOT NULL,
    "logServiceCalls" boolean NOT NULL,
    "logMalformedCalls" boolean NOT NULL
);

--
-- Class SessionLogEntry as table serverpod_session_log
--
CREATE TABLE "serverpod_session_log" (
    "id" bigserial PRIMARY KEY,
    "serverId" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "module" text,
    "endpoint" text,
    "method" text,
    "duration" double precision,
    "numQueries" bigint,
    "slow" boolean,
    "error" text,
    "stackTrace" text,
    "authenticatedUserId" bigint,
    "userId" text,
    "isOpen" boolean,
    "touched" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_session_log_serverid_idx" ON "serverpod_session_log" USING btree ("serverId");
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
CREATE INDEX "serverpod_session_log_touched_idx" ON "serverpod_session_log" USING btree ("touched");
CREATE INDEX "serverpod_session_log_isopen_idx" ON "serverpod_session_log" USING btree ("isOpen");

--
-- Class AuthKey as table serverpod_auth_key
--
CREATE TABLE "serverpod_auth_key" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "hash" text NOT NULL,
    "scopeNames" json NOT NULL,
    "method" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_auth_key_userId_idx" ON "serverpod_auth_key" USING btree ("userId");

--
-- Class EmailAuth as table serverpod_email_auth
--
CREATE TABLE "serverpod_email_auth" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_email" ON "serverpod_email_auth" USING btree ("email");

--
-- Class EmailCreateAccountRequest as table serverpod_email_create_request
--
CREATE TABLE "serverpod_email_create_request" (
    "id" bigserial PRIMARY KEY,
    "userName" text NOT NULL,
    "email" text NOT NULL,
    "hash" text NOT NULL,
    "verificationCode" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_auth_create_account_request_idx" ON "serverpod_email_create_request" USING btree ("email");

--
-- Class EmailFailedSignIn as table serverpod_email_failed_sign_in
--
CREATE TABLE "serverpod_email_failed_sign_in" (
    "id" bigserial PRIMARY KEY,
    "email" text NOT NULL,
    "time" timestamp without time zone NOT NULL,
    "ipAddress" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_email_failed_sign_in_email_idx" ON "serverpod_email_failed_sign_in" USING btree ("email");
CREATE INDEX "serverpod_email_failed_sign_in_time_idx" ON "serverpod_email_failed_sign_in" USING btree ("time");

--
-- Class EmailReset as table serverpod_email_reset
--
CREATE TABLE "serverpod_email_reset" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "verificationCode" text NOT NULL,
    "expiration" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_email_reset_verification_idx" ON "serverpod_email_reset" USING btree ("verificationCode");

--
-- Class GoogleRefreshToken as table serverpod_google_refresh_token
--
CREATE TABLE "serverpod_google_refresh_token" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "refreshToken" text NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_google_refresh_token_userId_idx" ON "serverpod_google_refresh_token" USING btree ("userId");

--
-- Class UserImage as table serverpod_user_image
--
CREATE TABLE "serverpod_user_image" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "url" text NOT NULL
);

-- Indexes
CREATE INDEX "serverpod_user_image_user_id" ON "serverpod_user_image" USING btree ("userId", "version");

--
-- Class UserInfo as table serverpod_user_info
--
CREATE TABLE "serverpod_user_info" (
    "id" bigserial PRIMARY KEY,
    "userIdentifier" text NOT NULL,
    "userName" text,
    "fullName" text,
    "email" text,
    "created" timestamp without time zone NOT NULL,
    "imageUrl" text,
    "scopeNames" json NOT NULL,
    "blocked" boolean NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "serverpod_user_info_user_identifier" ON "serverpod_user_info" USING btree ("userIdentifier");
CREATE INDEX "serverpod_user_info_email" ON "serverpod_user_info" USING btree ("email");

--
-- Foreign relations for "academic_profiles" table
--
ALTER TABLE ONLY "academic_profiles"
    ADD CONSTRAINT "academic_profiles_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "academic_profiles"
    ADD CONSTRAINT "academic_profiles_fk_1"
    FOREIGN KEY("institutionId")
    REFERENCES "institutions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "academic_writings" table
--
ALTER TABLE ONLY "academic_writings"
    ADD CONSTRAINT "academic_writings_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "academic_writings"
    ADD CONSTRAINT "academic_writings_fk_1"
    FOREIGN KEY("studyMaterialId")
    REFERENCES "study_materials"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "answers" table
--
ALTER TABLE ONLY "answers"
    ADD CONSTRAINT "answers_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "answers"
    ADD CONSTRAINT "answers_fk_1"
    FOREIGN KEY("questionId")
    REFERENCES "questions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "challenge_milestones" table
--
ALTER TABLE ONLY "challenge_milestones"
    ADD CONSTRAINT "challenge_milestones_fk_0"
    FOREIGN KEY("teamId")
    REFERENCES "challenge_teams"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "challenge_team_members" table
--
ALTER TABLE ONLY "challenge_team_members"
    ADD CONSTRAINT "challenge_team_members_fk_0"
    FOREIGN KEY("teamId")
    REFERENCES "challenge_teams"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "challenge_team_members"
    ADD CONSTRAINT "challenge_team_members_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "challenge_teams" table
--
ALTER TABLE ONLY "challenge_teams"
    ADD CONSTRAINT "challenge_teams_fk_0"
    FOREIGN KEY("challengeId")
    REFERENCES "challenges"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "challenge_teams"
    ADD CONSTRAINT "challenge_teams_fk_1"
    FOREIGN KEY("ownerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "challenge_updates" table
--
ALTER TABLE ONLY "challenge_updates"
    ADD CONSTRAINT "challenge_updates_fk_0"
    FOREIGN KEY("teamId")
    REFERENCES "challenge_teams"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "challenge_updates"
    ADD CONSTRAINT "challenge_updates_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "challenges" table
--
ALTER TABLE ONLY "challenges"
    ADD CONSTRAINT "challenges_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "challenges"
    ADD CONSTRAINT "challenges_fk_1"
    FOREIGN KEY("ownerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "collaboration_presence" table
--
ALTER TABLE ONLY "collaboration_presence"
    ADD CONSTRAINT "collaboration_presence_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "collaborative_document_revisions" table
--
ALTER TABLE ONLY "collaborative_document_revisions"
    ADD CONSTRAINT "collaborative_document_revisions_fk_0"
    FOREIGN KEY("documentId")
    REFERENCES "collaborative_documents"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "collaborative_document_revisions"
    ADD CONSTRAINT "collaborative_document_revisions_fk_1"
    FOREIGN KEY("editorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "collaborative_documents" table
--
ALTER TABLE ONLY "collaborative_documents"
    ADD CONSTRAINT "collaborative_documents_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "collaborative_documents"
    ADD CONSTRAINT "collaborative_documents_fk_1"
    FOREIGN KEY("ownerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "comments" table
--
ALTER TABLE ONLY "comments"
    ADD CONSTRAINT "comments_fk_0"
    FOREIGN KEY("postId")
    REFERENCES "discussion_posts"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comments"
    ADD CONSTRAINT "comments_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comments"
    ADD CONSTRAINT "comments_fk_2"
    FOREIGN KEY("parentCommentId")
    REFERENCES "comments"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "content_reports" table
--
ALTER TABLE ONLY "content_reports"
    ADD CONSTRAINT "content_reports_fk_0"
    FOREIGN KEY("reporterId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "conversation_members" table
--
ALTER TABLE ONLY "conversation_members"
    ADD CONSTRAINT "conversation_members_fk_0"
    FOREIGN KEY("conversationId")
    REFERENCES "conversations"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "conversation_members"
    ADD CONSTRAINT "conversation_members_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "conversations" table
--
ALTER TABLE ONLY "conversations"
    ADD CONSTRAINT "conversations_fk_0"
    FOREIGN KEY("createdById")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "direct_messages" table
--
ALTER TABLE ONLY "direct_messages"
    ADD CONSTRAINT "direct_messages_fk_0"
    FOREIGN KEY("conversationId")
    REFERENCES "conversations"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "direct_messages"
    ADD CONSTRAINT "direct_messages_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "discussion_posts" table
--
ALTER TABLE ONLY "discussion_posts"
    ADD CONSTRAINT "discussion_posts_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "discussion_posts"
    ADD CONSTRAINT "discussion_posts_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "file_processing" table
--
ALTER TABLE ONLY "file_processing"
    ADD CONSTRAINT "file_processing_fk_0"
    FOREIGN KEY("studyMaterialId")
    REFERENCES "study_materials"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "institution_memberships" table
--
ALTER TABLE ONLY "institution_memberships"
    ADD CONSTRAINT "institution_memberships_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "institution_memberships"
    ADD CONSTRAINT "institution_memberships_fk_1"
    FOREIGN KEY("institutionId")
    REFERENCES "institutions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "moderation_logs" table
--
ALTER TABLE ONLY "moderation_logs"
    ADD CONSTRAINT "moderation_logs_fk_0"
    FOREIGN KEY("reportId")
    REFERENCES "content_reports"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "moderation_logs"
    ADD CONSTRAINT "moderation_logs_fk_1"
    FOREIGN KEY("moderatorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "notifications" table
--
ALTER TABLE ONLY "notifications"
    ADD CONSTRAINT "notifications_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "opportunities" table
--
ALTER TABLE ONLY "opportunities"
    ADD CONSTRAINT "opportunities_fk_0"
    FOREIGN KEY("submittedById")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "opportunity_alerts" table
--
ALTER TABLE ONLY "opportunity_alerts"
    ADD CONSTRAINT "opportunity_alerts_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "opportunity_saves" table
--
ALTER TABLE ONLY "opportunity_saves"
    ADD CONSTRAINT "opportunity_saves_fk_0"
    FOREIGN KEY("opportunityId")
    REFERENCES "opportunities"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "opportunity_saves"
    ADD CONSTRAINT "opportunity_saves_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "payment_transactions" table
--
ALTER TABLE ONLY "payment_transactions"
    ADD CONSTRAINT "payment_transactions_fk_0"
    FOREIGN KEY("subscriptionId")
    REFERENCES "subscriptions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "payment_transactions"
    ADD CONSTRAINT "payment_transactions_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "questions" table
--
ALTER TABLE ONLY "questions"
    ADD CONSTRAINT "questions_fk_0"
    FOREIGN KEY("studyMaterialId")
    REFERENCES "study_materials"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "research_comparisons" table
--
ALTER TABLE ONLY "research_comparisons"
    ADD CONSTRAINT "research_comparisons_fk_0"
    FOREIGN KEY("summaryId")
    REFERENCES "summaries"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "research_comparisons"
    ADD CONSTRAINT "research_comparisons_fk_1"
    FOREIGN KEY("studyMaterialId")
    REFERENCES "study_materials"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "room_ai_answers" table
--
ALTER TABLE ONLY "room_ai_answers"
    ADD CONSTRAINT "room_ai_answers_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_ai_answers"
    ADD CONSTRAINT "room_ai_answers_fk_1"
    FOREIGN KEY("askerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "room_chat_messages" table
--
ALTER TABLE ONLY "room_chat_messages"
    ADD CONSTRAINT "room_chat_messages_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_chat_messages"
    ADD CONSTRAINT "room_chat_messages_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "room_memberships" table
--
ALTER TABLE ONLY "room_memberships"
    ADD CONSTRAINT "room_memberships_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_memberships"
    ADD CONSTRAINT "room_memberships_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "room_resources" table
--
ALTER TABLE ONLY "room_resources"
    ADD CONSTRAINT "room_resources_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_resources"
    ADD CONSTRAINT "room_resources_fk_1"
    FOREIGN KEY("ownerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "scheduled_study_sessions" table
--
ALTER TABLE ONLY "scheduled_study_sessions"
    ADD CONSTRAINT "scheduled_study_sessions_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "scheduled_study_sessions"
    ADD CONSTRAINT "scheduled_study_sessions_fk_1"
    FOREIGN KEY("organizerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "study_history" table
--
ALTER TABLE ONLY "study_history"
    ADD CONSTRAINT "study_history_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "study_materials" table
--
ALTER TABLE ONLY "study_materials"
    ADD CONSTRAINT "study_materials_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "study_rooms" table
--
ALTER TABLE ONLY "study_rooms"
    ADD CONSTRAINT "study_rooms_fk_0"
    FOREIGN KEY("institutionId")
    REFERENCES "institutions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "study_rooms"
    ADD CONSTRAINT "study_rooms_fk_1"
    FOREIGN KEY("ownerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "study_session_participants" table
--
ALTER TABLE ONLY "study_session_participants"
    ADD CONSTRAINT "study_session_participants_fk_0"
    FOREIGN KEY("sessionId")
    REFERENCES "scheduled_study_sessions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "study_session_participants"
    ADD CONSTRAINT "study_session_participants_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "subscriptions" table
--
ALTER TABLE ONLY "subscriptions"
    ADD CONSTRAINT "subscriptions_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "summaries" table
--
ALTER TABLE ONLY "summaries"
    ADD CONSTRAINT "summaries_fk_0"
    FOREIGN KEY("studyMaterialId")
    REFERENCES "study_materials"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "summaries"
    ADD CONSTRAINT "summaries_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "tags" table
--
ALTER TABLE ONLY "tags"
    ADD CONSTRAINT "tags_fk_0"
    FOREIGN KEY("studyMaterialId")
    REFERENCES "study_materials"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_analytics" table
--
ALTER TABLE ONLY "user_analytics"
    ADD CONSTRAINT "user_analytics_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_profile" table
--
ALTER TABLE ONLY "user_profile"
    ADD CONSTRAINT "user_profile_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "user_restrictions" table
--
ALTER TABLE ONLY "user_restrictions"
    ADD CONSTRAINT "user_restrictions_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "verification_requests" table
--
ALTER TABLE ONLY "verification_requests"
    ADD CONSTRAINT "verification_requests_fk_0"
    FOREIGN KEY("membershipId")
    REFERENCES "institution_memberships"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "verification_requests"
    ADD CONSTRAINT "verification_requests_fk_1"
    FOREIGN KEY("reviewerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_log" table
--
ALTER TABLE ONLY "serverpod_log"
    ADD CONSTRAINT "serverpod_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_message_log" table
--
ALTER TABLE ONLY "serverpod_message_log"
    ADD CONSTRAINT "serverpod_message_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;

--
-- Foreign relations for "serverpod_query_log" table
--
ALTER TABLE ONLY "serverpod_query_log"
    ADD CONSTRAINT "serverpod_query_log_fk_0"
    FOREIGN KEY("sessionLogId")
    REFERENCES "serverpod_session_log"("id")
    ON DELETE CASCADE
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828090343692', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828090343692', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20260129181059877', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181059877', "timestamp" = now();


COMMIT;
