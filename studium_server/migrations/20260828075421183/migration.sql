BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_chat_messages" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "body" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "room_chat_room_created_idx" ON "room_chat_messages" USING btree ("roomId", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_chat_messages"
    ADD CONSTRAINT "room_chat_messages_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_chat_messages"
    ADD CONSTRAINT "room_chat_messages_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828075421183', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828075421183', "timestamp" = now();

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
