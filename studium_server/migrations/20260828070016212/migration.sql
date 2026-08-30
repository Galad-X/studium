BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "opportunities" (
    "id" bigserial PRIMARY KEY,
    "title" text NOT NULL,
    "opportunityType" text NOT NULL,
    "provider" text NOT NULL,
    "country" text NOT NULL,
    "eligibilityRegion" text,
    "field" text NOT NULL,
    "educationLevel" text NOT NULL,
    "deadline" timestamp without time zone NOT NULL,
    "fundingDetails" text NOT NULL,
    "officialUrl" text NOT NULL,
    "verificationStatus" text NOT NULL,
    "submittedById" bigint,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "opportunity_status_deadline_idx" ON "opportunities" USING btree ("verificationStatus", "deadline");
CREATE INDEX "opportunity_filter_idx" ON "opportunities" USING btree ("country", "field", "educationLevel");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "opportunity_saves" (
    "id" bigserial PRIMARY KEY,
    "opportunityId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "alertEnabled" boolean NOT NULL,
    "savedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "opportunity_save_user_opportunity_idx" ON "opportunity_saves" USING btree ("userId", "opportunityId");
CREATE INDEX "opportunity_save_user_saved_idx" ON "opportunity_saves" USING btree ("userId", "savedAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "opportunities"
    ADD CONSTRAINT "opportunities_fk_0"
    FOREIGN KEY("submittedById")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "opportunity_saves"
    ADD CONSTRAINT "opportunity_saves_fk_0"
    FOREIGN KEY("opportunityId")
    REFERENCES "opportunities"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "opportunity_saves"
    ADD CONSTRAINT "opportunity_saves_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828070016212', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828070016212', "timestamp" = now();

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
