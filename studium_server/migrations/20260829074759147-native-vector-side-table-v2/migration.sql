BEGIN;

CREATE EXTENSION IF NOT EXISTS vector;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "room_resource_chunks"
  DROP COLUMN IF EXISTS "embeddingVector";

CREATE TABLE IF NOT EXISTS "room_resource_chunk_embeddings" (
  "roomResourceChunkId" bigint PRIMARY KEY
    REFERENCES "room_resource_chunks" ("id") ON DELETE CASCADE,
  "embedding" vector(1536) NOT NULL,
  "updatedAt" timestamp without time zone NOT NULL
);

CREATE INDEX IF NOT EXISTS "room_resource_chunk_embeddings_hnsw_idx"
  ON "room_resource_chunk_embeddings"
  USING hnsw ("embedding" vector_cosine_ops);

--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829074759147-native-vector-side-table-v2', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829074759147-native-vector-side-table-v2', "timestamp" = now();

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
