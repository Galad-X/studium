import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../providers/collaboration_provider.dart';

class ModerationAppealsScreen extends ConsumerWidget {
  const ModerationAppealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appeals = ref.watch(myModerationAppealsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(title: const Text('Moderation appeals')),
      body: AsyncValueView<List<ModerationAppeal>>(
        value: appeals,
        onRetry: () => ref.invalidate(myModerationAppealsProvider),
        emptyMessage: 'No moderation appeals.',
        builder: (items) => items.isEmpty
            ? const EmptyListMessage('No moderation appeals.')
            : ListView(
                padding: const EdgeInsets.all(16),
                children: items
                    .map((appeal) => NeuralCard(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: Icon(
                              appeal.status == 'approved'
                                  ? Icons.check_circle_outline
                                  : appeal.status == 'rejected'
                                      ? Icons.cancel_outlined
                                      : Icons.pending_outlined,
                              color: appeal.status == 'approved'
                                  ? Colors.greenAccent
                                  : appeal.status == 'rejected'
                                      ? Colors.redAccent
                                      : Colors.orangeAccent,
                            ),
                            title: Text('Report #${appeal.reportId}'),
                            subtitle: Text(
                              '${appeal.status} • ${appeal.reason}',
                            ),
                          ),
                        ))
                    .toList(),
              ),
      ),
    );
  }
}
