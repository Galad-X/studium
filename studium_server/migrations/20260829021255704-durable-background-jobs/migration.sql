BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "background_jobs" (
    "id" bigserial PRIMARY KEY,
    "jobType" text NOT NULL,
    "payload" text NOT NULL,
    "status" text NOT NULL,
    "attempts" bigint NOT NULL,
    "maxAttempts" bigint NOT NULL,
    "availableAt" timestamp without time zone NOT NULL,
    "lockedAt" timestamp without time zone,
    "lockToken" text,
    "lastError" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "background_job_claim_idx" ON "background_jobs" USING btree ("status", "availableAt", "createdAt");
CREATE INDEX "background_job_lock_idx" ON "background_jobs" USING btree ("lockToken");


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829021255704-durable-background-jobs', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829021255704-durable-background-jobs', "timestamp" = now();

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
