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
- Flutter formatting was verified locally with Flutter 3.47.0 (`102 files, 0
  changed`). The analyzer did not complete because the Windows process hung;
  this is recorded as unverified rather than marked green.
- The full Flutter test gate was then verified with elevated execution: 24 tests
  passed.

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

- [x] Run and resolve the full Serverpod analyzer/test gates. Elevated
      verification completed: analyzer clean and 42 backend tests passed.
- [x] Expand integration execution coverage across every generated endpoint
      domain, including authenticated smoke reads and existing domain mutation
      workflows. Coverage is mapped in
      [BACKEND_ENDPOINT_COVERAGE.md](studium_server/BACKEND_ENDPOINT_COVERAGE.md).
- [x] Add successful-path tests for institution, room, challenge, resource,
      messaging, opportunity, moderation, notification, billing, and worker
      operations. Premium-only analytics/writing gates remain intentionally
      protected and are covered by authorization tests.
- [x] Add integration coverage for reputation award/revocation on accepted
      discussion answers.
- [x] Add privacy-enforcement coverage for new, existing, and group conversations.
- [x] Verify all migrations against disposable clean and upgrade PostgreSQL
      databases. All migrations applied successfully; upgrade preserved a
      pre-existing migration marker and created the latest whiteboard/privacy
      schema.
- [x] Add repository coverage for background-worker retry, stale-lock,
      dead-letter, and delivery recovery behavior. Shutdown still requires an
      integration-process run.
- [x] Add gateway-independent fixtures for duplicate payment events,
      partial/full refunds, cancellation, failed transitions, and idempotency.
      Gateway reconciliation still requires sandbox fixtures.
- [x] Add provider/file-processing coverage for OCR, office archives,
      embeddings, malformed files, and retry/dead-letter behavior. Real object
      storage success still requires provider credentials.
- [x] Add the operational review and explicit clean/upgrade migration runbook:
      [BACKEND_OPERATIONAL_REVIEW.md](studium_server/BACKEND_OPERATIONAL_REVIEW.md).

## Flutter work remaining

- [ ] Integrate a real platform push-token provider (FCM/APNs), permission flow,
      token refresh, registration, unregister, and notification deep links.
      The backend registration controller and in-app deep-link resolver are
      complete; Firebase/APNs credentials and platform project files are still
      required.
- [x] Connect presence and whiteboard state to authenticated durable backend
      boundaries. Whiteboards use optimistic version checks; typing remains a
      realtime transport concern until a server event channel is selected.
- [x] Extend offline cache boundaries to messages, resources, challenges, and
      opportunities with read-through fallback and expiry. Saved-item cache
      invalidation remains a separate enhancement.
- [x] Add server-owned date-of-birth and guardian-consent fields and enforce
      guardian consent before enabling minor mode. Legal age thresholds and
      formal guardian verification remain policy/integration work.
- [x] Add authenticated reputation loading and presentation for displayed team
      members. Broader profile surfaces can reuse the same provider and badge.
- [ ] Add widget/controller tests for settings, profile help/feedback, writing
      export/sorting, analytics export, moderation feedback, privacy controls,
      and generated-protocol changes. Focused cache and reputation provider
      coverage plus whiteboard/typing/push registration controller and
      notification deep-link coverage is now present.
- [x] Verify automated loading, empty, retry, offline fallback, and
      permission/route states across collaboration components. Physical-device
      and pilot usability review remain manual validation work.
- [x] Resolve analyzer diagnostics after the latest edits: Flutter analyzer is
      clean and all 30 Flutter tests pass.

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
