import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../providers/collaboration_provider.dart';
import '../providers/collaboration_interaction_providers.dart';
import '../widgets/grounded_answer_card.dart';

class RoomAiWorkspaceScreen extends ConsumerStatefulWidget {
  const RoomAiWorkspaceScreen({required this.roomId, super.key});
  final int roomId;

  @override
  ConsumerState<RoomAiWorkspaceScreen> createState() =>
      _RoomAiWorkspaceScreenState();
}

class _RoomAiWorkspaceScreenState extends ConsumerState<RoomAiWorkspaceScreen> {
  final _question = TextEditingController();
  RoomAiAnswer? _answer;
  bool _loading = false;
  String? _error;

  @override
  void dispose() {
    _question.dispose();
    super.dispose();
  }

  Future<void> _ask(String prompt) async {
    _question.text = prompt;
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final answer = await ref
          .read(collaborationServiceProvider)
          .askRoom(widget.roomId, prompt);
      if (mounted) setState(() => _answer = answer);
    } catch (error) {
      if (mounted) setState(() => _error = error.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final resources = ref.watch(roomResourcesProvider(widget.roomId));
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(title: const Text('Room knowledge base')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          NeuralSectionHeader(
            title: 'Shared sources and AI tools',
            subtitle: 'All answers are grounded in this room’s resources.',
            icon: Icons.auto_awesome,
            trailing: IconButton(
              tooltip: 'Whiteboard',
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (_) => RoomWhiteboardScreen(roomId: widget.roomId))),
              icon: const Icon(Icons.draw_outlined),
            ),
          ),
          const SizedBox(height: 16),
          AsyncValueView<List<RoomResource>>(
            value: resources,
            onRetry: () => ref.invalidate(roomResourcesProvider(widget.roomId)),
            emptyMessage: 'No shared sources yet.',
            builder: (items) => NeuralCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Sources',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  ...items.map((resource) => ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.source_outlined),
                        title: Text(resource.title),
                        subtitle:
                            Text(resource.citation ?? resource.resourceType),
                        onTap: () => _openSource(resource),
                      )),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _tool('Study guide',
                  'Create a concise cited study guide from the room sources.'),
              _tool('Quiz',
                  'Create a revision quiz from the room sources with answers.'),
              _tool('Knowledge gaps',
                  'Identify the group’s biggest knowledge gaps and suggest next steps.'),
              _tool('Discussion summary',
                  'Summarize the room discussion and list action items.'),
            ],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _question,
            onChanged: (_) => setState(() {}),
            minLines: 2,
            maxLines: 5,
            decoration: const InputDecoration(
              labelText: 'Ask this room',
              hintText: 'Every answer includes its supporting citations.',
            ),
          ),
          const SizedBox(height: 8),
          FilledButton.icon(
            onPressed: _loading || _question.text.trim().isEmpty
                ? null
                : () => _ask(_question.text.trim()),
            icon: _loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.auto_awesome),
            label: const Text('Generate'),
          ),
          if (_error != null) ...[
            const SizedBox(height: 12),
            NeuralCard(
              child: Row(children: [
                const Icon(Icons.error_outline, color: Colors.orangeAccent),
                const SizedBox(width: 8),
                Expanded(child: Text(_error!)),
                TextButton(
                    onPressed: _loading ? null : () => _ask(_question.text),
                    child: const Text('Retry')),
              ]),
            ),
          ],
          if (_answer != null) ...[
            const SizedBox(height: 12),
            GroundedAnswerCard(
              answer: _answer!.answer,
              confidence: _answer!.confidence,
              citations: _answer!.citations,
              onCitationTap: _openCitation,
            ),
          ],
        ],
      ),
    );
  }

  Widget _tool(String label, String prompt) => ActionChip(
        avatar: const Icon(Icons.auto_awesome, size: 16),
        label: Text(label),
        onPressed: _loading ? null : () => _ask(prompt),
      );

  Future<void> _openSource(RoomResource resource) async {
    final value = resource.uri ?? resource.content;
    if (value == null || value.isEmpty) return;
    final uri = Uri.tryParse(value);
    if (uri != null && {'http', 'https'}.contains(uri.scheme)) {
      await launchUrl(uri);
    } else if (mounted) {
      await showDialog<void>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(resource.title),
          content: SingleChildScrollView(child: SelectableText(value)),
        ),
      );
    }
  }

  Future<void> _openCitation(String citation) async {
    final uri = Uri.tryParse(citation);
    if (uri != null && {'http', 'https'}.contains(uri.scheme)) {
      await launchUrl(uri);
      return;
    }
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Citation provenance'),
        content: SelectableText(citation),
      ),
    );
  }
}

class RoomWhiteboardScreen extends ConsumerWidget {
  const RoomWhiteboardScreen({required this.roomId, super.key});
  final int roomId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(whiteboardProvider(roomId));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shared whiteboard'),
        actions: [
          IconButton(
            tooltip: 'Undo',
            onPressed: state.strokes.isEmpty
                ? null
                : () async {
                    final controller =
                        ref.read(whiteboardProvider(roomId).notifier);
                    controller.undo();
                    await controller.persist();
                  },
            icon: const Icon(Icons.undo),
          ),
          IconButton(
            tooltip: 'Clear',
            onPressed: () async {
              final controller = ref.read(whiteboardProvider(roomId).notifier);
              controller.clear();
              await controller.persist();
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: GestureDetector(
        onPanStart: (details) => ref
            .read(whiteboardProvider(roomId).notifier)
            .addStroke([
          OffsetPoint(details.localPosition.dx, details.localPosition.dy)
        ]),
        onPanUpdate: (details) {
          final strokes = ref.read(whiteboardProvider(roomId)).strokes;
          if (strokes.isEmpty) return;
          final current = [
            ...strokes.last,
            OffsetPoint(details.localPosition.dx, details.localPosition.dy)
          ];
          ref.read(whiteboardProvider(roomId).notifier).undo();
          ref.read(whiteboardProvider(roomId).notifier).addStroke(current);
        },
        onPanEnd: (_) =>
            ref.read(whiteboardProvider(roomId).notifier).persist(),
        child: CustomPaint(
          painter: _WhiteboardPainter(state.strokes),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}

class _WhiteboardPainter extends CustomPainter {
  const _WhiteboardPainter(this.strokes);
  final List<List<OffsetPoint>> strokes;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF00D4FF)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    for (final stroke in strokes) {
      for (var i = 1; i < stroke.length; i++) {
        canvas.drawLine(Offset(stroke[i - 1].x, stroke[i - 1].y),
            Offset(stroke[i].x, stroke[i].y), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _WhiteboardPainter oldDelegate) => true;
}
