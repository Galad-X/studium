# Studium

Studium is a global academic collaboration platform for students, lecturers,
and institutions. It combines study assistance with verified academic identity,
course communities, research challenge teams, source-grounded AI, and curated
scholarship and opportunity discovery.

The product is designed to begin with a focused institutional pilot while
remaining ready for international collaboration across disciplines and regions.

## What it provides

- Verified institution memberships, academic profiles, invitations, and
  moderation roles.
- Public and institution-scoped study rooms with posts, comments, resources,
  chat, presence, sessions, and collaborative documents.
- Unsolved challenge boards, team formation, milestones, progress updates, and
  accepted peer answers.
- Shared knowledge sources, citations, AI study guides, quizzes, and room AI
  workflows with source provenance.
- Scholarships, fellowships, grants, competitions, internships, conferences,
  and exchanges with filters, saves, alerts, and application tracking.
- Safety tooling: reports, appeals, audit events, blocks, mutes, restrictions,
  age-aware direct-message privacy, and reputation signals.
- Freemium collaboration limits and subscription/payment lifecycle handling.

## Architecture

| Area | Technology |
| --- | --- |
| Client | Flutter, Riverpod, GoRouter |
| API | Serverpod 3.4, Dart |
| Database | PostgreSQL with pgvector |
| Realtime boundary | Serverpod streams, durable PostgreSQL state |
| Files and AI | Managed-object-storage boundary, OCR/extraction, embeddings, source-grounded retrieval |

The repository is organized as follows:

```text
studium_client/   Generated Serverpod client models and endpoint bindings
studium_flutter/  Flutter mobile, tablet, and web client
studium_server/   Serverpod endpoints, models, migrations, workers, and tests
```

## Local development

### Prerequisites

- Flutter 3.47.0 / Dart 3.13.0
- Serverpod CLI compatible with the project packages
- Docker Desktop for local PostgreSQL and Redis

### Start local services

```powershell
cd studium_server
docker compose up -d
```

Configure local secrets through untracked Serverpod password/config files or
environment variables. Never commit production API keys, webhook secrets, or
cloud credentials.

### Generate Serverpod bindings

```powershell
cd studium_server
serverpod generate
```

When schema models change, create and apply a migration in a disposable local
environment before using it elsewhere.

```powershell
serverpod create-migration --tag meaningful-change
```

### Run the applications

```powershell
# Terminal 1
cd studium_server
dart run bin/main.dart

# Terminal 2
cd studium_flutter
flutter run
```

## Verification

```powershell
# Flutter
cd studium_flutter
dart format .
flutter analyze
flutter test

# Serverpod
cd ../studium_server
dart analyze .
$env:STUDIUM_STRIPE_WEBHOOK_SECRET='studium-test-webhook-secret'
$env:STUDIUM_PAYSTACK_WEBHOOK_SECRET='studium-test-paystack-webhook-secret'
dart test --concurrency=1
```

Recent local verification completed with a clean Flutter analyzer, 30 Flutter
tests passing, a clean Serverpod analyzer, and 44 Serverpod tests passing.
Migration verification has also been completed against disposable clean and
upgrade PostgreSQL databases.

## Pilot readiness

The codebase is ready for a limited pilot of study rooms, challenges,
institution identity, shared knowledge, and opportunities. Before a production
launch, configure FCM/APNs credentials, verify notifications on physical
devices, complete legal/privacy policy decisions, and run usability validation
with pilot institutions.

## Project status

Implementation status and the remaining externally dependent work are tracked
in [WORK_LEFT_TO_BE_DONE.md](WORK_LEFT_TO_BE_DONE.md). Backend operational and
endpoint coverage details are documented in:

- [Backend operational review](studium_server/BACKEND_OPERATIONAL_REVIEW.md)
- [Backend endpoint coverage](studium_server/BACKEND_ENDPOINT_COVERAGE.md)
