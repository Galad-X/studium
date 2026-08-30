BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "payment_webhook_events" (
    "id" bigserial PRIMARY KEY,
    "gateway" text NOT NULL,
    "eventId" text NOT NULL,
    "eventType" text NOT NULL,
    "payload" text NOT NULL,
    "status" text NOT NULL,
    "receivedAt" timestamp without time zone NOT NULL,
    "processedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "payment_webhook_gateway_event_idx" ON "payment_webhook_events" USING btree ("gateway", "eventId");
CREATE INDEX "payment_webhook_received_idx" ON "payment_webhook_events" USING btree ("receivedAt");


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828090343692', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828090343692', "timestamp" = now();

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
