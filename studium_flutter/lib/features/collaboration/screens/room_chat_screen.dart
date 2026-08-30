import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../providers/collaboration_provider.dart';
import '../providers/collaboration_interaction_providers.dart';

class RoomChatScreen extends ConsumerStatefulWidget {
  final int roomId;

  const RoomChatScreen({required this.roomId, super.key});

  @override
  ConsumerState<RoomChatScreen> createState() => _RoomChatScreenState();
}

class _RoomChatScreenState extends ConsumerState<RoomChatScreen> {
  final _composer = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _composer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(roomChatMessagesProvider(widget.roomId));
    final typing = ref.watch(typingProvider(widget.roomId));
    final pushState =
        ref.watch(pushNotificationProvider('room:${widget.roomId}'));
    ref.listen(roomChatMessagesProvider(widget.roomId), (previous, next) {
      next.whenData((items) {
        final receipts = ref.read(readReceiptProvider(widget.roomId).notifier);
        for (final item in items) {
          if (item.id != null) receipts.markRead(item.id!);
        }
      });
    });
    ref.listen(roomChatStreamProvider(widget.roomId), (previous, next) {
      next.whenData(
          (_) => ref.invalidate(roomChatMessagesProvider(widget.roomId)));
    });
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        title: const Text('Room chat'),
        actions: [
          IconButton(
            tooltip: pushState == PushPermissionState.enabled
                ? 'Mute room notifications'
                : 'Enable room notifications',
            onPressed: () => ref
                .read(
                    pushNotificationProvider('room:${widget.roomId}').notifier)
                .setPermission(pushState == PushPermissionState.enabled
                    ? PushPermissionState.denied
                    : PushPermissionState.enabled),
            icon: Icon(pushState == PushPermissionState.enabled
                ? Icons.notifications_active_outlined
                : Icons.notifications_none_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: AsyncValueView<List<RoomChatMessage>>(
              value: messages,
              onRetry: () =>
                  ref.invalidate(roomChatMessagesProvider(widget.roomId)),
              emptyMessage: 'No chat messages yet.',
              builder: (items) => items.isEmpty
                  ? const EmptyListMessage('No chat messages yet.')
                  : Column(
                      children: [
                        if (typing.userIds.isNotEmpty)
                          const Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text('Someone is typing…'),
                          ),
                        Expanded(
                          child: ListView.builder(
                            reverse: true,
                            padding: const EdgeInsets.all(16),
                            itemCount: items.length,
                            itemBuilder: (context, index) => _ChatMessageTile(
                              message: items[index],
                              read: items[index].id != null &&
                                  ref
                                      .read(readReceiptProvider(widget.roomId))
                                      .readMessageIds
                                      .contains(items[index].id),
                            ),
                          ),
                        ),
                      ],
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
                      onChanged: (value) => ref
                          .read(typingProvider(widget.roomId).notifier)
                          .setTyping(0, value.trim().isNotEmpty),
                      decoration: const InputDecoration(
                        hintText: 'Message the room',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
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
    if (body.isEmpty) return;
    setState(() => _sending = true);
    try {
      await ref
          .read(collaborationServiceProvider)
          .createRoomChatMessage(widget.roomId, body);
      _composer.clear();
      ref.read(typingProvider(widget.roomId).notifier).setTyping(0, false);
      ref.invalidate(roomChatMessagesProvider(widget.roomId));
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }
}

class _ChatMessageTile extends StatelessWidget {
  final RoomChatMessage message;
  final bool read;

  const _ChatMessageTile({required this.message, this.read = false});

  @override
  Widget build(BuildContext context) => NeuralCard(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message.body, style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  message.createdAt.toLocal().toString(),
                  style: TextStyle(
                      color: Colors.white.withAlpha(130), fontSize: 11),
                ),
                const Spacer(),
                if (read)
                  const Icon(Icons.done_all,
                      size: 14, color: Colors.lightBlueAccent),
              ],
            ),
          ],
        ),
      );
}
