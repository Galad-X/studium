BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_whiteboard_states" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "version" bigint NOT NULL DEFAULT 0,
    "strokesJson" text NOT NULL,
    "updatedById" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "room_whiteboard_room_idx" ON "room_whiteboard_states" USING btree ("roomId");

--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_privacy_settings" ADD COLUMN "dateOfBirth" timestamp without time zone;
ALTER TABLE "user_privacy_settings" ADD COLUMN "guardianConsentAt" timestamp without time zone;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_whiteboard_states"
    ADD CONSTRAINT "room_whiteboard_states_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_whiteboard_states"
    ADD CONSTRAINT "room_whiteboard_states_fk_1"
    FOREIGN KEY("updatedById")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260831004536780-whiteboard-guardian-policy', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260831004536780-whiteboard-guardian-policy', "timestamp" = now();

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
