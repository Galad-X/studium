BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_resources" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "ownerId" bigint NOT NULL,
    "resourceType" text NOT NULL,
    "title" text NOT NULL,
    "uri" text,
    "content" text,
    "citation" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "room_resource_room_status_created_idx" ON "room_resources" USING btree ("roomId", "status", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_resources"
    ADD CONSTRAINT "room_resources_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_resources"
    ADD CONSTRAINT "room_resources_fk_1"
    FOREIGN KEY("ownerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828062014593', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828062014593', "timestamp" = now();

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
