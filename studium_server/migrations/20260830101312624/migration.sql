BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_reputation" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "score" bigint NOT NULL DEFAULT 0,
    "acceptedSolutions" bigint NOT NULL DEFAULT 0,
    "verifiedContributions" bigint NOT NULL DEFAULT 0,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_reputation_user_idx" ON "user_reputation" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_reputation"
    ADD CONSTRAINT "user_reputation_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260830101312624', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260830101312624', "timestamp" = now();

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
