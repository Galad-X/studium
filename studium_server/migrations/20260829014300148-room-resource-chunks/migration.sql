BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_resource_chunks" (
    "id" bigserial PRIMARY KEY,
    "roomResourceId" bigint NOT NULL,
    "chunkIndex" bigint NOT NULL,
    "content" text NOT NULL,
    "tokenCount" bigint NOT NULL,
    "embedding" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "room_resource_chunk_unique_idx" ON "room_resource_chunks" USING btree ("roomResourceId", "chunkIndex");
CREATE INDEX "room_resource_chunk_resource_idx" ON "room_resource_chunks" USING btree ("roomResourceId", "chunkIndex");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_resource_chunks"
    ADD CONSTRAINT "room_resource_chunks_fk_0"
    FOREIGN KEY("roomResourceId")
    REFERENCES "room_resources"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829014300148-room-resource-chunks', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829014300148-room-resource-chunks', "timestamp" = now();

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
