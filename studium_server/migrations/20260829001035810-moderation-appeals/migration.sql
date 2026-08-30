BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "moderation_appeals" (
    "id" bigserial PRIMARY KEY,
    "reportId" bigint NOT NULL,
    "appellantId" bigint NOT NULL,
    "reason" text NOT NULL,
    "status" text NOT NULL,
    "reviewerId" bigint,
    "reviewNotes" text,
    "createdAt" timestamp without time zone NOT NULL,
    "reviewedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "moderation_appeal_report_appellant_idx" ON "moderation_appeals" USING btree ("reportId", "appellantId");
CREATE INDEX "moderation_appeal_status_created_idx" ON "moderation_appeals" USING btree ("status", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "moderation_appeals"
    ADD CONSTRAINT "moderation_appeals_fk_0"
    FOREIGN KEY("reportId")
    REFERENCES "content_reports"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "moderation_appeals"
    ADD CONSTRAINT "moderation_appeals_fk_1"
    FOREIGN KEY("appellantId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "moderation_appeals"
    ADD CONSTRAINT "moderation_appeals_fk_2"
    FOREIGN KEY("reviewerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829001035810-moderation-appeals', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829001035810-moderation-appeals', "timestamp" = now();

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
