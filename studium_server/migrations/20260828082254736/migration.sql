BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828082254736', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828082254736', "timestamp" = now();

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
