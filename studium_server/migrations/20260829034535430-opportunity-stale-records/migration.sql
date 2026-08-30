BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "opportunities" ADD COLUMN "lastSeenAt" timestamp without time zone;
ALTER TABLE "opportunities" ADD COLUMN "staleAt" timestamp without time zone;

--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829034535430-opportunity-stale-records', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829034535430-opportunity-stale-records', "timestamp" = now();

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
