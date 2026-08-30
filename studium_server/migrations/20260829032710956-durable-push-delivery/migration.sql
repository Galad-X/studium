BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "push_deliveries" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "title" text NOT NULL,
    "message" text NOT NULL,
    "type" text,
    "relatedId" bigint,
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
CREATE INDEX "push_delivery_claim_idx" ON "push_deliveries" USING btree ("status", "availableAt", "createdAt");
CREATE INDEX "push_delivery_lock_idx" ON "push_deliveries" USING btree ("lockToken");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "push_deliveries"
    ADD CONSTRAINT "push_deliveries_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829032710956-durable-push-delivery', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829032710956-durable-push-delivery', "timestamp" = now();

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
