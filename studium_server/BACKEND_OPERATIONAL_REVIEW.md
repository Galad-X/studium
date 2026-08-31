# Backend operational review

This is the pre-deployment review checklist for the local Serverpod/PostgreSQL
backend. Deployment work is intentionally out of scope.

## Verified in repository tests

- Background jobs transition through pending, processing, retry, stale-lock
  recovery, completion, and dead-letter states.
- Email and push delivery retry, reclaim stale claims, and dead-letter after
  the configured attempt limit.
- Signed payment webhook events are idempotent. Refund fixtures cover partial
  and full refunds, cancellation, duplicate events, and entitlement reversal.
- Room resources cover text extraction, DOCX/PPTX/XLSX archive parsing, OCR
  failure, embedding jobs, malformed input, and retry behavior.
- Endpoint pagination caps and rate-limit validation are enforced in service
  code and selected integration tests.

## Required local environment verification

### Migration clean install

1. Start the test PostgreSQL service with `docker compose up -d postgres_test`.
2. Point Serverpod test configuration at the empty `studium_test` database.
3. Apply all migrations in order and confirm every migration completes.
4. Confirm the final schema contains every generated model table, unique
   membership/idempotency index, and the `room_resource_chunk_embeddings`
   vector column.

### Migration upgrade

1. Restore a representative database snapshot from before the latest migration.
2. Apply the remaining migrations in order.
3. Verify existing memberships, subscriptions, audit events, resources, and
   payment events are preserved.
4. Verify the new whiteboard and guardian-consent columns accept null legacy
   values and enforce their unique/index constraints.

### Operational controls

- Rate limits: review every public mutation and confirm limits are bounded in
  `endpoint_utils.dart` and the endpoint-specific guards.
- Pagination: every feed/list endpoint must clamp page size and use a stable
  ordering with an indexed filter.
- Indexes: review generated migration SQL for membership, room, challenge,
  deadline, timestamp, idempotency, and audit lookup indexes.
- Audit retention: define an institution/platform retention period and a
  scheduled purge policy that preserves records required for appeals or law.
- Personal data: provide authenticated export and deletion workflows, redact
  tokens/files from exports, revoke push devices, and retain only legally
  required audit/payment records.

## Still blocked on environment or policy decisions

- Clean-database and upgrade-database migration runs require a disposable
  PostgreSQL instance or approved snapshot.
- Gateway reconciliation and real provider callback verification require
  Stripe/Paystack fixture credentials or a gateway sandbox.
- Formal age thresholds, guardian identity verification, audit retention, and
  deletion exceptions require product/legal approval.
