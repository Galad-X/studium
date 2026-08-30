import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../providers/collaboration_provider.dart';

class ModerationFeedbackScreen extends ConsumerWidget {
  const ModerationFeedbackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reports = ref.watch(myContentReportsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(title: const Text('Moderation feedback')),
      body: AsyncValueView<List<ContentReport>>(
        value: reports,
        onRetry: () => ref.invalidate(myContentReportsProvider),
        emptyMessage: 'No reports or moderation feedback yet.',
        builder: (items) => items.isEmpty
            ? const EmptyListMessage('No reports or moderation feedback yet.')
            : ListView(
                padding: const EdgeInsets.all(16),
                children: items.map((report) {
                  final canAppeal =
                      report.id != null && report.status != 'open';
                  return NeuralCard(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(_iconFor(report.status)),
                      title: Text('${report.contentType} #${report.contentId}'),
                      subtitle: Text(
                          '${report.status} • ${report.reason}\n${report.details ?? ''}'),
                      isThreeLine: report.details != null,
                      trailing: canAppeal
                          ? TextButton(
                              onPressed: () => _appeal(context, ref, report),
                              child: const Text('Appeal'),
                            )
                          : null,
                    ),
                  );
                }).toList(),
              ),
      ),
    );
  }

  static IconData _iconFor(String status) {
    switch (status) {
      case 'resolved':
        return Icons.check_circle_outline;
      case 'dismissed':
        return Icons.info_outline;
      default:
        return Icons.pending_outlined;
    }
  }

  Future<void> _appeal(
    BuildContext context,
    WidgetRef ref,
    ContentReport report,
  ) async {
    final reason = await showDialog<String>(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Appeal moderation decision'),
          content: TextField(
            controller: controller,
            maxLines: 4,
            decoration: const InputDecoration(hintText: 'Explain your appeal'),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            FilledButton(
                onPressed: () => Navigator.pop(context, controller.text.trim()),
                child: const Text('Submit')),
          ],
        );
      },
    );
    if (reason == null ||
        reason.isEmpty ||
        report.id == null ||
        !context.mounted) {
      return;
    }
    try {
      await ref
          .read(collaborationServiceProvider)
          .submitModerationAppeal(report.id!, reason);
      ref.invalidate(myModerationAppealsProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Appeal submitted')));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not submit appeal: $error')));
      }
    }
  }
}
