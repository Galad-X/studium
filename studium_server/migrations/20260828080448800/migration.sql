BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "conversation_members" (
    "id" bigserial PRIMARY KEY,
    "conversationId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "status" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "conversation_member_unique_idx" ON "conversation_members" USING btree ("conversationId", "userId");
CREATE INDEX "conversation_member_user_idx" ON "conversation_members" USING btree ("userId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "conversations" (
    "id" bigserial PRIMARY KEY,
    "conversationType" text NOT NULL,
    "title" text,
    "createdById" bigint NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "conversation_updated_idx" ON "conversations" USING btree ("updatedAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "direct_messages" (
    "id" bigserial PRIMARY KEY,
    "conversationId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "body" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "direct_message_conversation_created_idx" ON "direct_messages" USING btree ("conversationId", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "conversation_members"
    ADD CONSTRAINT "conversation_members_fk_0"
    FOREIGN KEY("conversationId")
    REFERENCES "conversations"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "conversation_members"
    ADD CONSTRAINT "conversation_members_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "conversations"
    ADD CONSTRAINT "conversations_fk_0"
    FOREIGN KEY("createdById")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "direct_messages"
    ADD CONSTRAINT "direct_messages_fk_0"
    FOREIGN KEY("conversationId")
    REFERENCES "conversations"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "direct_messages"
    ADD CONSTRAINT "direct_messages_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828080448800', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828080448800', "timestamp" = now();

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
