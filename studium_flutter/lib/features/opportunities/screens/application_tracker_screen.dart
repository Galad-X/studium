import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../../collaboration/providers/collaboration_provider.dart';

class ApplicationTrackerScreen extends ConsumerWidget {
  const ApplicationTrackerScreen({super.key});

  static const statuses = [
    'interested',
    'drafting',
    'applied',
    'shortlisted',
    'awarded',
    'rejected',
    'withdrawn',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trackers = ref.watch(applicationTrackersProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(title: const Text('Application tracker')),
      body: AsyncValueView<List<OpportunityApplicationTracker>>(
        value: trackers,
        onRetry: () => ref.invalidate(applicationTrackersProvider),
        emptyMessage: 'No applications tracked yet.',
        builder: (items) => items.isEmpty
            ? const EmptyListMessage('No applications tracked yet.')
            : ListView(
                padding: const EdgeInsets.all(16),
                children: items
                    .map((tracker) => NeuralCard(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.assignment_outlined,
                                color: Color(0xFF00D4FF)),
                            title:
                                Text('Opportunity #${tracker.opportunityId}'),
                            subtitle: Text(tracker.status),
                            trailing: PopupMenuButton<String>(
                              tooltip: 'Update status',
                              onSelected: (status) async {
                                await ref
                                    .read(collaborationServiceProvider)
                                    .upsertApplicationTracker(
                                      opportunityId: tracker.opportunityId,
                                      status: status,
                                      notes: tracker.notes,
                                      applicationUrl: tracker.applicationUrl,
                                    );
                                ref.invalidate(applicationTrackersProvider);
                              },
                              itemBuilder: (context) => statuses
                                  .map((status) => PopupMenuItem<String>(
                                      value: status, child: Text(status)))
                                  .toList(),
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
    );
  }
}
