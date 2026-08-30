# Studium backend capability matrix

This is the backend-first milestone for the Global Collaboration Platform. A capability is marked **implemented** only when it has a Serverpod endpoint, persistence, authorization, and focused test coverage.

## Implemented and verified

1. **Authentication boundary**
   - Authenticated user identity is derived from the Serverpod session.
   - Profile updates accept display-name changes only; authorization roles are never client-writable, with regression coverage against role escalation.
   - Study-history creation derives ownership from the authenticated session; client-supplied user IDs are not accepted.
   - Unauthenticated collaboration, opportunity, notification, messaging, billing, and push operations are rejected.
   - Retained summary, analytics, and study-material collection reads enforce server-side row caps to prevent unbounded responses.

2. **Institution identity**
   - Verified institution discovery.
   - Institution subject/programme and language metadata is persisted for discovery filtering.
   - Authenticated users can submit validated institutions for review; duplicate name/country submissions reuse the existing record.
   - Platform moderators can approve or reject pending institution submissions.
   - Platform moderators have a bounded, paginated pending-institution review queue.
   - Approved submitted institutions transactionally provision the submitter as the initial verified institution admin.
   - Institution submission and review transitions are append-only audited.
   - Institution email-domain verification.
   - Manual verification requests and evidence URLs.
   - Membership history lookup.
   - Institution invites with hashed, expiring, single-use tokens.
   - Institution member listing, role/status administration, and moderator review.
   - Institution-scoped pending verification request/evidence retrieval for moderators.
   - Academic profile persistence with bounded lists and verified-membership authorization.

3. **Study rooms**
   - Public, institution-scoped, and private rooms.
   - Verified-membership enforcement for institution rooms.
   - Room membership, owner membership, visibility filtering, pagination, and subject filtering.
   - Candidate room discovery is bounded before in-memory visibility filtering to prevent unbounded reads.
    - Discussion posts, threaded comments, room resources, links, and managed object-storage uploads.
    - Post and threaded-comment reads are scoped to active room membership; restricted accounts cannot create collaboration content or team progress.
   - Post owners and room moderators can durably accept or clear a visible comment as the accepted answer, with authorization and audit coverage.
   - Room members can transactionally set, change, or remove one durable reaction per discussion post.

4. **Challenge collaboration**
   - Global and room-scoped challenges with tags, difficulty, and status.
   - Candidate challenge discovery is bounded before in-memory visibility filtering.
   - Teams, members, milestones, due dates, progress updates, and team invitations.
   - Authorized team-member listing, role/status updates, and owner-authorized milestone editing with audit events.
   - Team invite tokens are hashed, expiring, invitee-bound, and accepted transactionally.
   - Server-owned reputation reads are authenticated, and accepted-answer transitions award/revoke bounded reputation points transactionally.

5. **Realtime and sessions**
   - Durable room chat, direct/group messaging, persisted conversation read receipts, presence, room-post streams, chat streams, collaborative-document streams, and scheduled study sessions.
   - Important state is stored in PostgreSQL before realtime delivery.
   - Meeting links and uploaded URLs are scheme-validated.

6. **Source-grounded room AI boundary**
   - Room membership is required before AI access.
   - Answers require valid citations to active room resources and persist source IDs.
   - Missing AI configuration fails closed.
   - Plain-text and Markdown uploads persist bounded normalized source text for grounding while retaining the original managed file.
   - Text-backed room resources are split into persistent, ordered chunks with token counts and authorized paginated retrieval.
   - Authenticated room members can batch-index chunks through the configured embeddings provider; vectors are persisted with the source chunks and requests are rate-limited.
   - Text-backed room-resource creation automatically enqueues a durable `room_resource.index_embeddings` job for worker processing.
   - The default background-worker handler validates and executes queued room-resource embedding jobs, with provider failures flowing through retry/dead-letter state.
   - Room uploads extract bounded text from TXT/Markdown, PDF text operators, DOCX, PPTX, and XLSX archives before chunking; malformed or image-only files fail closed without indexing fabricated content.
   - PNG/JPEG/WEBP uploads enter a durable OCR workflow: the resource remains `processing` during retries, Google Vision text is bounded and validated, successful extraction creates chunks and schedules embeddings, and final provider failure marks the resource `failed`; OCR credentials resolve from `STUDIUM_OCR_API_KEY`.
   - Authenticated room members can run semantic knowledge searches ranked by cosine similarity over persisted vectors; inactive resources are excluded.
   - Knowledge ranking is executed in a parameterized PostgreSQL query, preserving room/status authorization scope and result ordering without loading all embeddings into application memory.
   - OpenAI embeddings are persisted in a pgvector side-table with a PostgreSQL HNSW cosine index; the generated Serverpod resource model remains JSON-compatible while native retrieval uses the indexed table.

7. **Trust and moderation**
   - Reports for posts, comments, files, profiles, challenges, and AI outputs.
   - Moderator authorization, remove/restrict/suspend/dismiss actions, and moderation logs.
   - Active restrictions prevent collaboration writes.
   - Institution invite creation/acceptance and scheduled study-session creation/participation are transactionally audited.
   - Append-only `AuditEvent` records cover membership reviews/role changes, opportunity reviews, and content-report resolution.
   - Moderation audit events for posts, comments, files, and challenges derive institution scope through their owning room inside the moderation transaction.
   - Institution-owned room, challenge, and challenge-team creation events are recorded with institution scope for administrative review.
   - Institution-linked academic-profile, room-membership, room-resource, team-membership, milestone, and challenge-progress transitions are also recorded with institution scope.
   - Institution-scoped audit retrieval is available to verified institution admins/moderators with pagination and membership-target fallback for legacy events.
   - Institution audit candidate memberships are bounded before event aggregation and pagination.
   - Institution verification-request candidate memberships are bounded before filtering pending requests.
   - Authenticated membership and verification-request history reads have defensive server-side caps.
   - Institution invite acceptance, membership-request creation, and verification-evidence submission append audit events in the same transaction as their state changes.
   - Discussion posts/comments, reactions, room chat messages, challenge-team invites, reports, moderation appeals, and collaborative-document create/update transitions append auditable events; state-changing report and appeal flows write the event in the same transaction.
   - Affected users can submit one scoped appeal per resolved action; platform moderators can approve/reject appeals, with approved appeals reversing removals or active restrictions.
    - Affected users receive durable in-app notifications when moderation reports or appeals are resolved; notification writes are part of the moderation transaction.
    - Platform moderators have a bounded, paginated pending-moderation-appeal queue before reviewing appeals.

8. **Opportunities**
   - Verified opportunity discovery with deadline, country, field, education-level, and type filters.
   - Moderated submissions, saves, alerts, and deadline-aware alert configuration.
   - Moderator-only paginated queue for discovering pending opportunity submissions before review.
   - Application tracker with validated status transitions, notes, URLs, upsert semantics, and pagination.
   - Opportunity submissions require bounded, non-empty HTTP(S) official source URLs with a valid host.
   - Moderator-managed verified provider sources with normalized, transactional ingestion, required field/type/deadline validation, provider matching, and source/external-ID deduplication.
   - Bounded official-feed synchronization with HTTP(S) source checks, JSON shape/size limits, and reuse of the same validated ingestion path.
   - Durable source refresh scheduling with atomic due-source claims, next-run timestamps, success/failure state, retry delay, stale-source marking, and last-seen tracking for imported opportunities.

9. **Billing and delivery foundations**
   - Subscription endpoints accept optional idempotency keys with durable processing/completed/failed state.
   - Signed Stripe and Paystack webhook handling deduplicates events and persists gateway event transactions under a unique gateway/event ID.
   - Webhook processing records durable failure details, handles refund/chargeback entitlement revocation, and extracts gateway amounts when supplied.
   - Successful signed callbacks activate subscriptions and premium profiles; failed, cancelled, full-refund, and chargeback callbacks transition subscription state and revoke entitlements.
   - Refund webhooks distinguish partial from full refunds, reject over-refunds, accumulate prior refund transactions, and revoke entitlements only after a full refund or chargeback.
   - Payment transactions retain normalized three-letter currency codes when gateways provide them.
   - Payment transactions preserve provider-reported settlement amount, settlement currency, exchange rate, and provenance; mismatched settlement values are rejected.
   - Durable notifications and push-device registration.
   - Push delivery has a bounded ten-second provider timeout, invalid-device deactivation, and structured success/rejection/failure telemetry; in-app notifications remain authoritative.
   - Push deliveries are persisted before provider dispatch with claim locks, bounded retries, stale-lock recovery, and dead-letter state; in-app notifications remain authoritative when delivery is unavailable.
   - Validation and password-reset emails are persisted before delivery, support deduplication, claim locks, bounded retries, stale-lock recovery, and dead-letter state, while successful SMTP delivery is recorded.
   - Background study-material processing and managed object storage integration.
   - Durable processing attempts with a three-attempt limit, final-attempt dead-letter transition, and authenticated owner-only requeue.
    - Durable background-job records with transactional claim locks, stale-lock recovery, retry backoff, completion, and dead-letter transitions; study-material processing is wired through this queue boundary.
    - Reusable bounded worker passes recover stale jobs, claim due work, dispatch registered handlers, and persist completion or retry/dead-letter outcomes; opportunity refresh jobs now execute through a worker-safe feed refresh service with transactional upserts, stale-record reconciliation, and tested failure-state handling.
    - Moderator-triggered opportunity source synchronization delegates to the same worker-safe refresh service, keeping scheduled and manual refresh validation and failure handling aligned.
   - A standalone `bin/worker.dart` process runs Serverpod in maintenance mode, schedules due opportunity refresh jobs, executes bounded worker passes, emits pass telemetry, and shuts down gracefully on process signals without opening an API listener.
   - The worker supports a bounded `STUDIUM_WORKER_ONCE=true` mode for Cloud Run Jobs; the GCP deployment workflow can deploy the API, Insights, worker job, and an authenticated Cloud Scheduler trigger from repository variables/secrets.
   - GCP deployment requirements and secret-handling expectations are documented in `deploy/gcp/README.md`; deployment is opt-in through `GCP_DEPLOY_ENABLED`.
   - The production Docker image copies only public configuration; GCP injects base64-encoded `passwords.yaml` from Secret Manager at container startup, preventing credentials from being baked into the image layers.

10. **User safety controls**
    - Persistent block, mute, and restrict relationships with authenticated management and pagination; block/restrict relationships are enforced for direct messaging.
    - Blocked users cannot create a conversation together or send messages in an existing conversation.
    - Persisted age-aware privacy settings are readable and writable only for the authenticated account; minor mode forcibly disables unknown direct messages and is enforced when conversations are created.

11. **Abuse protection**
   - PostgreSQL-backed, cross-instance rate-limit buckets protect room/challenge creation, room AI, reports, conversation creation, messages, and opportunity submissions.

12. **Structured operational telemetry**
   - Queue claim, completion, retry/dead-letter, and billing webhook outcomes emit JSON-safe structured events for deployment log/trace collectors without including secrets or full payment payloads.
   - Due opportunity sources are claimed with PostgreSQL row locks and `SKIP LOCKED`; repeated claims do not return a source already scheduled by another worker pass.
   - Platform admins can retrieve aggregate background-job, email-delivery, and push-delivery health counts without exposing payloads or credentials.
   - Platform admins can retrieve scheduler health counts for verified, due, failed, stale, never-synced, pending-refresh, and dead-letter source work.
   - The telemetry encoder recursively redacts credential-like fields (keys, tokens, signatures, authorization, passwords, and secrets) before JSON serialization, with deterministic unit coverage for nested provider metadata.

13. **Deployment secret configuration**
   - Payment API keys, webhook signing secrets, OpenAI/FCM credentials, and SMTP passwords resolve from explicit `STUDIUM_*` environment variables when configured Serverpod secrets are absent or placeholders; both `openAi` and legacy `openAI` callers map consistently.
   - Placeholder secrets are rejected at use time, and the checked-in password example remains non-production configuration; CI injects a dedicated test-only webhook secret.
   - GCP deployment project/region/zone values are repository-variable driven and fail fast when the project identifier is missing or still a placeholder.
    - Docker Compose Redis health checks consume the same environment-injected passwords as their Redis services.
   - GitHub Actions CI runs the generated-client package smoke test; backend CI provisions pgvector PostgreSQL, regenerates and verifies Serverpod bindings, compiles the standalone worker, validates the Cloud Run deployment script, runs static analysis, and executes the collaboration plus legacy endpoint authorization suites with dedicated test webhook secrets.
   - `deploy/gcp/configure-observability.sh` creates or updates log-based dead-letter/refresh-failure metrics, alert policies, and a backend operations dashboard using an explicit Monitoring notification channel.

## Remaining backend work before frontend handoff

One backend workstream remains in the current development scope; completed slices are recorded above and are not counted here. Production rollout and live observability tuning are intentionally deferred until deployment planning resumes.

### Local test configuration

The signed webhook fixtures use test-only environment secrets. Set them in the
same shell before running the integration suite; without them the endpoint must
reject the webhook as invalid:

```powershell
$env:STUDIUM_STRIPE_WEBHOOK_SECRET = 'studium-test-webhook-secret'
$env:STUDIUM_PAYSTACK_WEBHOOK_SECRET = 'studium-test-paystack-webhook-secret'
dart test --concurrency=1
```

1. Expand endpoint tests to the full generated API execution surface. Coverage includes institution submission/review/provisioning, review queues, accepted answers, reactions, source refresh failures, queue claim/dead-letter behavior, resource chunks, provider sources, database-side knowledge ranking, native vector persistence/indexing, OCR failure handling, signed Stripe and Paystack webhook state transitions, settlement persistence, duplicate-event idempotency, billing refund behavior, bounded legacy reads, audit transitions, moderation-appeal queue behavior, legacy endpoint authentication boundaries, room/resource pagination boundaries, explicit room-membership reads, opportunity filter matching and pagination, private-room AI access control, grounded AI citation persistence and invalid-citation rejection, authenticated text-resource upload/extraction/chunk persistence, authorization failures, and generated-client surface smoke coverage; broader provider/file-processing and successful execution coverage for every generated endpoint remain.

## Verification command

From `studium_server`:

```text
dart test test/integration/collaboration_endpoint_test.dart
dart test test/unit/backend_telemetry_test.dart
dart analyze .
dart compile exe bin/worker.dart -o .dart_tool/studium_worker_validation.exe
bash -n deploy/gcp/deploy-cloud-run.sh
```

Gateway-signature integration tests require the documented test-only
`STUDIUM_STRIPE_WEBHOOK_SECRET` and `STUDIUM_PAYSTACK_WEBHOOK_SECRET`
environment variables when local `passwords.yaml` does not provide them.
