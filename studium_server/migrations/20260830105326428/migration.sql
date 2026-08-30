BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "conversation_read_receipts" (
    "id" bigserial PRIMARY KEY,
    "conversationId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "lastReadMessageId" bigint NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "conversation_read_receipt_unique_idx" ON "conversation_read_receipts" USING btree ("conversationId", "userId");
CREATE INDEX "conversation_read_receipt_user_idx" ON "conversation_read_receipts" USING btree ("userId", "updatedAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "conversation_read_receipts"
    ADD CONSTRAINT "conversation_read_receipts_fk_0"
    FOREIGN KEY("conversationId")
    REFERENCES "conversations"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "conversation_read_receipts"
    ADD CONSTRAINT "conversation_read_receipts_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "conversation_read_receipts"
    ADD CONSTRAINT "conversation_read_receipts_fk_2"
    FOREIGN KEY("lastReadMessageId")
    REFERENCES "direct_messages"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260830105326428', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260830105326428', "timestamp" = now();

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
