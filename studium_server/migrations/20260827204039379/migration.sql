BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "challenges" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint,
    "ownerId" bigint NOT NULL,
    "title" text NOT NULL,
    "problemStatement" text NOT NULL,
    "field" text NOT NULL,
    "tags" json NOT NULL,
    "difficulty" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "challenge_room_status_idx" ON "challenges" USING btree ("roomId", "status");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "discussion_posts" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "authorId" bigint NOT NULL,
    "body" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "discussion_post_room_created_idx" ON "discussion_posts" USING btree ("roomId", "createdAt");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "institution_memberships" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "institutionId" bigint NOT NULL,
    "role" text NOT NULL,
    "verificationMethod" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "verifiedAt" timestamp without time zone
);

-- Indexes
CREATE UNIQUE INDEX "institution_membership_user_institution_idx" ON "institution_memberships" USING btree ("userId", "institutionId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "institutions" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "country" text NOT NULL,
    "region" text,
    "domains" json NOT NULL,
    "logoUrl" text,
    "verificationStatus" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "institution_name_idx" ON "institutions" USING btree ("name");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "room_memberships" (
    "id" bigserial PRIMARY KEY,
    "roomId" bigint NOT NULL,
    "userId" bigint NOT NULL,
    "role" text NOT NULL,
    "status" text NOT NULL,
    "joinedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "room_membership_room_user_idx" ON "room_memberships" USING btree ("roomId", "userId");

--
-- ACTION CREATE TABLE
--
CREATE TABLE "study_rooms" (
    "id" bigserial PRIMARY KEY,
    "institutionId" bigint,
    "ownerId" bigint NOT NULL,
    "title" text NOT NULL,
    "description" text NOT NULL,
    "subject" text,
    "visibility" text NOT NULL,
    "membershipPolicy" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "study_room_institution_status_idx" ON "study_rooms" USING btree ("institutionId", "status");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "challenges"
    ADD CONSTRAINT "challenges_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "challenges"
    ADD CONSTRAINT "challenges_fk_1"
    FOREIGN KEY("ownerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "discussion_posts"
    ADD CONSTRAINT "discussion_posts_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "discussion_posts"
    ADD CONSTRAINT "discussion_posts_fk_1"
    FOREIGN KEY("authorId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "institution_memberships"
    ADD CONSTRAINT "institution_memberships_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "institution_memberships"
    ADD CONSTRAINT "institution_memberships_fk_1"
    FOREIGN KEY("institutionId")
    REFERENCES "institutions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "room_memberships"
    ADD CONSTRAINT "room_memberships_fk_0"
    FOREIGN KEY("roomId")
    REFERENCES "study_rooms"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "room_memberships"
    ADD CONSTRAINT "room_memberships_fk_1"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "study_rooms"
    ADD CONSTRAINT "study_rooms_fk_0"
    FOREIGN KEY("institutionId")
    REFERENCES "institutions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "study_rooms"
    ADD CONSTRAINT "study_rooms_fk_1"
    FOREIGN KEY("ownerId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260827204039379', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260827204039379', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20240516151843329', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240516151843329', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth', '20240520102713718', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20240520102713718', "timestamp" = now();


COMMIT;
