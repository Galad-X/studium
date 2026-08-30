BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "opportunities" DROP CONSTRAINT IF EXISTS "opportunities_fk_0";
ALTER TABLE "opportunities" ADD COLUMN "sourceId" bigint;
ALTER TABLE "opportunities" ADD COLUMN "externalId" text;
CREATE UNIQUE INDEX "opportunity_source_external_idx" ON "opportunities" USING btree ("sourceId", "externalId");
--
-- ACTION CREATE TABLE
--
CREATE TABLE "opportunity_sources" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "provider" text NOT NULL,
    "feedUrl" text NOT NULL,
    "verificationStatus" text NOT NULL,
    "createdById" bigint NOT NULL,
    "lastSyncedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "opportunity_source_feed_idx" ON "opportunity_sources" USING btree ("feedUrl");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "opportunities"
    ADD CONSTRAINT "opportunities_fk_1"
    FOREIGN KEY("submittedById")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "opportunities"
    ADD CONSTRAINT "opportunities_fk_0"
    FOREIGN KEY("sourceId")
    REFERENCES "opportunity_sources"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "opportunity_sources"
    ADD CONSTRAINT "opportunity_sources_fk_0"
    FOREIGN KEY("createdById")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829015305782-opportunity-provider-ingestion', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829015305782-opportunity-provider-ingestion', "timestamp" = now();

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
