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
-- Class ChallengeUpdate as table challenge_updates
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
-- Foreign relations for "notifications" table
--
ALTER TABLE ONLY "notifications"
    ADD CONSTRAINT "notifications_fk_0"
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
    VALUES ('studium', '20260828002042807', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828002042807', "timestamp" = now();

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
