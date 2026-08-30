BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "email_deliveries" (
    "id" bigserial PRIMARY KEY,
    "recipient" text NOT NULL,
    "subject" text NOT NULL,
    "htmlBody" text NOT NULL,
    "dedupeKey" text,
    "status" text NOT NULL,
    "attempts" bigint NOT NULL,
    "maxAttempts" bigint NOT NULL,
    "availableAt" timestamp without time zone NOT NULL,
    "lockedAt" timestamp without time zone,
    "lockToken" text,
    "lastError" text,
    "sentAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "email_delivery_claim_idx" ON "email_deliveries" USING btree ("status", "availableAt", "createdAt");
CREATE INDEX "email_delivery_lock_idx" ON "email_deliveries" USING btree ("lockToken");
CREATE UNIQUE INDEX "email_delivery_dedupe_idx" ON "email_deliveries" USING btree ("dedupeKey");


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829031544956-durable-email-delivery', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829031544956-durable-email-delivery', "timestamp" = now();

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
