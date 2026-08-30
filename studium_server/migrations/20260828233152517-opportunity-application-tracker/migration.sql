BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "opportunity_application_trackers" (
    "id" bigserial PRIMARY KEY,
    "opportunityId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "status" text NOT NULL,
    "notes" text,
    "applicationUrl" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "opportunity_tracker_user_opportunity_idx" ON "opportunity_application_trackers" USING btree ("userId", "opportunityId");
CREATE INDEX "opportunity_tracker_user_updated_idx" ON "opportunity_application_trackers" USING btree ("userId", "updatedAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "opportunity_application_trackers"
    ADD CONSTRAINT "opportunity_application_trackers_fk_0"
    FOREIGN KEY("opportunityId")
    REFERENCES "opportunities"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "opportunity_application_trackers"
    ADD CONSTRAINT "opportunity_application_trackers_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828233152517-opportunity-application-tracker', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828233152517-opportunity-application-tracker', "timestamp" = now();

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
