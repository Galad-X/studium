BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "user_safety_relationships" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "targetUserId" bigint NOT NULL,
    "relationshipType" text NOT NULL,
    "active" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "user_safety_relationship_unique_idx" ON "user_safety_relationships" USING btree ("userId", "targetUserId", "relationshipType");
CREATE INDEX "user_safety_relationship_user_idx" ON "user_safety_relationships" USING btree ("userId", "relationshipType", "active");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "user_safety_relationships"
    ADD CONSTRAINT "user_safety_relationships_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "user_safety_relationships"
    ADD CONSTRAINT "user_safety_relationships_fk_1"
    FOREIGN KEY("targetUserId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829000345605-user-safety-relationships', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829000345605-user-safety-relationships', "timestamp" = now();

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
