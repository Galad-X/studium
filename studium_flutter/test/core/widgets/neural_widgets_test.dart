import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_flutter/core/widgets/neural_widgets.dart';
import 'package:studium_flutter/core/widgets/async_value_view.dart';
import 'package:studium_flutter/core/widgets/report_content_dialog.dart';
import 'package:studium_flutter/features/collaboration/widgets/collaboration_cards.dart';
import 'package:studium_flutter/features/collaboration/widgets/grounded_answer_card.dart';
import 'package:studium_flutter/features/collaboration/widgets/room_presence_card.dart';
import 'package:studium_client/studium_client.dart';

void main() {
  testWidgets('NeuralErrorState renders message and retries', (tester) async {
    var retried = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NeuralErrorState(
            message: 'Network unavailable',
            onRetry: () => retried = true,
          ),
        ),
      ),
    );

    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Network unavailable'), findsOneWidget);
    await tester.tap(find.text('Try again'));
    expect(retried, isTrue);
  });

  testWidgets('NeuralCard invokes its tap callback', (tester) async {
    var tapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NeuralCard(
            onTap: () => tapped = true,
            child: const Text('Shared card'),
          ),
        ),
      ),
    );

    expect(find.text('Shared card'), findsOneWidget);
    await tester.tap(find.text('Shared card'));
    expect(tapped, isTrue);
  });

  testWidgets('AsyncValueView renders empty, error, and data states',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: AsyncValueView<List<String>>(
        value: const AsyncValue.data([]),
        onRetry: () {},
        emptyMessage: 'Nothing here',
        builder: (items) => items.isEmpty
            ? const EmptyListMessage('Nothing here')
            : Text(items.join(', ')),
      ),
    ));
    expect(find.text('Nothing here'), findsOneWidget);

    await tester.pumpWidget(MaterialApp(
      home: AsyncValueView<String>(
        value: AsyncValue.error('Offline', StackTrace.current),
        onRetry: () {},
        emptyMessage: 'Unused',
        builder: Text.new,
      ),
    ));
    expect(find.text('Something went wrong'), findsOneWidget);
    expect(find.text('Offline'), findsOneWidget);
  });

  testWidgets('ReportContentDialog submits the selected reason',
      (tester) async {
    String? submittedReason;
    String? submittedDetails;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ReportContentDialog(
            onSubmit: (reason, details) async {
              submittedReason = reason;
              submittedDetails = details;
            },
          ),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Not relevant');
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();

    expect(submittedReason, 'spam');
    expect(submittedDetails, 'Not relevant');
  });

  testWidgets('StudyRoomCard renders metadata and invokes its callback',
      (tester) async {
    var tapped = false;
    final room = StudyRoom(
      id: 1,
      ownerId: 7,
      title: 'Algorithms room',
      description: 'Compare approaches with peers.',
      subject: 'Computer science',
      visibility: 'public',
      membershipPolicy: 'open',
      status: 'active',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: StudyRoomCard(room: room, onTap: () => tapped = true),
      ),
    ));

    expect(find.text('Algorithms room'), findsOneWidget);
    expect(find.text('Compare approaches with peers.'), findsOneWidget);
    await tester.tap(find.text('Algorithms room'));
    expect(tapped, isTrue);
  });

  testWidgets('ChallengeCard and ChallengeTeamCard expose actions',
      (tester) async {
    var challengeTapped = false;
    var teamTapped = false;
    var joined = false;
    final challenge = Challenge(
      id: 2,
      ownerId: 7,
      title: 'Open data challenge',
      problemStatement: 'Find a reproducible data pipeline.',
      field: 'Engineering',
      tags: const ['data'],
      difficulty: 'intermediate',
      status: 'open',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );
    final team = ChallengeTeam(
      id: 3,
      challengeId: 2,
      ownerId: 7,
      name: 'Data explorers',
      description: 'Build the baseline together.',
      status: 'active',
      createdAt: DateTime(2026),
      updatedAt: DateTime(2026),
    );

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Column(children: [
          ChallengeCard(
            challenge: challenge,
            onTap: () => challengeTapped = true,
          ),
          ChallengeTeamCard(
            team: team,
            onJoin: () => joined = true,
            onTap: () => teamTapped = true,
          ),
        ]),
      ),
    ));

    await tester.tap(find.text('Open data challenge'));
    await tester.tap(find.text('Data explorers'));
    await tester.tap(find.text('Join'));
    expect(challengeTapped, isTrue);
    expect(teamTapped, isTrue);
    expect(joined, isTrue);
  });

  testWidgets('RoomPresenceCard renders active and total presence',
      (tester) async {
    final now = DateTime(2026);
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RoomPresenceCard(presence: [
          CollaborationPresence(
            userId: 1,
            scopeType: 'room',
            scopeId: 4,
            state: 'online',
            lastSeenAt: now,
          ),
          CollaborationPresence(
            userId: 2,
            scopeType: 'room',
            scopeId: 4,
            state: 'away',
            lastSeenAt: now,
          ),
        ]),
      ),
    ));

    expect(find.text('1 active now'), findsOneWidget);
    expect(find.text('2 present'), findsOneWidget);
  });

  testWidgets('GroundedAnswerCard discloses confidence and citations',
      (tester) async {
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GroundedAnswerCard(
          answer: 'A source-grounded answer.',
          confidence: 'high',
          citations: const ['Shared paper, page 2'],
        ),
      ),
    ));

    expect(find.text('AI-assisted answer • high'), findsOneWidget);
    expect(find.text('[1] Shared paper, page 2'), findsOneWidget);
  });
}
