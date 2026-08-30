BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE TABLE
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "challenge_milestones"
    ADD CONSTRAINT "challenge_milestones_fk_0"
    FOREIGN KEY("teamId")
    REFERENCES "challenge_teams"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
-- ACTION CREATE FOREIGN KEY
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
