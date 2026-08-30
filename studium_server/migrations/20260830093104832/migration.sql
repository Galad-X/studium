BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_privacy_settings" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "isMinor" boolean NOT NULL DEFAULT false,
    "allowUnknownDirectMessages" boolean NOT NULL DEFAULT true,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_privacy_settings_user_idx" ON "user_privacy_settings" USING btree ("userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_privacy_settings"
    ADD CONSTRAINT "user_privacy_settings_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260830093104832', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260830093104832', "timestamp" = now();

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
