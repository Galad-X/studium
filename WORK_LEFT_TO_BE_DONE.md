# Studium — Work Left to Be Done

Last updated: 2026-08-30

This is the handoff checklist for continuing the Studium Global Collaboration
Platform. It records the current state honestly: the first collaboration slice
is substantially implemented, but final verification and several production
capabilities remain outstanding.

## Current state

Implemented foundations include:

- Flutter + Riverpod client and Serverpod + PostgreSQL backend.
- Authenticated institution discovery, memberships, verification requests,
  invites, academic profiles, and institution administration.
- Public, institution, and private study rooms with membership authorization.
- Room feeds, threaded comments, accepted answers, reactions, resources,
  managed uploads, room chat, presence, sessions, and collaborative documents.
- Challenge discovery, teams, invitations, milestones, and progress updates.
- Room-grounded AI with persisted resources, chunks, embeddings, semantic search,
  citations, provenance, and access checks.
- Moderation reports, appeals, audit events, restrictions, blocks, mutes, and
  direct-message safety enforcement.
- Verified opportunities, saves, alerts, applications, provider sources, and
  scheduled refresh jobs.
- Subscription/webhook foundations, durable jobs, email/push delivery queues,
  worker process, and deployment configuration documentation.
- Flutter collaboration screens, reusable widgets, responsive layouts,
  pagination state, room cache boundaries, AI flows, moderation feedback,
  privacy controls, reputation presentation, and history/profile/settings
  actions.
- Server-owned age-aware privacy settings and server-owned reputation records.
  Accepted-answer transitions award or revoke reputation transactionally.
- Conversation read positions are persisted per authenticated member and exposed
  through generated Serverpod bindings and the Flutter collaboration service.

## Immediate verification

Run these from the indicated project directories:

### Flutter

```powershell
cd D:\Dell\studium\studium_flutter
dart format .
dart analyze .
flutter test
```

### Server

```powershell
cd D:\Dell\studium\studium_server
$env:STUDIUM_STRIPE_WEBHOOK_SECRET = 'studium-test-webhook-secret'
$env:STUDIUM_PAYSTACK_WEBHOOK_SECRET = 'studium-test-paystack-webhook-secret'
dart analyze .
dart test --concurrency=1
dart compile exe bin/worker.dart -o .dart_tool\studium_worker_validation.exe
```

The full gates have not been confirmed after the latest generated protocol,
privacy, reputation, history, profile, and settings changes.

## Backend work remaining

- [ ] Run and resolve the full Serverpod analyzer/test gates.
- [ ] Expand integration execution coverage to every generated endpoint, not
      only authorization and selected collaboration paths.
- [ ] Add successful-path tests for all institution, room, challenge, resource,
      messaging, opportunity, moderation, notification, billing, and worker
      operations.
- [x] Add integration coverage for reputation award/revocation on accepted
      discussion answers.
- [x] Add privacy-enforcement coverage for new, existing, and group conversations.
- [ ] Verify all migrations against a clean PostgreSQL database and an upgrade
      database containing existing data.
- [ ] Verify background-worker retry, stale-lock, dead-letter, and shutdown
      behavior in an integration environment.
- [ ] Verify payment duplicate events, partial/full refunds, cancellation,
      failed payments, reconciliation, and idempotency against gateway fixtures.
- [ ] Finish provider/file-processing success and failure coverage, including
      OCR, office archives, embeddings, object storage, and malformed files.
- [ ] Add operational review for rate limits, pagination caps, database indexes,
      audit retention, and personal-data deletion/export requirements.

## Flutter work remaining

- [ ] Integrate a real platform push-token provider (FCM/APNs), permission flow,
      token refresh, registration, unregister, and notification deep links.
- [ ] Connect typing, presence, and push preference controllers to durable
      backend event/state boundaries where required. Conversation read positions
      are now persisted.
- [ ] Persist collaborative whiteboard state and add conflict resolution.
- [ ] Extend offline cache boundaries to messages, resources, challenges,
      opportunities, and saved items; add invalidation and stale-data indicators.
- [ ] Replace local-only privacy assumptions with verified age/guardian policy
      where the product and legal requirements require it.
- [ ] Add institution/member profile reputation loading wherever other users are
      displayed, not only the current-user profile.
- [ ] Add widget/controller tests for settings, profile help/feedback, writing
      export/sorting, analytics export, moderation feedback, privacy controls,
      reputation presentation, and generated-protocol changes.
- [ ] Verify mobile, tablet, web, loading, empty, retry, offline, and
      permission-denied states across collaboration screens.
- [ ] Resolve any remaining analyzer diagnostics after the latest edits.

## Product capabilities still to design or harden

- [ ] Institution onboarding and support playbook for the 3–5 institution pilot.
- [ ] Human moderation staffing, escalation, appeals, abuse response, and minor
      protection policy.
- [ ] Opportunity-source partner verification and editorial review process.
- [ ] AI safety review, source-quality policy, hallucination reporting, and
      disclosure UX.
- [ ] Analytics definitions and pilot dashboards for engagement and learning
      outcomes.
- [ ] Freemium limits, institution billing entitlements, refunds, and support
      operations with real gateway accounts.
- [ ] Data protection, retention, deletion, export, consent, and jurisdictional
      compliance review for the international launch.

## Recommended next session order

1. Run Flutter `dart analyze .` and fix only the reported diagnostics.
2. Run the focused new privacy/reputation tests and the collaboration endpoint
   tests with the documented webhook secrets.
3. Verify the new migrations on a clean database and inspect generated bindings.
4. Finish push-token delivery and notification UX.
5. Complete endpoint execution coverage and worker/payment failure coverage.
6. Perform the pilot acceptance flow end to end.
7. Only then revise this document and decide whether the platform is ready for
   pilot onboarding.

## Important constraints

- Do not mark the project production-ready based on source inspection alone.
- Do not enable production billing, opportunity ingestion, or global rollout
  until gateway, moderation, privacy, and migration verification is complete.
- Keep `SERVERPOD_URL`, payment keys, webhook secrets, AI credentials, storage
  credentials, and email credentials outside source control and inject them per
  environment.
- The final completion claim requires green analyzer/tests and a verified pilot
  workflow; this handoff document is not that completion claim.
