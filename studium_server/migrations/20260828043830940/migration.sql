BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_restrictions" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "restrictionType" text NOT NULL,
    "reason" text NOT NULL,
    "expiresAt" timestamp without time zone,
    "active" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "user_restriction_user_active_idx" ON "user_restrictions" USING btree ("userId", "active");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_restrictions"
    ADD CONSTRAINT "user_restrictions_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828043830940', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828043830940', "timestamp" = now();

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
