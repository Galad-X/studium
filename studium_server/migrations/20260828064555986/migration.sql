BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_ai_answers" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "askerId" bigint NOT NULL,
    "question" text NOT NULL,
    "answer" text NOT NULL,
    "sourceResourceIds" json NOT NULL,
    "citations" json NOT NULL,
    "confidence" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "room_ai_answer_room_created_idx" ON "room_ai_answers" USING btree ("roomId", "createdAt");
CREATE INDEX "room_ai_answer_asker_created_idx" ON "room_ai_answers" USING btree ("askerId", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_ai_answers"
    ADD CONSTRAINT "room_ai_answers_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_ai_answers"
    ADD CONSTRAINT "room_ai_answers_fk_1"
    FOREIGN KEY("askerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828064555986', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828064555986', "timestamp" = now();

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
