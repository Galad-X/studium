BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "comments" (
    "id" bigserial PRIMARY KEY,
    "postId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "parentCommentId" bigint,
    "body" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "comment_post_created_idx" ON "comments" USING btree ("postId", "createdAt");
CREATE INDEX "comment_parent_idx" ON "comments" USING btree ("parentCommentId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "comments"
    ADD CONSTRAINT "comments_fk_0"
    FOREIGN KEY("postId")
    REFERENCES "discussion_posts"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comments"
    ADD CONSTRAINT "comments_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "comments"
    ADD CONSTRAINT "comments_fk_2"
    FOREIGN KEY("parentCommentId")
    REFERENCES "comments"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260828073428434', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260828073428434', "timestamp" = now();

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
