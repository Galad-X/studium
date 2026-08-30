BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "institutions" ADD COLUMN "submittedById" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "institutions"
    ADD CONSTRAINT "institutions_fk_0"
    FOREIGN KEY("submittedById")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829051745116', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829051745116', "timestamp" = now();

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
