import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../providers/collaboration_provider.dart';

class RoomDocumentsScreen extends ConsumerWidget {
  const RoomDocumentsScreen({required this.roomId, super.key});

  final int roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final documents = ref.watch(roomDocumentsProvider(roomId));
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        title: const Text('Shared documents'),
        actions: [
          IconButton(
            tooltip: 'Create document',
            icon: const Icon(Icons.note_add_outlined),
            onPressed: () => _createDocument(context, ref),
          ),
        ],
      ),
      body: AsyncValueView<List<CollaborativeDocument>>(
        value: documents,
        onRetry: () => ref.invalidate(roomDocumentsProvider(roomId)),
        emptyMessage: 'No shared documents yet.',
        builder: (items) => items.isEmpty
            ? const EmptyListMessage('No shared documents yet.')
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final document = items[index];
                  return NeuralCard(
                    margin: const EdgeInsets.only(bottom: 10),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            DocumentEditorScreen(document: document),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.description_outlined,
                          color: Color(0xFF00D4FF)),
                      title: Text(document.title,
                          style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                        'Version ${document.version} • ${document.status}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> _createDocument(BuildContext context, WidgetRef ref) async {
    final title = TextEditingController();
    final body = TextEditingController();
    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Create shared document'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
                controller: title,
                decoration: const InputDecoration(labelText: 'Title')),
            TextField(
                controller: body,
                maxLines: 5,
                decoration: const InputDecoration(labelText: 'Content')),
          ],
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Create')),
        ],
      ),
    );
    if (created != true || title.text.trim().isEmpty || !context.mounted) {
      title.dispose();
      body.dispose();
      return;
    }
    try {
      final document =
          await ref.read(collaborationServiceProvider).createDocument(
                roomId,
                title.text.trim(),
                body.text,
              );
      ref.invalidate(roomDocumentsProvider(roomId));
      if (context.mounted) {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => DocumentEditorScreen(document: document),
        ));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      title.dispose();
      body.dispose();
    }
  }
}

class DocumentEditorScreen extends ConsumerStatefulWidget {
  const DocumentEditorScreen({required this.document, super.key});

  final CollaborativeDocument document;

  @override
  ConsumerState<DocumentEditorScreen> createState() =>
      _DocumentEditorScreenState();
}

class _DocumentEditorScreenState extends ConsumerState<DocumentEditorScreen> {
  late final TextEditingController _title;
  late final TextEditingController _body;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.document.title);
    _body = TextEditingController(text: widget.document.body);
  }

  @override
  void dispose() {
    _title.dispose();
    _body.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFF0A0A0F),
        appBar: AppBar(
          title: Text(widget.document.title),
          actions: [
            IconButton(
              tooltip: 'Save document',
              onPressed: _saving ? null : _save,
              icon: const Icon(Icons.save_outlined),
            ),
          ],
        ),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title')),
            const SizedBox(height: 12),
            TextField(
              controller: _body,
              minLines: 16,
              maxLines: null,
              decoration: const InputDecoration(labelText: 'Document content'),
            ),
            const SizedBox(height: 8),
            Text('Editing version ${widget.document.version}',
                style: const TextStyle(color: Colors.white54)),
          ],
        ),
      );

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      final updated =
          await ref.read(collaborationServiceProvider).updateDocument(
                widget.document.id!,
                _title.text.trim(),
                _body.text,
                widget.document.version,
              );
      if (!mounted) return;
      Navigator.pop(context, updated);
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
