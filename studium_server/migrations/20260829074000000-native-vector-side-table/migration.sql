BEGIN;

CREATE EXTENSION IF NOT EXISTS vector;

DROP INDEX IF EXISTS "room_resource_chunk_embedding_hnsw_idx";
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

INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
  VALUES ('studium', '20260829074000000-native-vector-side-table', now())
  ON CONFLICT ("module") DO UPDATE SET
    "version" = '20260829074000000-native-vector-side-table',
    "timestamp" = now();

COMMIT;
