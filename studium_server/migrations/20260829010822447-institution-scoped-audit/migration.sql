BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "audit_events" ADD COLUMN "institutionId" bigint;
CREATE INDEX "audit_event_institution_idx" ON "audit_events" USING btree ("institutionId", "createdAt");
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "audit_events"
    ADD CONSTRAINT "audit_events_fk_1"
    FOREIGN KEY("institutionId")
    REFERENCES "institutions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829010822447-institution-scoped-audit', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829010822447-institution-scoped-audit', "timestamp" = now();

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
