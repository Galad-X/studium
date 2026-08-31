# Studium frontend capability plan

This is the frontend handoff checklist for the global collaboration platform.
Deployment and production rollout are intentionally out of scope for the current
frontend implementation pass.

## 1. Foundation and reusable UI

- [x] Keep API access behind injectable Riverpod services.
- [x] Add reusable neural cards for rooms, challenges, and teams.
- [x] Add reusable async loading, error, retry, and empty-state rendering.
- [x] Add reusable report-content dialog.
- [x] Add widget tests for reusable cards and async states.
- [x] Add provider tests for institution, room, challenge-team, and team-workspace data.
- [x] Resolve identified analyzer infos in history, routing, and theme code (local analyzer confirmation remains pending because the scoped analyzer process hung).
- [x] Add shared pagination and refresh controllers.
- [x] Add offline cache boundaries for rooms, messages, resources, challenges,
      and opportunities with stale-data expiry and read-through fallback.
- [x] Persist room whiteboard state with optimistic conflict detection and
      restore it when entering a room.
- [x] Add focused typing/whiteboard controller transition coverage.
- [x] Add guardian-consent confirmation before enabling minor safety mode;
      server-side consent timestamps are persisted.
- [x] Add regression coverage for pagination refresh/retry and age-aware privacy transitions.
- [x] Replace settings-screen notification, privacy, export, policy, terms, and support placeholders with persisted controls and real actions.
- [x] Replace profile help/feedback, writing sort/export, and analytics export placeholders with working actions.

## 2. Verified academic identity

- [x] Institution search and result rendering.
- [x] Membership status rendering and retry states.
- [x] Institution-email and manual membership request flows.
- [x] Invite redemption and verification evidence submission.
- [x] Academic profile editing.
- [x] Moderator membership review UI.
- [x] Provider tests for institution search and current memberships.
- [x] Provider tests for rooms, teams, comments, conversations, appeals, and applications.
- [x] Add institution discovery filters for country and region.
- [x] Add institution filters for country, region, subject/programme, and language, backed by institution metadata.
- [x] Add invitation creation/management and membership-access removal/restoration UI.

## 3. Study rooms and discussion

- [x] Room and challenge discovery tabs.
- [x] Room detail feed and realtime post invalidation.
- [x] Riverpod providers for room posts, resources, chat, presence, sessions, and documents.
- [x] Threaded comments and accepted-answer/reaction presentation hooks.
- [x] Link and file resource sharing.
- [x] Source citations and “Ask this room” presentation.
- [x] Room chat screen with realtime message invalidation.
- [x] Direct/group conversation list and realtime chat screen.
- [x] Block/mute relationship service, provider, and management screen.
- [x] Room presence summary presentation.
- [x] Resource preview, citation display, and official-source link.
- [x] Scheduled study-session listing, creation, and joining.
- [x] Shared document listing, creation, and version-aware editing.
- [x] Move room, challenge-team, and team-workspace list loading to providers.
- [x] Move comment loading to providers.
- [x] Gate room collaboration actions on authoritative membership state.
- [x] Add explicit room membership state endpoint/provider.
- [x] Add resource pagination, filtering, and source previews.
- [x] Add scheduled study-session UI.

## 4. Challenges and teams

- [x] Challenge discovery and detail screen.
- [x] Team creation and joining.
- [x] Reusable team card.
- [x] Team milestones and progress updates.
- [x] Move team, milestone, and update loading to providers.
- [x] Add challenge filters by field, difficulty, status, and language tag.
- [x] Add team invitation, role, member-access, and milestone editing states.

## 5. Realtime collaboration

- [x] Room chat stream integration.
- [x] Room post stream integration.
- [x] Provider boundaries for room presence, study sessions, and collaborative documents.
- [x] Conversation service methods.
- [x] Conversation history and stream providers.
- [x] Presence service methods.
- [x] Add room presence summary widget.
- [x] Add room presence mutation controller.
- [x] Add typing controller.
- [x] Add read receipts and push-notification state controllers.
- [x] Persist conversation read positions through the authenticated messaging endpoint.
- [x] Add shared document editing flow.
- [x] Add collaborative whiteboard controller and room surface.
- [x] Add scheduled-session participation state.

## 6. Collaborative AI

- [x] Ask-room request and citation display.
- [x] Confidence display.
- [x] Reusable grounded-answer card with numbered sources and reporting action.
- [x] Shared knowledge-base source management UI.
- [x] Citation opening and provenance UI.
- [x] Study-guide and quiz generation flows.
- [x] Knowledge-gap and discussion-summary views.
- [x] AI source-access errors and response retry states.

## 7. Opportunities and scholarships

- [x] Opportunity listing and save service integration.
- [x] Saved-opportunity and alert service methods.
- [x] Basic opportunity filter UI for country and discipline.
- [x] Filter UI for education level, opportunity type, and deadline.
- [x] Saved opportunities screen.
- [x] Opportunity alert deactivation UI.
- [x] Application tracker listing and status updates.
- [x] Application tracker UI.
- [x] Verification badge and validated official-source presentation.

## 8. Trust, safety, and account state

- [x] Content-report dialog and service integration.
- [x] Report status and moderation feedback states.
- [x] Block and mute management UI.
- [x] Restrict and appeal initiation UI.
- [x] Age-aware privacy controls and direct-message restriction states backed by persisted server policy.
- [x] Server-backed reputation presentation, verified-contribution badge, and reusable reputation summary widget.
- [x] Load and present reputation for displayed collaboration members through
      authenticated Serverpod and Riverpod providers.
- [ ] Push notification delivery.
- [x] Notification center refresh, mark-one-read, and mark-all-read actions.
- [x] Notification deep links for room, challenge, and institution events.
- [x] Moderation appeal listing and notification deep link.

## 9. Billing and release quality

- [x] Existing subscription screens retained.
- [x] Stripe publishable-key configuration is environment-based and payment actions fail clearly when it is absent.
- [x] Integrate collaboration usage limits and premium feature gates (backend remains authoritative).
- [x] Add payment retry/cancellation UI states.
- [x] Add responsive mobile, tablet, and web layouts for collaboration screens.
- [x] Add pure route-access policy tests for authenticated, public, verified, and private room access.
- [x] Add pilot acceptance coverage for verified identity, room feed, challenge discovery, and rendered collaboration surfaces.
- [ ] Run the full Flutter format, analyze, and test gates after the latest generated-protocol batch (the scoped formatter process stalled; full-gate confirmation remains user-run).

## Current execution order

1. Connect typing/read-receipt/push controllers to backend delivery events.
2. Persist whiteboard state and add collaborative conflict resolution.
3. Integrate a real platform push-token provider and notification deep links.
4. Run the full Flutter format, analyze, and test gates after the generated-protocol batch.
