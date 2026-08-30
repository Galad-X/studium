BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "push_devices" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "token" text NOT NULL,
    "platform" text NOT NULL,
    "active" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "push_device_token_idx" ON "push_devices" USING btree ("token");
CREATE INDEX "push_device_user_active_idx" ON "push_devices" USING btree ("userId", "active");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "push_devices"
    ADD CONSTRAINT "push_devices_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828091436086', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828091436086', "timestamp" = now();

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
