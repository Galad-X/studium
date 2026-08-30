BEGIN;

--
-- ACTION CREATE TABLE
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
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "collaboration_presence"
    ADD CONSTRAINT "collaboration_presence_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828081721280', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828081721280', "timestamp" = now();

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
