import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../providers/collaboration_provider.dart';
import '../widgets/collaboration_cards.dart';
import 'team_workspace_screen.dart';

class ChallengeDetailScreen extends ConsumerStatefulWidget {
  final int challengeId;
  final Challenge? challenge;

  const ChallengeDetailScreen(
      {required this.challengeId, this.challenge, super.key});

  @override
  ConsumerState<ChallengeDetailScreen> createState() =>
      _ChallengeDetailScreenState();
}

class _ChallengeDetailScreenState extends ConsumerState<ChallengeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final challenge = widget.challenge;
    final teams = ref.watch(challengeTeamsProvider(widget.challengeId));
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(title: const Text('Challenge collaboration')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          NeuralSectionHeader(
            title: challenge?.title ?? 'Challenge',
            subtitle: challenge == null
                ? 'Build a team and work toward a solution.'
                : '${challenge.field} • ${challenge.difficulty}',
            icon: Icons.lightbulb_outline,
          ),
          if (challenge != null) ...[
            const SizedBox(height: 16),
            NeuralCard(
              child: Text(
                challenge.problemStatement,
                style: const TextStyle(color: Colors.white, height: 1.45),
              ),
            ),
          ],
          const SizedBox(height: 24),
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Teams',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              FilledButton.icon(
                onPressed: _showCreateTeamDialog,
                icon: const Icon(Icons.group_add),
                label: const Text('Form team'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AsyncValueView<List<ChallengeTeam>>(
            value: teams,
            onRetry: () => ref.invalidate(
              challengeTeamsProvider(widget.challengeId),
            ),
            emptyMessage: 'No teams yet. Start the first one.',
            builder: (teams) {
              if (teams.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 28),
                  child: EmptyListMessage('No teams yet. Start the first one.'),
                );
              }
              return Column(
                children: teams
                    .map((team) => ChallengeTeamCard(
                          team: team,
                          onJoin: () => _joinTeam(team),
                          onTap: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => TeamWorkspaceScreen(team: team),
                            ),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _joinTeam(ChallengeTeam team) async {
    try {
      await ref.read(collaborationServiceProvider).joinChallengeTeam(team.id!);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You joined the team.')),
      );
      ref.invalidate(challengeTeamsProvider(widget.challengeId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  Future<void> _showCreateTeamDialog() async {
    final name = TextEditingController();
    final description = TextEditingController();
    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Form a challenge team'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(labelText: 'Team name'),
            ),
            TextField(
              controller: description,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Create'),
          ),
        ],
      ),
    );
    if (created != true || !mounted) return;
    try {
      await ref.read(collaborationServiceProvider).createChallengeTeam(
            widget.challengeId,
            name.text,
            description.text,
          );
      if (mounted) {
        ref.invalidate(challengeTeamsProvider(widget.challengeId));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      name.dispose();
      description.dispose();
    }
  }
}
