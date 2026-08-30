import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import 'package:url_launcher/url_launcher.dart';
import 'room_chat_screen.dart';
import 'room_documents_screen.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../../../core/widgets/report_content_dialog.dart';
import '../providers/collaboration_provider.dart';
import '../providers/collaboration_entitlements_provider.dart';
import '../widgets/grounded_answer_card.dart';
import '../widgets/room_presence_card.dart';
import '../widgets/study_session_card.dart';

class RoomDetailScreen extends ConsumerStatefulWidget {
  final int roomId;

  const RoomDetailScreen({required this.roomId, super.key});

  @override
  ConsumerState<RoomDetailScreen> createState() => _RoomDetailScreenState();
}

class _RoomDetailScreenState extends ConsumerState<RoomDetailScreen> {
  final _composer = TextEditingController();
  final _resourceFilter = TextEditingController();
  final List<RoomResource> _additionalResources = [];
  int _resourcePage = 0;
  bool _loadingMoreResources = false;
  bool _joining = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      unawaited(_setPresence('online'));
    });
  }

  @override
  void dispose() {
    unawaited(_setPresence('offline'));
    _composer.dispose();
    _resourceFilter.dispose();
    super.dispose();
  }

  Future<void> _setPresence(String state) async {
    try {
      await ref
          .read(roomPresenceControllerProvider(widget.roomId))
          .setState(state);
    } catch (_) {
      // Presence is best-effort and must not block room navigation.
    }
  }

  @override
  Widget build(BuildContext context) {
    final posts = ref.watch(roomPostsProvider(widget.roomId));
    final resources = ref.watch(roomResourcesProvider(widget.roomId));
    final presence = ref.watch(roomPresenceProvider(widget.roomId));
    final membership = ref.watch(myRoomMembershipProvider(widget.roomId));
    final canCollaborate = membership.asData?.value?.status == 'active';
    ref.listen(roomPostStreamProvider(widget.roomId), (previous, next) {
      next.whenData((_) => ref.invalidate(roomPostsProvider(widget.roomId)));
    });
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        title: const Text('Room discussion'),
        actions: [
          IconButton(
            tooltip: 'Join room',
            icon: const Icon(Icons.person_add_alt_1_outlined),
            onPressed: _joining || canCollaborate ? null : _joinRoom,
          ),
          IconButton(
            tooltip: 'Room chat',
            icon: const Icon(Icons.forum_outlined),
            onPressed: !canCollaborate
                ? null
                : () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RoomChatScreen(roomId: widget.roomId),
                      ),
                    ),
          ),
          IconButton(
            tooltip: 'Share resource',
            icon: const Icon(Icons.link),
            onPressed: !_joining && canCollaborate ? _showAddResource : null,
          ),
          IconButton(
            tooltip: 'Upload resource',
            icon: const Icon(Icons.upload_file_outlined),
            onPressed: !_joining && canCollaborate ? _uploadResource : null,
          ),
          IconButton(
            tooltip: 'Ask this room',
            icon: const Icon(Icons.auto_awesome),
            onPressed: !_joining && canCollaborate ? _showAskRoom : null,
          ),
          IconButton(
            tooltip: 'Study sessions',
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: canCollaborate ? _showStudySessions : null,
          ),
          IconButton(
            tooltip: 'Shared documents',
            icon: const Icon(Icons.description_outlined),
            onPressed: !canCollaborate
                ? null
                : () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            RoomDocumentsScreen(roomId: widget.roomId),
                      ),
                    ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, _) => Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1280),
            child: Column(
              children: [
                presence.when(
                  loading: () => const SizedBox(height: 1),
                  error: (_, __) => const SizedBox.shrink(),
                  data: (items) => RoomPresenceCard(presence: items),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: TextField(
                    controller: _resourceFilter,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'Filter room resources',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                AsyncValueView<List<RoomResource>>(
                  value: resources,
                  onRetry: _resetResourcePagination,
                  emptyMessage: '',
                  builder: (items) {
                    final allItems = [...items, ..._additionalResources];
                    final query = _resourceFilter.text.trim().toLowerCase();
                    final visibleItems = query.isEmpty
                        ? allItems
                        : allItems.where((resource) {
                            final haystack = [
                              resource.title,
                              resource.resourceType,
                              resource.citation ?? '',
                              resource.content ?? '',
                            ].join(' ').toLowerCase();
                            return haystack.contains(query);
                          }).toList();
                    return visibleItems.isEmpty
                        ? const SizedBox.shrink()
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                height: 92,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 10, 16, 8),
                                  itemCount: visibleItems.length,
                                  itemBuilder: (context, index) =>
                                      _ResourceChip(
                                    resource: visibleItems[index],
                                    onTap: () =>
                                        _showResource(visibleItems[index]),
                                  ),
                                ),
                              ),
                              if (allItems.length >= 30)
                                TextButton.icon(
                                  onPressed: _loadingMoreResources
                                      ? null
                                      : _loadMoreResources,
                                  icon: _loadingMoreResources
                                      ? const SizedBox(
                                          width: 16,
                                          height: 16,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        )
                                      : const Icon(Icons.expand_more),
                                  label: const Text('Load more resources'),
                                ),
                            ],
                          );
                  },
                ),
                Expanded(
                  child: AsyncValueView<List<DiscussionPost>>(
                    value: posts,
                    onRetry: () =>
                        ref.invalidate(roomPostsProvider(widget.roomId)),
                    emptyMessage: 'No posts yet. Start the discussion.',
                    builder: (items) => items.isEmpty
                        ? const EmptyListMessage(
                            'No posts yet. Start the discussion.')
                        : ListView.builder(
                            padding: const EdgeInsets.all(16),
                            itemCount: items.length,
                            itemBuilder: (context, index) => _PostCard(
                              post: items[index],
                              onReport: () => _reportPost(items[index]),
                              onComments: () => _showComments(items[index]),
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
                            minLines: 1,
                            maxLines: 4,
                            decoration: const InputDecoration(
                              hintText: 'Share an idea or question',
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        IconButton.filled(
                          tooltip: 'Post',
                          onPressed:
                              !_joining && canCollaborate ? _publish : null,
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _loadMoreResources() async {
    setState(() => _loadingMoreResources = true);
    try {
      final nextPage = _resourcePage + 1;
      final next =
          await ref.read(collaborationServiceProvider).getRoomResources(
                widget.roomId,
                page: nextPage,
              );
      if (!mounted) return;
      setState(() {
        _resourcePage = nextPage;
        _additionalResources.addAll(next);
      });
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _loadingMoreResources = false);
    }
  }

  void _resetResourcePagination() {
    _additionalResources.clear();
    _resourcePage = 0;
    ref.invalidate(roomResourcesProvider(widget.roomId));
  }

  Future<void> _joinRoom() async {
    setState(() => _joining = true);
    try {
      await ref.read(collaborationServiceProvider).joinRoom(widget.roomId);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You are now a member of this room.')),
      );
      ref.invalidate(roomPostsProvider(widget.roomId));
      _resetResourcePagination();
      ref.invalidate(myRoomMembershipProvider(widget.roomId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }

  Future<void> _publish() async {
    final body = _composer.text.trim();
    if (body.isEmpty) return;
    setState(() => _joining = true);
    try {
      await ref
          .read(collaborationServiceProvider)
          .createPost(widget.roomId, body);
      _composer.clear();
      ref.invalidate(roomPostsProvider(widget.roomId));
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }

  Future<void> _showAddResource() async {
    final title = TextEditingController();
    final uri = TextEditingController();
    final citation = TextEditingController();
    final submitted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Share a source'),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: uri,
              decoration: const InputDecoration(labelText: 'URL'),
            ),
            TextField(
              controller: citation,
              decoration:
                  const InputDecoration(labelText: 'Citation (optional)'),
            ),
          ]),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Share'),
          ),
        ],
      ),
    );
    if (submitted != true || !mounted) {
      title.dispose();
      uri.dispose();
      citation.dispose();
      return;
    }
    try {
      await ref.read(collaborationServiceProvider).addRoomResource(
            roomId: widget.roomId,
            resourceType: 'link',
            title: title.text,
            uri: uri.text,
            citation: citation.text,
          );
      _resetResourcePagination();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      title.dispose();
      uri.dispose();
      citation.dispose();
    }
  }

  Future<void> _showAskRoom() async {
    final entitlements =
        await ref.read(collaborationEntitlementsProvider.future);
    final usage = ref.read(collaborationUsageProvider.notifier);
    if (!usage.consumeRoomAiRequest(limit: entitlements.dailyRoomAiLimit)) {
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Daily AI limit reached'),
          content: Text(
            entitlements.isPremium
                ? 'Your premium room AI allowance has been reached for today.'
                : 'Free accounts can ask five room questions per day. Upgrade for a higher limit.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
            if (!entitlements.isPremium)
              FilledButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  context.push('/subscription');
                },
                child: const Text('Upgrade'),
              ),
          ],
        ),
      );
      return;
    }
    if (!mounted) return;
    final question = TextEditingController();
    final answerText = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ask this room'),
        content: TextField(
          controller: question,
          autofocus: true,
          maxLines: 4,
          decoration: const InputDecoration(
            labelText: 'Question',
            hintText: 'Ask about the shared sources...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, question.text.trim()),
            child: const Text('Ask'),
          ),
        ],
      ),
    );
    if (!mounted) return;
    question.dispose();
    if (answerText == null || answerText.isEmpty || !mounted) return;
    setState(() => _joining = true);
    try {
      final answer = await ref
          .read(collaborationServiceProvider)
          .askRoom(widget.roomId, answerText);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Ask this room'),
          content: SingleChildScrollView(
            child: GroundedAnswerCard(
              answer: answer.answer,
              confidence: answer.confidence,
              citations: answer.citations,
              onReport: () async {
                if (answer.id == null) return;
                await ref.read(collaborationServiceProvider).reportContent(
                      contentType: 'room_ai_answer',
                      contentId: answer.id!,
                      reason: 'incorrect_ai_output',
                    );
                if (dialogContext.mounted) Navigator.pop(dialogContext);
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      if (mounted) setState(() => _joining = false);
    }
  }

  Future<void> _showStudySessions() async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) => Consumer(
        builder: (context, ref, _) {
          final sessions = ref.watch(roomStudySessionsProvider(widget.roomId));
          return SizedBox(
            height: MediaQuery.sizeOf(context).height * .7,
            child: Column(
              children: [
                ListTile(
                  title: const Text('Scheduled study sessions'),
                  trailing: IconButton(
                    tooltip: 'Schedule session',
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      Navigator.pop(sheetContext);
                      _createStudySession();
                    },
                  ),
                ),
                Expanded(
                  child: AsyncValueView<List<ScheduledStudySession>>(
                    value: sessions,
                    onRetry: () => ref.invalidate(
                      roomStudySessionsProvider(widget.roomId),
                    ),
                    emptyMessage: 'No study sessions scheduled.',
                    builder: (items) => items.isEmpty
                        ? const EmptyListMessage('No study sessions scheduled.')
                        : ListView(
                            padding: const EdgeInsets.all(16),
                            children: items
                                .map((session) => StudySessionCard(
                                      session: session,
                                      onJoin: () => _joinStudySession(session),
                                    ))
                                .toList(),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _createStudySession() async {
    final title = TextEditingController();
    final created = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Schedule study session'),
        content: TextField(
          controller: title,
          decoration: const InputDecoration(labelText: 'Session title'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Schedule'),
          ),
        ],
      ),
    );
    if (created != true || !mounted || title.text.trim().isEmpty) {
      title.dispose();
      return;
    }
    final start = DateTime.now().add(const Duration(hours: 1));
    try {
      await ref.read(collaborationServiceProvider).createStudySession(
            roomId: widget.roomId,
            title: title.text.trim(),
            startsAt: start,
            endsAt: start.add(const Duration(hours: 1)),
          );
      ref.invalidate(roomStudySessionsProvider(widget.roomId));
    } catch (error) {
      _showError(error);
    } finally {
      title.dispose();
    }
  }

  Future<void> _joinStudySession(ScheduledStudySession session) async {
    if (session.id == null) return;
    try {
      await ref
          .read(collaborationServiceProvider)
          .joinStudySession(session.id!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('You joined the study session.')),
        );
      }
    } catch (error) {
      _showError(error);
    }
  }

  void _showError(Object error) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(error.toString())));
  }

  Future<void> _uploadResource() async {
    final picked = await FilePicker.platform.pickFiles(
      withData: true,
      type: FileType.custom,
      allowedExtensions: const [
        'pdf',
        'doc',
        'docx',
        'ppt',
        'pptx',
        'txt',
        'md',
        'xlsx',
      ],
    );
    if (picked == null || picked.files.single.bytes == null || !mounted) return;
    final file = picked.files.single;
    final extension = file.extension?.toLowerCase();
    if (extension == null || extension.isEmpty) return;
    final title = TextEditingController(text: file.name);
    final citation = TextEditingController();
    final submitted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Upload room material'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: title,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: citation,
              decoration:
                  const InputDecoration(labelText: 'Citation (optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Upload'),
          ),
        ],
      ),
    );
    if (submitted != true || !mounted) {
      title.dispose();
      citation.dispose();
      return;
    }
    setState(() => _joining = true);
    try {
      await ref.read(collaborationServiceProvider).uploadRoomResource(
            roomId: widget.roomId,
            resourceType: 'material',
            title: title.text,
            fileType: extension,
            fileData: ByteData.sublistView(file.bytes!),
            citation: citation.text,
          );
      _resetResourcePagination();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      title.dispose();
      citation.dispose();
      if (mounted) setState(() => _joining = false);
    }
  }

  Future<void> _reportPost(DiscussionPost post) async {
    await ReportContentDialog.show(
      context,
      onSubmit: (reason, details) =>
          ref.read(collaborationServiceProvider).reportContent(
                contentType: 'post',
                contentId: post.id!,
                reason: reason,
                details: details,
              ),
    );
  }

  Future<void> _showComments(DiscussionPost post) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => _CommentsSheet(post: post),
    );
  }

  Future<void> _showResource(RoomResource resource) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(resource.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(resource.content ?? resource.uri ?? 'No preview available.'),
              if (resource.citation?.isNotEmpty == true) ...[
                const SizedBox(height: 14),
                Text('Citation: ${resource.citation}'),
              ],
            ],
          ),
        ),
        actions: [
          if (resource.uri?.isNotEmpty == true)
            TextButton.icon(
              onPressed: () => launchUrl(Uri.parse(resource.uri!)),
              icon: const Icon(Icons.open_in_new),
              label: const Text('Open source'),
            ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}

class _ResourceChip extends StatelessWidget {
  final RoomResource resource;
  final VoidCallback onTap;

  const _ResourceChip({required this.resource, required this.onTap});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: NeuralCard(
          onTap: onTap,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                resource.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 4),
              Text(
                resource.resourceType,
                style:
                    TextStyle(color: Colors.white.withAlpha(150), fontSize: 11),
              ),
            ],
          ),
        ),
      );
}

class _CommentsSheet extends ConsumerStatefulWidget {
  final DiscussionPost post;

  const _CommentsSheet({required this.post});

  @override
  ConsumerState<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends ConsumerState<_CommentsSheet> {
  final _composer = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _composer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final comments = ref.watch(postCommentsProvider(widget.post.id!));

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          16,
          16,
          16,
          MediaQuery.viewInsetsOf(context).bottom + 16,
        ),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .65,
          child: Column(
            children: [
              Text('Comments', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Expanded(
                child: AsyncValueView<List<Comment>>(
                  value: comments,
                  onRetry: () => ref.invalidate(
                    postCommentsProvider(widget.post.id!),
                  ),
                  emptyMessage: 'No comments yet.',
                  builder: (comments) {
                    if (comments.isEmpty) {
                      return const EmptyListMessage('No comments yet.');
                    }
                    return ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) => ListTile(
                        dense: true,
                        title: Text(comments[index].body),
                        subtitle: Text(
                          comments[index].createdAt.toLocal().toString(),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _composer,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        hintText: 'Write a comment',
                      ),
                    ),
                  ),
                  IconButton.filled(
                    tooltip: 'Comment',
                    onPressed: _sending ? null : _send,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _send() async {
    final body = _composer.text.trim();
    if (body.isEmpty) return;
    setState(() => _sending = true);
    try {
      await ref.read(collaborationServiceProvider).createComment(
            widget.post.id!,
            body,
          );
      _composer.clear();
      ref.invalidate(postCommentsProvider(widget.post.id!));
      if (mounted) setState(() => _sending = false);
    } catch (error) {
      if (!mounted) return;
      setState(() => _sending = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(error.toString())));
    }
  }
}

class _PostCard extends StatelessWidget {
  final DiscussionPost post;
  final VoidCallback onReport;
  final VoidCallback onComments;

  const _PostCard({
    required this.post,
    required this.onReport,
    required this.onComments,
  });

  @override
  Widget build(BuildContext context) => NeuralCard(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text(post.body,
                        style: const TextStyle(color: Colors.white))),
                IconButton(
                  tooltip: 'Report',
                  icon: const Icon(Icons.flag_outlined, size: 18),
                  onPressed: onReport,
                ),
              ],
            ),
            TextButton.icon(
              onPressed: onComments,
              icon: const Icon(Icons.comment_outlined, size: 17),
              label: const Text('Comments'),
            ),
            const SizedBox(height: 8),
            Text(
              post.createdAt.toLocal().toString(),
              style:
                  TextStyle(color: Colors.white.withAlpha(130), fontSize: 11),
            ),
          ],
        ),
      );
}
