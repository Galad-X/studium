BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "discussion_posts" ADD COLUMN "acceptedCommentId" bigint;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "discussion_posts"
    ADD CONSTRAINT "discussion_posts_fk_2"
    FOREIGN KEY("acceptedCommentId")
    REFERENCES "comments"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829053601249', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829053601249', "timestamp" = now();

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
