import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../providers/collaboration_provider.dart';

class SafetyRelationshipsScreen extends ConsumerWidget {
  const SafetyRelationshipsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final relationships = ref.watch(mySafetyRelationshipsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(title: const Text('Safety controls')),
      body: AsyncValueView<List<UserSafetyRelationship>>(
        value: relationships,
        onRetry: () => ref.invalidate(mySafetyRelationshipsProvider),
        emptyMessage: 'No blocked, muted, or restricted users.',
        builder: (items) => items.isEmpty
            ? const EmptyListMessage('No blocked, muted, or restricted users.')
            : ListView(
                padding: const EdgeInsets.all(16),
                children: items
                    .map((relationship) => NeuralCard(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: Icon(
                              relationship.relationshipType == 'block'
                                  ? Icons.block
                                  : Icons.volume_off_outlined,
                            ),
                            title: Text('User #${relationship.targetUserId}'),
                            subtitle: Text(relationship.relationshipType),
                            trailing: IconButton(
                              tooltip:
                                  'Remove ${relationship.relationshipType}',
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () async {
                                await ref
                                    .read(collaborationServiceProvider)
                                    .removeSafetyRelationship(
                                      relationship.targetUserId,
                                      relationship.relationshipType,
                                    );
                                ref.invalidate(mySafetyRelationshipsProvider);
                              },
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showRestrictDialog(context, ref),
        icon: const Icon(Icons.person_off_outlined),
        label: const Text('Restrict user'),
      ),
    );
  }

  Future<void> _showRestrictDialog(BuildContext context, WidgetRef ref) async {
    final controller = TextEditingController();
    final userId = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Restrict a user'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'User ID'),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel')),
          FilledButton(
            onPressed: () =>
                Navigator.pop(context, int.tryParse(controller.text.trim())),
            child: const Text('Restrict'),
          ),
        ],
      ),
    );
    if (userId == null || !context.mounted) return;
    try {
      await ref
          .read(collaborationServiceProvider)
          .setSafetyRelationship(userId, 'restrict');
      ref.invalidate(mySafetyRelationshipsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('User restricted')));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not restrict user: $error')));
      }
    }
  }
}
