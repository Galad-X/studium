BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "notifications" ADD COLUMN "relatedId" bigint;
--
-- ACTION DROP TABLE
--
DROP TABLE "questions" CASCADE;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "questions" (
    "id" bigserial PRIMARY KEY,
    "studyMaterialId" bigint NOT NULL,
    "type" text NOT NULL,
    "questionText" text NOT NULL,
    "correctAnswer" text,
    "options" json,
    "explanation" text,
    "difficulty" text NOT NULL,
    "bloomsLevel" text NOT NULL,
    "estimatedTime" bigint NOT NULL,
    "tags" json,
    "diagramImageUrl" text,
    "labelingPoints" json,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "subscriptions" ADD COLUMN "gatewayToken" text;
--
-- ACTION ALTER TABLE
--
ALTER TABLE "user_profile" ADD COLUMN "stripeCustomerId" text;
ALTER TABLE "user_profile" ADD COLUMN "paystackCustomerCode" text;
CREATE UNIQUE INDEX "user_profile_stripe_customer_id_idx" ON "user_profile" USING btree ("stripeCustomerId");
CREATE UNIQUE INDEX "user_profile_paystack_customer_code_idx" ON "user_profile" USING btree ("paystackCustomerCode");
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "questions"
    ADD CONSTRAINT "questions_fk_0"
    FOREIGN KEY("studyMaterialId")
    REFERENCES "study_materials"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20250630152027103', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20250630152027103', "timestamp" = now();

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
