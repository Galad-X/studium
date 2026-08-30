BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "collaborative_document_revisions" (
    "id" bigserial PRIMARY KEY,
    "documentId" bigint NOT NULL,
    "editorId" bigint NOT NULL,
    "version" bigint NOT NULL,
    "body" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "collaborative_revision_document_version_idx" ON "collaborative_document_revisions" USING btree ("documentId", "version");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "collaborative_documents" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "ownerId" bigint NOT NULL,
    "title" text NOT NULL,
    "body" text NOT NULL,
    "version" bigint NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "collaborative_document_room_updated_idx" ON "collaborative_documents" USING btree ("roomId", "updatedAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "collaborative_document_revisions"
    ADD CONSTRAINT "collaborative_document_revisions_fk_0"
    FOREIGN KEY("documentId")
    REFERENCES "collaborative_documents"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "collaborative_document_revisions"
    ADD CONSTRAINT "collaborative_document_revisions_fk_1"
    FOREIGN KEY("editorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "collaborative_documents"
    ADD CONSTRAINT "collaborative_documents_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "collaborative_documents"
    ADD CONSTRAINT "collaborative_documents_fk_1"
    FOREIGN KEY("ownerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828084814735', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828084814735', "timestamp" = now();

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
