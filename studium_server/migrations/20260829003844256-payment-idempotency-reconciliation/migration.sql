BEGIN;

--
-- ACTION ALTER TABLE
--
CREATE UNIQUE INDEX "payment_transaction_gateway_id_idx" ON "payment_transactions" USING btree ("gateway", "transactionId");
--
-- ACTION CREATE TABLE
--
CREATE TABLE "subscription_operations" (
    "id" bigserial PRIMARY KEY,
    "userId" bigint NOT NULL,
    "gateway" text NOT NULL,
    "idempotencyKey" text NOT NULL,
    "status" text NOT NULL,
    "subscriptionId" bigint,
    "errorMessage" text,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "subscription_operation_unique_idx" ON "subscription_operations" USING btree ("userId", "gateway", "idempotencyKey");
CREATE INDEX "subscription_operation_updated_idx" ON "subscription_operations" USING btree ("updatedAt");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "subscription_operations"
    ADD CONSTRAINT "subscription_operations_fk_0"
    FOREIGN KEY("userId")
    REFERENCES "serverpod_user_info"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "subscription_operations"
    ADD CONSTRAINT "subscription_operations_fk_1"
    FOREIGN KEY("subscriptionId")
    REFERENCES "subscriptions"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR studium
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('studium', '20260829003844256-payment-idempotency-reconciliation', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260829003844256-payment-idempotency-reconciliation', "timestamp" = now();

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
