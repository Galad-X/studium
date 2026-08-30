BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "opportunity_alerts" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "country" text,
    "field" text,
    "educationLevel" text,
    "opportunityTypes" json NOT NULL,
    "deadlineWithinDays" bigint NOT NULL,
    "active" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "opportunity_alert_user_active_idx" ON "opportunity_alerts" USING btree ("userId", "active");
CREATE INDEX "opportunity_alert_user_updated_idx" ON "opportunity_alerts" USING btree ("userId", "updatedAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "opportunity_alerts"
    ADD CONSTRAINT "opportunity_alerts_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828071316200', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828071316200', "timestamp" = now();

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
