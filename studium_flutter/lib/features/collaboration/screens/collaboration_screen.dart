import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../../../core/widgets/async_value_view.dart';
import '../providers/collaboration_provider.dart';
import '../widgets/collaboration_cards.dart';

class CollaborationScreen extends ConsumerStatefulWidget {
  const CollaborationScreen({super.key});

  @override
  ConsumerState<CollaborationScreen> createState() =>
      _CollaborationScreenState();
}

class _CollaborationScreenState extends ConsumerState<CollaborationScreen> {
  int _tab = 0;
  final _subjectController = TextEditingController();
  final _challengeFieldController = TextEditingController();
  final _challengeLanguageController = TextEditingController();
  String? _subjectFilter;
  String? _challengeDifficulty;
  String? _challengeStatus;

  @override
  void dispose() {
    _subjectController.dispose();
    _challengeFieldController.dispose();
    _challengeLanguageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rooms = ref.watch(studyRoomsProvider(_subjectFilter));
    final challenges = ref.watch(challengesProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        title: const Text('Study Communities'),
        actions: [
          IconButton(
            tooltip: 'Institutions',
            onPressed: () => context.push('/collaboration/institutions'),
            icon: const Icon(Icons.account_balance_outlined),
          ),
          IconButton(
            tooltip: 'Scholarships',
            onPressed: () => context.push('/opportunities'),
            icon: const Icon(Icons.school_outlined),
          ),
          IconButton(
            tooltip: 'Conversations',
            onPressed: () => context.push('/collaboration/conversations'),
            icon: const Icon(Icons.chat_bubble_outline),
          ),
          IconButton(
            tooltip: 'Refresh',
            onPressed: () {
              ref.invalidate(studyRoomsProvider(_subjectFilter));
              ref.invalidate(challengesProvider);
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 768;
          final horizontalPadding = isWide ? 28.0 : 12.0;
          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1440),
              child: Padding(
                padding: EdgeInsets.all(horizontalPadding),
                child: Column(
                  children: [
                    NeuralSectionHeader(
                      title: 'Collaborate beyond your campus',
                      subtitle:
                          'Find study rooms and solve difficult problems together.',
                      icon: Icons.groups_rounded,
                      trailing: FilledButton.icon(
                        onPressed: () => _showCreateDialog(context),
                        icon: const Icon(Icons.add),
                        label: const Text('Create'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _subjectController,
                      textInputAction: TextInputAction.search,
                      onSubmitted: (_) => setState(() {
                        final value = _subjectController.text.trim();
                        _subjectFilter = value.isEmpty ? null : value;
                      }),
                      decoration: InputDecoration(
                        labelText: 'Filter rooms by subject',
                        prefixIcon: const Icon(Icons.filter_list),
                        suffixIcon: _subjectFilter == null
                            ? null
                            : IconButton(
                                tooltip: 'Clear filter',
                                onPressed: () {
                                  _subjectController.clear();
                                  setState(() => _subjectFilter = null);
                                },
                                icon: const Icon(Icons.clear),
                              ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    _CollaborationTabSelector(
                      selectedIndex: _tab,
                      onChanged: (index) => setState(() => _tab = index),
                    ),
                    if (_tab == 1) ...[
                      const SizedBox(height: 12),
                      Flex(
                        direction: isWide ? Axis.horizontal : Axis.vertical,
                        crossAxisAlignment: isWide
                            ? CrossAxisAlignment.start
                            : CrossAxisAlignment.stretch,
                        children: [
                          if (isWide)
                            Expanded(child: _challengeFieldInput())
                          else
                            _challengeFieldInput(),
                          if (isWide)
                            const SizedBox(width: 8)
                          else
                            const SizedBox(height: 8),
                          if (isWide)
                            Expanded(child: _challengeLanguageInput())
                          else
                            _challengeLanguageInput(),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          for (final value in [
                            'beginner',
                            'intermediate',
                            'advanced',
                          ])
                            FilterChip(
                              label: Text(value),
                              selected: _challengeDifficulty == value,
                              onSelected: (selected) => setState(() {
                                _challengeDifficulty = selected ? value : null;
                              }),
                            ),
                          for (final value in [
                            'open',
                            'forming-team',
                            'active',
                            'solved',
                          ])
                            FilterChip(
                              label: Text(value),
                              selected: _challengeStatus == value,
                              onSelected: (selected) => setState(() {
                                _challengeStatus = selected ? value : null;
                              }),
                            ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 16),
                    Expanded(
                      child: IndexedStack(
                        index: _tab,
                        children: [
                          _RoomsList(
                            key: const ValueKey('collaboration-rooms'),
                            state: rooms,
                            onRetry: () => ref
                                .invalidate(studyRoomsProvider(_subjectFilter)),
                          ),
                          _ChallengesList(
                            key: const ValueKey('collaboration-challenges'),
                            state: challenges,
                            field: _challengeFieldController.text,
                            language: _challengeLanguageController.text,
                            difficulty: _challengeDifficulty,
                            status: _challengeStatus,
                            onRetry: () => ref.invalidate(challengesProvider),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _challengeFieldInput() => TextField(
        controller: _challengeFieldController,
        decoration: const InputDecoration(labelText: 'Field'),
        onChanged: (_) => setState(() {}),
      );

  Widget _challengeLanguageInput() => TextField(
        controller: _challengeLanguageController,
        decoration: const InputDecoration(labelText: 'Language tag'),
        onChanged: (_) => setState(() {}),
      );

  Future<void> _showCreateDialog(BuildContext context) async {
    final title = TextEditingController();
    final description = TextEditingController();
    final field = TextEditingController();
    final isChallenge = _tab == 1;
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isChallenge ? 'Post a challenge' : 'Create a study room'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
                controller: title,
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
                controller: description,
                maxLines: 4,
                decoration: InputDecoration(
                    labelText:
                        isChallenge ? 'Problem statement' : 'Description')),
            if (isChallenge)
              TextField(
                  controller: field,
                  decoration: const InputDecoration(labelText: 'Field')),
          ]),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Publish')),
        ],
      ),
    );
    if (result != true || !mounted) return;
    try {
      final service = ref.read(collaborationServiceProvider);
      if (isChallenge) {
        await service.createChallenge(
            title: title.text,
            problemStatement: description.text,
            field: field.text);
        ref.invalidate(challengesProvider);
      } else {
        await service.createRoom(
            title: title.text, description: description.text);
        ref.invalidate(studyRoomsProvider(_subjectFilter));
      }
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}

class _RoomsList extends StatelessWidget {
  final AsyncValue<List<StudyRoom>> state;
  final VoidCallback onRetry;
  const _RoomsList({required this.state, required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) => AsyncValueView<List<StudyRoom>>(
        value: state,
        onRetry: onRetry,
        emptyMessage: 'No study rooms yet. Create the first one.',
        builder: (items) => items.isEmpty
            ? const EmptyListMessage(
                'No study rooms yet. Create the first one.')
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, index) {
                  final room = items[index];
                  return StudyRoomCard(
                    room: room,
                    onTap: () =>
                        context.push('/collaboration/rooms/${room.id}'),
                  );
                },
              ),
      );
}

class _CollaborationTabSelector extends StatelessWidget {
  const _CollaborationTabSelector({
    required this.selectedIndex,
    required this.onChanged,
  });

  final int selectedIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: _TabChoice(
              key: const ValueKey('collaboration-rooms-tab'),
              icon: Icons.school,
              label: 'Study rooms',
              selected: selectedIndex == 0,
              onTap: () => onChanged(0),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: _TabChoice(
              key: const ValueKey('collaboration-challenges-tab'),
              icon: Icons.lightbulb_outline,
              label: 'Challenges',
              selected: selectedIndex == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      );
}

class _TabChoice extends StatelessWidget {
  const _TabChoice({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
        button: true,
        selected: selected,
        label: label,
        child: OutlinedButton.icon(
          onPressed: onTap,
          icon: Icon(icon),
          label: Text(label),
          style: OutlinedButton.styleFrom(
            backgroundColor: selected
                ? Theme.of(context).colorScheme.primary.withAlpha(35)
                : Colors.transparent,
            side: BorderSide(
              color: selected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.white24,
            ),
          ),
        ),
      );
}

class _ChallengesList extends StatelessWidget {
  final AsyncValue<List<Challenge>> state;
  final String field;
  final String language;
  final String? difficulty;
  final String? status;
  final VoidCallback onRetry;
  const _ChallengesList({
    required this.state,
    required this.field,
    required this.language,
    required this.difficulty,
    required this.status,
    required this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) => AsyncValueView<List<Challenge>>(
        value: state,
        onRetry: onRetry,
        emptyMessage: 'No challenges yet.',
        builder: (items) {
          final filtered = items.where((challenge) {
            final fieldMatches = field.trim().isEmpty ||
                challenge.field
                    .toLowerCase()
                    .contains(field.trim().toLowerCase());
            final languageMatches = language.trim().isEmpty ||
                challenge.tags.any((tag) =>
                    tag.toLowerCase() == language.trim().toLowerCase());
            return fieldMatches &&
                languageMatches &&
                (difficulty == null || challenge.difficulty == difficulty) &&
                (status == null || challenge.status == status);
          }).toList();
          return filtered.isEmpty
              ? const EmptyListMessage('No challenges match the filters.')
              : ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (_, index) {
                    final challenge = filtered[index];
                    return ChallengeCard(
                      challenge: challenge,
                      onTap: () => context.push(
                        '/collaboration/challenges/${challenge.id}',
                        extra: challenge,
                      ),
                    );
                  },
                );
        },
      );
}
