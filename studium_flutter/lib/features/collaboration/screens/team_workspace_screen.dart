import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../providers/collaboration_provider.dart';
import '../widgets/reputation_badge.dart';

class TeamWorkspaceScreen extends ConsumerStatefulWidget {
  final ChallengeTeam team;

  const TeamWorkspaceScreen({required this.team, super.key});

  @override
  ConsumerState<TeamWorkspaceScreen> createState() =>
      _TeamWorkspaceScreenState();
}

class _TeamWorkspaceScreenState extends ConsumerState<TeamWorkspaceScreen> {
  @override
  Widget build(BuildContext context) {
    final milestones = ref.watch(teamMilestonesProvider(widget.team.id!));
    final updates = ref.watch(teamUpdatesProvider(widget.team.id!));
    final members = ref.watch(challengeTeamMembersProvider(widget.team.id!));

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(title: Text(widget.team.name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          NeuralSectionHeader(
            title: 'Team workspace',
            subtitle: widget.team.description ?? 'Challenge progress',
            icon: Icons.track_changes,
          ),
          const SizedBox(height: 20),
          _Section(
            title: 'Team members',
            action: FilledButton.icon(
              onPressed: _inviteMember,
              icon: const Icon(Icons.person_add_alt),
              label: const Text('Invite'),
            ),
            child: AsyncValueView<List<ChallengeTeamMember>>(
              value: members,
              onRetry: () => ref.invalidate(
                challengeTeamMembersProvider(widget.team.id!),
              ),
              emptyMessage: 'No team members yet.',
              builder: (values) => Column(
                children: values
                    .map((member) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.person_outline),
                          title: Text('User #${member.userId}'),
                          subtitle: Text('${member.role} • ${member.status}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Consumer(
                                builder: (context, ref, _) {
                                  final reputation = ref.watch(
                                    userReputationProvider(member.userId),
                                  );
                                  return reputation.maybeWhen(
                                    data: (value) => ReputationBadge(
                                      reputation: value,
                                    ),
                                    orElse: () => const SizedBox.shrink(),
                                  );
                                },
                              ),
                              PopupMenuButton<String>(
                                onSelected: (value) =>
                                    _updateMember(member, value),
                                itemBuilder: (_) => const [
                                  PopupMenuItem(
                                      value: 'lead', child: Text('Make lead')),
                                  PopupMenuItem(
                                      value: 'researcher',
                                      child: Text('Make researcher')),
                                  PopupMenuItem(
                                      value: 'member',
                                      child: Text('Make member')),
                                  PopupMenuItem(
                                      value: 'removed',
                                      child: Text('Remove access')),
                                ],
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'Milestones',
            action: FilledButton.icon(
              onPressed: _addMilestone,
              icon: const Icon(Icons.add),
              label: const Text('Add'),
            ),
            child: AsyncValueView<List<ChallengeMilestone>>(
              value: milestones,
              onRetry: () => ref.invalidate(
                teamMilestonesProvider(widget.team.id!),
              ),
              emptyMessage: 'No milestones yet.',
              builder: (values) {
                if (values.isEmpty) return const Text('No milestones yet.');
                return Column(
                  children: values
                      .map((item) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.flag_outlined),
                            title: Text(item.title),
                            subtitle: Text(item.status),
                            trailing: IconButton(
                              tooltip: 'Edit milestone',
                              onPressed: () => _editMilestone(item),
                              icon: const Icon(Icons.edit_outlined),
                            ),
                          ))
                      .toList(),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          _Section(
            title: 'Progress updates',
            action: FilledButton.icon(
              onPressed: _addUpdate,
              icon: const Icon(Icons.add_comment_outlined),
              label: const Text('Post update'),
            ),
            child: AsyncValueView<List<ChallengeProgressUpdate>>(
              value: updates,
              onRetry: () => ref.invalidate(
                teamUpdatesProvider(widget.team.id!),
              ),
              emptyMessage: 'No updates yet.',
              builder: (values) {
                if (values.isEmpty) return const Text('No updates yet.');
                return Column(
                  children: values
                      .map((item) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.update),
                            title: Text(item.body),
                            subtitle: Text(item.createdAt.toLocal().toString()),
                          ))
                      .toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addMilestone() async {
    final title = TextEditingController();
    final created =
        await _textDialog('Add milestone', 'Milestone title', title);
    if (!created || !mounted) {
      title.dispose();
      return;
    }
    try {
      await ref.read(collaborationServiceProvider).createMilestone(
            widget.team.id!,
            title.text,
            null,
            null,
          );
      ref.invalidate(teamMilestonesProvider(widget.team.id!));
    } catch (error) {
      _showError(error);
    } finally {
      title.dispose();
    }
  }

  Future<void> _editMilestone(ChallengeMilestone milestone) async {
    final title = TextEditingController(text: milestone.title);
    var status = milestone.status;
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('Edit milestone'),
          content: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            DropdownButtonFormField<String>(
              initialValue: status,
              items: const [
                DropdownMenuItem(value: 'open', child: Text('Open')),
                DropdownMenuItem(
                    value: 'in_progress', child: Text('In progress')),
                DropdownMenuItem(value: 'completed', child: Text('Completed')),
              ],
              onChanged: (value) =>
                  setDialogState(() => status = value ?? status),
              decoration: const InputDecoration(labelText: 'Status'),
            ),
          ]),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('Save')),
          ],
        ),
      ),
    );
    if (saved != true || !mounted) {
      title.dispose();
      return;
    }
    try {
      await ref.read(collaborationServiceProvider).updateChallengeMilestone(
          milestone.id!,
          title.text,
          milestone.description,
          status,
          milestone.dueAt);
      ref.invalidate(teamMilestonesProvider(widget.team.id!));
    } catch (error) {
      _showError(error);
    } finally {
      title.dispose();
    }
  }

  Future<void> _updateMember(ChallengeTeamMember member, String choice) async {
    final status = choice == 'removed' ? 'removed' : 'active';
    final role = choice == 'removed' ? member.role : choice;
    try {
      await ref
          .read(collaborationServiceProvider)
          .updateChallengeTeamMember(member.id!, role, status);
      ref.invalidate(challengeTeamMembersProvider(widget.team.id!));
    } catch (error) {
      _showError(error);
    }
  }

  Future<void> _inviteMember() async {
    final controller = TextEditingController();
    final invited =
        await _textDialog('Invite team member', 'User ID', controller);
    if (!invited || !mounted) {
      controller.dispose();
      return;
    }
    try {
      final userId = int.parse(controller.text.trim());
      final token = await ref
          .read(collaborationServiceProvider)
          .createChallengeTeamInvite(widget.team.id!, userId);
      if (mounted) {
        await showDialog<void>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Team invite created'),
            content: SelectableText(token),
          ),
        );
      }
    } catch (error) {
      _showError(error);
    } finally {
      controller.dispose();
    }
  }

  Future<void> _addUpdate() async {
    final body = TextEditingController();
    final created =
        await _textDialog('Post progress update', 'Update', body, maxLines: 4);
    if (!created || !mounted) {
      body.dispose();
      return;
    }
    try {
      await ref
          .read(collaborationServiceProvider)
          .postChallengeUpdate(widget.team.id!, body.text);
      ref.invalidate(teamUpdatesProvider(widget.team.id!));
    } catch (error) {
      _showError(error);
    } finally {
      body.dispose();
    }
  }

  Future<bool> _textDialog(
      String title, String label, TextEditingController controller,
      {int maxLines = 1}) async {
    return await showDialog<bool>(
          context: context,
          builder: (dialogContext) => AlertDialog(
            title: Text(title),
            content: TextField(
              controller: controller,
              maxLines: maxLines,
              decoration: InputDecoration(labelText: label),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Cancel'),
              ),
              FilledButton(
                onPressed: () => Navigator.pop(dialogContext, true),
                child: const Text('Save'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _showError(Object error) {
    if (mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget action;
  final Widget child;

  const _Section(
      {required this.title, required this.action, required this.child});

  @override
  Widget build(BuildContext context) => NeuralCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Expanded(
                child: Text(title,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              action,
            ]),
            const SizedBox(height: 10),
            child,
          ],
        ),
      );
}
