import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studium_client/studium_client.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/providers/service_providers.dart';
import '../../../services/export_service.dart';

class SummaryDetailScreen extends ConsumerStatefulWidget {
  final Summary summary;

  const SummaryDetailScreen({super.key, required this.summary});

  @override
  ConsumerState<SummaryDetailScreen> createState() =>
      _SummaryDetailScreenState();
}

class _SummaryDetailScreenState
    extends ConsumerState<SummaryDetailScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _fabController;
  late ScrollController _scrollController;

  bool _isBookmarked = false;
  bool _showFab = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _fabController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scrollController = ScrollController();

    _scrollController.addListener(_onScroll);
    _animationController.forward();
  }

  void _onScroll() {
    if (_scrollController.offset > 100 && !_showFab) {
      setState(() => _showFab = true);
      _fabController.forward();
    } else if (_scrollController.offset <= 100 && _showFab) {
      setState(() => _showFab = false);
      _fabController.reverse();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _fabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          _buildSliverAppBar(theme),
          SliverToBoxAdapter(
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Column(
                  children: [
                    _buildHeaderSection(theme),
                    _buildContentSections(theme),
                    const SizedBox(height: 100), // Space for FAB
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingActionButton(theme),
    );
  }

  Widget _buildSliverAppBar(ThemeData theme) {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: theme.colorScheme.surface,
      foregroundColor: theme.colorScheme.onSurface,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          widget.summary.topic,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        titlePadding: const EdgeInsets.only(left: 16, bottom: 16, right: 60),
      ),
      actions: [
        IconButton(
          icon: Icon(_isBookmarked ? Icons.bookmark : Icons.bookmark_border),
          onPressed: () {
            HapticFeedback.lightImpact();
            setState(() => _isBookmarked = !_isBookmarked);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                    Text(_isBookmarked ? 'Bookmarked!' : 'Bookmark removed'),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
        PopupMenuButton<String>(
          icon: const Icon(Icons.more_vert),
          onSelected: _handleMenuAction,
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'share',
              child: ListTile(
                leading: Icon(Icons.share),
                title: Text('Share'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'copy',
              child: ListTile(
                leading: Icon(Icons.copy),
                title: Text('Copy to Clipboard'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
            const PopupMenuItem(
              value: 'export',
              child: ListTile(
                leading: Icon(Icons.download),
                title: Text('Export PDF'),
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderSection(ThemeData theme) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutCubic),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animationController,
          curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
        ),
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                theme.colorScheme.primaryContainer,
                theme.colorScheme.primaryContainer.withAlpha(178),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.primary.withAlpha(26),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.summarize,
                      color: theme.colorScheme.onPrimary,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Summary',
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          widget.summary.subject,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onPrimaryContainer
                                .withAlpha(204),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildStatsRow(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsRow(ThemeData theme) {
    final nuggetCount = widget.summary.nuggets.length;
    final subtopicCount = widget.summary.subtopics.length;
    final hasIntro = widget.summary.introduction?.isNotEmpty ?? false;

    return Row(
      children: [
        _buildStatChip(theme, Icons.lightbulb_outline, hasIntro ? '1' : '0',
            'Introduction'),
        const SizedBox(width: 8),
        _buildStatChip(theme, Icons.bolt, nuggetCount.toString(), 'Key Points'),
        const SizedBox(width: 8),
        _buildStatChip(theme, Icons.topic, subtopicCount.toString(), 'Topics'),
      ],
    );
  }

  Widget _buildStatChip(
      ThemeData theme, IconData icon, String count, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withAlpha(229),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: theme.colorScheme.primary),
          const SizedBox(width: 4),
          Text(
            count,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContentSections(ThemeData theme) {
    return Column(
      children: [
        if (widget.summary.introduction?.isNotEmpty ?? false)
          _buildAnimatedSection(
            theme,
            'Introduction',
            Icons.lightbulb_outline,
            Colors.blue,
            0.2,
            _buildIntroductionContent(theme),
          ),
        if (widget.summary.nuggets.isNotEmpty)
          _buildAnimatedSection(
            theme,
            'Key Insights',
            Icons.bolt,
            Colors.orange,
            0.4,
            _buildNuggetsContent(theme),
          ),
        if (widget.summary.subtopics.isNotEmpty)
          _buildAnimatedSection(
            theme,
            'Topics Covered',
            Icons.topic,
            Colors.green,
            0.6,
            _buildSubtopicsContent(theme),
          ),
      ],
    );
  }

  Widget _buildAnimatedSection(
    ThemeData theme,
    String title,
    IconData icon,
    Color accentColor,
    double animationStart,
    Widget content,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(animationStart, animationStart + 0.3,
            curve: Curves.easeOutCubic),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _animationController,
          curve: Interval(animationStart, animationStart + 0.3,
              curve: Curves.easeOut),
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: theme.colorScheme.outline.withAlpha(52),
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withAlpha(13),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: accentColor.withAlpha(26),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: accentColor.withAlpha(229),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: content,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIntroductionContent(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withAlpha(77),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        widget.summary.introduction!,
        style: theme.textTheme.bodyLarge?.copyWith(
          height: 1.6,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Widget _buildNuggetsContent(ThemeData theme) {
    return Column(
      children: widget.summary.nuggets.asMap().entries.map((entry) {
        final index = entry.key;
        final nugget = entry.value;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withAlpha(13),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.green.withAlpha(52),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 2),
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 12,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          nugget,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildSubtopicsContent(ThemeData theme) {
    return Column(
      children: widget.summary.subtopics.asMap().entries.map((entry) {
        final index = entry.key;
        final subtopic = entry.value;

        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest.withAlpha(77),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          subtopic,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildFloatingActionButton(ThemeData theme) {
    return ScaleTransition(
      scale: _fabController,
      child: FloatingActionButton.extended(
        onPressed: () {
          HapticFeedback.mediumImpact();
          _showActionSheet(context);
        },
        icon: const Icon(Icons.share),
        label: const Text('Share'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
    );
  }

  void _showActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outline.withAlpha(102),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share Summary'),
              onTap: () {
                Navigator.pop(context);
                _handleMenuAction('share');
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: const Text('Copy to Clipboard'),
              onTap: () {
                Navigator.pop(context);
                _handleMenuAction('copy');
              },
            ),
            ListTile(
              leading: const Icon(Icons.download),
              title: const Text('Export as PDF'),
              onTap: () {
                Navigator.pop(context);
                _handleMenuAction('export');
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _handleMenuAction(String action) {
    HapticFeedback.lightImpact();

    switch (action) {
      case 'share':
        _shareSummary();
        break;
      case 'copy':
        _copyToClipboard();
        break;
      case 'export':
         _showExportDialog(context);
      break;
    }
  }

  void _shareSummary() async {
    final content = _buildShareContent();
    final result = await SharePlus.instance.share(
      ShareParams(
        text: content,
        subject: 'Summary: ${widget.summary.topic}',
      ),
    );

    // Optional: Handle the result
    switch (result.status) {
      case ShareResultStatus.success:
        print('Content shared successfully');
        break;
      case ShareResultStatus.dismissed:
        print('Share sheet was dismissed');
        break;
      case ShareResultStatus.unavailable:
        print('Share functionality unavailable');
        break;
    }
  }

  void _copyToClipboard() {
    final content = _buildShareContent();
    Clipboard.setData(ClipboardData(text: content));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Summary copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export Summary'),
        content: const Text('Choose a format to export your summary.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _exportSummary(ExportFormat.pdf);
            },
            child: const Text('PDF'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _exportSummary(ExportFormat.docx);
            },
            child: const Text('DOCX'),
          ),
        ],
      ),
    );
  }

 Future<void> _exportSummary(ExportFormat format) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Generating document...')),
      );

      final exportService = ref.read(exportServiceProvider);

      // This now uses the corrected content builder
      final contentToExport = _buildShareContent();

      final filePath = await exportService.exportDocument(
        title: widget.summary.topic,
        content: contentToExport,
        format: format,
      );

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Successfully exported to ${format.name.toUpperCase()}'),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () => exportService.openFile(filePath),
          ),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Export failed: $e')),
      );
    }
  }


  String _buildShareContent() {
    final buffer = StringBuffer();
    final summary = widget.summary; // Use the summary from the widget

    buffer.writeln('📚 Topic: ${summary.topic}');
    buffer.writeln('Subject: ${summary.subject}');
    buffer.writeln('Created: ${DateFormat.yMMMd().format(summary.createdAt)}');
    buffer.writeln();

    if (summary.introduction != null && summary.introduction!.isNotEmpty) {
      buffer.writeln('📖 Introduction');
      buffer.writeln('-' * 20);
      buffer.writeln(summary.introduction);
      buffer.writeln();
    }

    if (summary.nuggets.isNotEmpty) {
      buffer.writeln('💡 Key Insights');
      buffer.writeln('-' * 20);
      for (final nugget in summary.nuggets) {
        buffer.writeln('• $nugget');
      }
      buffer.writeln();
    }

    if (summary.subtopics.isNotEmpty) {
      buffer.writeln('📋 Topics Covered');
      buffer.writeln('-' * 20);
      for (final subtopic in summary.subtopics) {
        buffer.writeln('• $subtopic');
      }
      buffer.writeln();
    }

    return buffer.toString();
  }
}
