BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "institution_invites" (
    "id" bigserial PRIMARY KEY,
    "institutionId" bigint NOT NULL,
    "createdById" bigint NOT NULL,
    "tokenHash" text NOT NULL,
    "expiresAt" timestamp without time zone NOT NULL,
    "maxUses" bigint NOT NULL,
    "uses" bigint NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "institution_invite_token_idx" ON "institution_invites" USING btree ("tokenHash");
CREATE INDEX "institution_invite_institution_status_idx" ON "institution_invites" USING btree ("institutionId", "status", "expiresAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "institution_invites"
    ADD CONSTRAINT "institution_invites_fk_0"
    FOREIGN KEY("institutionId")
    REFERENCES "institutions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "institution_invites"
    ADD CONSTRAINT "institution_invites_fk_1"
    FOREIGN KEY("createdById")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828092140438', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828092140438', "timestamp" = now();

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
