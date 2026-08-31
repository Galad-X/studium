# Backend endpoint coverage matrix

Verified against the generated Serverpod endpoint surface on 2026-08-31.

| Domain | Success-path coverage | Verification |
| --- | --- | --- |
| Institutions, memberships, profiles, rooms, challenges, teams | Authenticated collaboration workflow | `collaboration_endpoint_test.dart` |
| Resources, chunks, knowledge search, AI, posts, comments, reactions | Authenticated collaboration workflow plus resource fixtures | `collaboration_endpoint_test.dart` |
| Messaging, read receipts, privacy, safety, presence | Authenticated collaboration workflow | `collaboration_endpoint_test.dart` |
| Study sessions, documents, notifications | Authenticated collaboration workflow and smoke reads | `collaboration_endpoint_test.dart`, `endpoint_success_smoke_test.dart` |
| Opportunities, saves, alerts, application tracking | Authenticated collaboration workflow and smoke reads | `collaboration_endpoint_test.dart`, `endpoint_success_smoke_test.dart` |
| Billing webhooks, refunds, settlement, subscriptions | Signed webhook fixtures, refund unit behavior, subscription reads | `collaboration_endpoint_test.dart`, `endpoint_success_smoke_test.dart` |
| User profile, dashboard, summaries, study materials | Authenticated legacy smoke reads | `endpoint_success_smoke_test.dart`, `legacy_endpoint_authorization_test.dart` |
| Worker, email, push delivery, OCR, embeddings | Retry/dead-letter/stale-claim fixtures | `collaboration_endpoint_test.dart` |

The smoke suite intentionally does not bypass premium gates. Analytics and
academic-writing history require premium fixtures and are covered by their
authorization tests; they are not treated as free-user success paths.

The elevated verification run completed with no analyzer issues, 44 backend
tests passing, and 2 success-path smoke tests passing.
