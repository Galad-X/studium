import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../providers/collaboration_interaction_providers.dart';
import '../providers/collaboration_provider.dart';
import 'safety_relationships_screen.dart';
import 'privacy_controls_screen.dart';

class ConversationsScreen extends ConsumerWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conversations = ref.watch(conversationsProvider);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        title: const Text('Conversations'),
        actions: [
          IconButton(
            tooltip: 'Safety controls',
            icon: const Icon(Icons.shield_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SafetyRelationshipsScreen(),
              ),
            ),
          ),
          IconButton(
            tooltip: 'Privacy controls',
            icon: const Icon(Icons.privacy_tip_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const PrivacyControlsScreen()),
            ),
          ),
        ],
      ),
      body: AsyncValueView<List<Conversation>>(
        value: conversations,
        onRetry: () => ref.invalidate(conversationsProvider),
        emptyMessage: 'No conversations yet.',
        builder: (items) => items.isEmpty
            ? const EmptyListMessage('No conversations yet.')
            : ListView(
                padding: const EdgeInsets.all(16),
                children: items
                    .map((conversation) => NeuralCard(
                          margin: const EdgeInsets.only(bottom: 10),
                          onTap: conversation.id == null
                              ? null
                              : () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ConversationScreen(
                                        conversation: conversation,
                                      ),
                                    ),
                                  ),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.chat_bubble_outline,
                                color: Color(0xFF00D4FF)),
                            title: Text(
                              conversation.title ?? 'Direct conversation',
                              style: const TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(conversation.conversationType),
                            trailing: const Icon(Icons.chevron_right),
                          ),
                        ))
                    .toList(),
              ),
      ),
    );
  }
}

class ConversationScreen extends ConsumerStatefulWidget {
  const ConversationScreen({required this.conversation, super.key});

  final Conversation conversation;

  @override
  ConsumerState<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends ConsumerState<ConversationScreen> {
  final _composer = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _composer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final conversationId = widget.conversation.id!;
    final messages = ref.watch(conversationMessagesProvider(conversationId));
    ref.listen(conversationStreamProvider(conversationId), (_, next) {
      next.whenData((_) => ref.invalidate(
            conversationMessagesProvider(conversationId),
          ));
    });
    ref.listen(conversationMessagesProvider(conversationId), (_, next) {
      next.whenData((items) {
        if (items.isNotEmpty) {
          final latest = items.first;
          if (latest.id != null) {
            ref
                .read(readReceiptProvider(conversationId).notifier)
                .markReadRemotely(latest.id!);
            ref.invalidate(conversationReadReceiptsProvider(conversationId));
          }
        }
      });
    });
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(title: Text(widget.conversation.title ?? 'Conversation')),
      body: Column(
        children: [
          Expanded(
            child: AsyncValueView<List<DirectMessage>>(
              value: messages,
              onRetry: () => ref.invalidate(
                conversationMessagesProvider(conversationId),
              ),
              emptyMessage: 'No messages yet.',
              builder: (items) => items.isEmpty
                  ? const EmptyListMessage('No messages yet.')
                  : ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      itemBuilder: (context, index) => NeuralCard(
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Text(items[index].body,
                            style: const TextStyle(color: Colors.white)),
                      ),
                    ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _composer,
                      maxLines: 3,
                      decoration: const InputDecoration(hintText: 'Message'),
                    ),
                  ),
                  IconButton.filled(
                    tooltip: 'Send',
                    onPressed: _sending ? null : _send,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _send() async {
    final body = _composer.text.trim();
    if (body.isEmpty || widget.conversation.id == null) return;
    setState(() => _sending = true);
    try {
      await ref
          .read(collaborationServiceProvider)
          .sendMessage(widget.conversation.id!, body);
      _composer.clear();
      ref.invalidate(conversationMessagesProvider(widget.conversation.id!));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }
}
