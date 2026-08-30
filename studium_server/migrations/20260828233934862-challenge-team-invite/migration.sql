BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "challenge_team_invites" (
    "id" bigserial PRIMARY KEY,
    "teamId" bigint NOT NULL,
    "inviterId" bigint NOT NULL,
    "inviteeId" bigint NOT NULL,
    "tokenHash" text NOT NULL,
    "status" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "acceptedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "challenge_team_invite_token_idx" ON "challenge_team_invites" USING btree ("tokenHash");
CREATE INDEX "challenge_team_invite_target_idx" ON "challenge_team_invites" USING btree ("teamId", "inviteeId", "status");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "challenge_team_invites"
    ADD CONSTRAINT "challenge_team_invites_fk_0"
    FOREIGN KEY("teamId")
    REFERENCES "challenge_teams"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "challenge_team_invites"
    ADD CONSTRAINT "challenge_team_invites_fk_1"
    FOREIGN KEY("inviterId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "challenge_team_invites"
    ADD CONSTRAINT "challenge_team_invites_fk_2"
    FOREIGN KEY("inviteeId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828233934862-challenge-team-invite', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828233934862-challenge-team-invite', "timestamp" = now();

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
