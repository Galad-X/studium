import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../../collaboration/providers/collaboration_provider.dart';
import 'application_tracker_screen.dart';

class SavedOpportunitiesScreen extends ConsumerWidget {
  const SavedOpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final saved = ref.watch(savedOpportunitiesProvider);
    final alerts = ref.watch(opportunityAlertsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        title: const Text('Saved opportunities'),
        actions: [
          IconButton(
            tooltip: 'Application tracker',
            icon: const Icon(Icons.assignment_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const ApplicationTrackerScreen(),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const NeuralSectionHeader(
            title: 'Your shortlist',
            subtitle: 'Keep track of opportunities you want to apply for.',
            icon: Icons.bookmark_outline,
          ),
          const SizedBox(height: 16),
          AsyncValueView<List<OpportunitySave>>(
            value: saved,
            onRetry: () => ref.invalidate(savedOpportunitiesProvider),
            emptyMessage: 'No saved opportunities yet.',
            builder: (items) => items.isEmpty
                ? const EmptyListMessage('No saved opportunities yet.')
                : Column(
                    children: items
                        .map((item) => NeuralCard(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                leading: const Icon(Icons.bookmark,
                                    color: Color(0xFF00D4FF)),
                                title:
                                    Text('Opportunity #${item.opportunityId}'),
                                subtitle: Text(
                                  'Saved ${item.savedAt.toLocal().toString().split(' ').first}',
                                ),
                                trailing: Icon(
                                  item.alertEnabled
                                      ? Icons.notifications_active_outlined
                                      : Icons.notifications_none_outlined,
                                ),
                              ),
                            ))
                        .toList(),
                  ),
          ),
          const SizedBox(height: 20),
          const Text('Active alerts',
              style: TextStyle(color: Colors.white, fontSize: 19)),
          const SizedBox(height: 10),
          AsyncValueView<List<OpportunityAlert>>(
            value: alerts,
            onRetry: () => ref.invalidate(opportunityAlertsProvider),
            emptyMessage: 'No opportunity alerts configured.',
            builder: (items) => items.isEmpty
                ? const EmptyListMessage('No opportunity alerts configured.')
                : Column(
                    children: items
                        .map((alert) => NeuralCard(
                              margin: const EdgeInsets.only(bottom: 10),
                              child: ListTile(
                                title: Text(
                                  [
                                    alert.country,
                                    alert.field,
                                    alert.educationLevel
                                  ]
                                      .whereType<String>()
                                      .where((value) => value.isNotEmpty)
                                      .join(' • '),
                                ),
                                subtitle: Text(
                                  'Within ${alert.deadlineWithinDays} days',
                                ),
                                trailing: IconButton(
                                  tooltip: 'Deactivate alert',
                                  onPressed: alert.id == null
                                      ? null
                                      : () async {
                                          await ref
                                              .read(
                                                  collaborationServiceProvider)
                                              .deactivateOpportunityAlert(
                                                  alert.id!);
                                          ref.invalidate(
                                              opportunityAlertsProvider);
                                        },
                                  icon: const Icon(
                                      Icons.notifications_off_outlined),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
