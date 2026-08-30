BEGIN;

CREATE EXTENSION IF NOT EXISTS vector;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "room_resource_chunks" ADD COLUMN "embeddingVector" vector(1536);
CREATE INDEX "room_resource_chunk_embedding_hnsw_idx"
  ON "room_resource_chunks" USING hnsw ("embeddingVector" vector_cosine_ops);

--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829073057924-native-vector', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829073057924-native-vector', "timestamp" = now();

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
