BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "api_rate_limit_buckets" (
    "id" bigserial PRIMARY KEY,
    "scopeKey" text NOT NULL,
    "windowStart" timestamp without time zone NOT NULL,
    "requestCount" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "api_rate_limit_bucket_unique_idx" ON "api_rate_limit_buckets" USING btree ("scopeKey", "windowStart");
CREATE INDEX "api_rate_limit_bucket_cleanup_idx" ON "api_rate_limit_buckets" USING btree ("updatedAt");


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829002626176-api-rate-limits', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829002626176-api-rate-limits', "timestamp" = now();

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
