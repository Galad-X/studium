BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "discussion_reactions" (
    "id" bigserial PRIMARY KEY,
    "postId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "reaction" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "discussion_reaction_post_user_idx" ON "discussion_reactions" USING btree ("postId", "userId");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "discussion_reactions"
    ADD CONSTRAINT "discussion_reactions_fk_0"
    FOREIGN KEY("postId")
    REFERENCES "discussion_posts"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "discussion_reactions"
    ADD CONSTRAINT "discussion_reactions_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829054824311', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829054824311', "timestamp" = now();

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
