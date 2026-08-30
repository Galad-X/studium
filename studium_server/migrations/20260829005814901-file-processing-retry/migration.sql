BEGIN;

--
-- ACTION DROP TABLE
--
DROP TABLE "file_processing" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "file_processing" (
    "id" bigserial PRIMARY KEY,
    "studyMaterialId" bigint NOT NULL,
    "status" text NOT NULL,
    "processedText" text,
    "errorMessage" text,
    "attempts" bigint NOT NULL,
    "maxAttempts" bigint NOT NULL,
    "lastStartedAt" timestamp without time zone,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "file_processing"
    ADD CONSTRAINT "file_processing_fk_0"
    FOREIGN KEY("studyMaterialId")
    REFERENCES "study_materials"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829005814901-file-processing-retry', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829005814901-file-processing-retry', "timestamp" = now();

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
