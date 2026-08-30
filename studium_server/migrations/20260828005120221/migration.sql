BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "content_reports" (
    "id" bigserial PRIMARY KEY,
    "reporterId" bigint NOT NULL,
    "contentType" text NOT NULL,
    "contentId" bigint NOT NULL,
    "reason" text NOT NULL,
    "details" text,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "resolvedAt" timestamp without time zone
);

-- Indexes
CREATE INDEX "content_report_status_created_idx" ON "content_reports" USING btree ("status", "createdAt");
CREATE INDEX "content_report_reporter_idx" ON "content_reports" USING btree ("reporterId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "moderation_logs" (
    "id" bigserial PRIMARY KEY,
    "reportId" bigint NOT NULL,
    "moderatorId" bigint NOT NULL,
    "action" text NOT NULL,
    "targetType" text NOT NULL,
    "targetId" bigint NOT NULL,
    "note" text,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "moderation_log_report_idx" ON "moderation_logs" USING btree ("reportId", "createdAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "content_reports"
    ADD CONSTRAINT "content_reports_fk_0"
    FOREIGN KEY("reporterId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "moderation_logs"
    ADD CONSTRAINT "moderation_logs_fk_0"
    FOREIGN KEY("reportId")
    REFERENCES "content_reports"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "moderation_logs"
    ADD CONSTRAINT "moderation_logs_fk_1"
    FOREIGN KEY("moderatorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828005120221', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828005120221', "timestamp" = now();

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
