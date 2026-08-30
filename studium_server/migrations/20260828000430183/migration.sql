BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION ALTER TABLE
--
ALTER TABLE "serverpod_session_log" ADD COLUMN "userId" text;
CREATE INDEX "serverpod_session_log_time_idx" ON "serverpod_session_log" USING btree ("time");
--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828000430183', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828000430183', "timestamp" = now();

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
