BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "audit_events" (
    "id" bigserial PRIMARY KEY,
    "actorId" bigint NOT NULL,
    "action" text NOT NULL,
    "targetType" text NOT NULL,
    "targetId" bigint NOT NULL,
    "metadata" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "audit_event_target_idx" ON "audit_events" USING btree ("targetType", "targetId", "createdAt");
CREATE INDEX "audit_event_actor_idx" ON "audit_events" USING btree ("actorId", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "audit_events"
    ADD CONSTRAINT "audit_events_fk_0"
    FOREIGN KEY("actorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828234931777-audit-events', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828234931777-audit-events', "timestamp" = now();

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
