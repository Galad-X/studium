import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:intl/intl.dart';
import 'package:studium_client/studium_client.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/providers/service_providers.dart';
import '../../../services/export_service.dart';
import '../providers/history_providers.dart';

class MySummariesScreen extends ConsumerStatefulWidget {
  const MySummariesScreen({super.key});

  @override
  ConsumerState<MySummariesScreen> createState() => _MySummariesScreenState();
}

class _MySummariesScreenState extends ConsumerState<MySummariesScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  String _searchQuery = '';
  String _selectedSubject = 'all';
  bool _sortNewestFirst = true;

  final Map<String, SubjectInfo> _subjects = {
    'mathematics': SubjectInfo(
      name: 'Mathematics',
      icon: Icons.calculate_rounded,
      color: Colors.blue,
    ),
    'science': SubjectInfo(
      name: 'Science',
      icon: Icons.science_rounded,
      color: Colors.green,
    ),
    'history': SubjectInfo(
      name: 'History',
      icon: Icons.history_edu_rounded,
      color: Colors.orange,
    ),
    'literature': SubjectInfo(
      name: 'Literature',
      icon: Icons.menu_book_rounded,
      color: Colors.purple,
    ),
    'business': SubjectInfo(
      name: 'Business',
      icon: Icons.business_rounded,
      color: Colors.teal,
    ),
  };

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final summariesAsync = ref.watch(mySummariesProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: _buildAppBar(theme),
      body: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            _buildSearchAndFilter(theme),
            Expanded(
              child: summariesAsync.when(
                data: (summaries) => _buildSummariesList(summaries, theme),
                loading: () => _buildLoadingState(theme),
                error: (err, stack) => _buildErrorState(theme, err),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(theme),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'My Summaries',
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            setState(() => _sortNewestFirst = !_sortNewestFirst);
          },
          tooltip: _sortNewestFirst ? 'Sort oldest first' : 'Sort newest first',
          color: _sortNewestFirst ? theme.colorScheme.primary : null,
          icon: const Icon(Icons.sort_rounded),
        ),
        IconButton(
          onPressed: () {
            final summaries = ref.read(mySummariesProvider).valueOrNull;
            if (summaries != null && summaries.isNotEmpty) {
              _showExportDialog(context, summaries);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No summaries to export.')),
              );
            }
          },
          icon: const Icon(Icons.download_rounded),
        ),
      ],
    );
  }

  void _showExportDialog(BuildContext context, List<dynamic> summaries) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Export All Summaries'),
        content: const Text(
            'Choose a format to export all your summaries as a single document.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _exportAll(summaries, ExportFormat.pdf);
            },
            child: const Text('PDF'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _exportAll(summaries, ExportFormat.docx);
            },
            child: const Text('DOCX'),
          ),
        ],
      ),
    );
  }

  Future<void> _exportAll(List<dynamic> summaries, ExportFormat format) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Generating document...')),
      );

      final exportService = ref.read(exportServiceProvider);

      // Combine all summaries into a single string using the correct fields
      final combinedContent = summaries.map((s) {
        final summary = s as Summary; // Cast to the correct type
        final buffer = StringBuffer();

        // Build the content for a single summary
        buffer.writeln('Topic: ${summary.topic}');
        buffer.writeln('Subject: ${summary.subject}');
        buffer.writeln();

        if (summary.introduction != null && summary.introduction!.isNotEmpty) {
          buffer.writeln('Introduction');
          buffer.writeln('-' * 20);
          buffer.writeln(summary.introduction);
          buffer.writeln();
        }

        if (summary.subtopics.isNotEmpty) {
          buffer.writeln('Topics Covered');
          buffer.writeln('-' * 20);
          for (final subtopic in summary.subtopics) {
            buffer.writeln('• $subtopic');
          }
          buffer.writeln();
        }

        if (summary.nuggets.isNotEmpty) {
          buffer.writeln('Key Insights');
          buffer.writeln('-' * 20);
          for (final nugget in summary.nuggets) {
            buffer.writeln('• $nugget');
          }
          buffer.writeln();
        }

        // Add a separator between summaries
        buffer.writeln('\n========================================\n');

        return buffer.toString();
      }).join();

      final title =
          'All_Summaries_${DateFormat('yyyy-MM-dd').format(DateTime.now())}';

      final filePath = await exportService.exportDocument(
        title: title,
        content: combinedContent,
        format: format,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Successfully exported all summaries!'),
            action: SnackBarAction(
              label: 'Open',
              onPressed: () => exportService.openFile(filePath),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $e')),
        );
      }
    }
  }

  Widget _buildSearchAndFilter(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.colorScheme.outline.withAlpha(52),
              ),
            ),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: 'Search summaries...',
                prefixIcon: const Icon(Icons.search_rounded),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.transparent,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Subject filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: 'All Subjects',
                  isSelected: _selectedSubject == 'all',
                  onTap: () => setState(() => _selectedSubject = 'all'),
                ),
                const SizedBox(width: 8),
                ..._subjects.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _FilterChip(
                      label: entry.value.name,
                      isSelected: _selectedSubject == entry.key,
                      onTap: () => setState(() => _selectedSubject = entry.key),
                      color: entry.value.color,
                    ),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummariesList(List<dynamic> summaries, ThemeData theme) {
    if (summaries.isEmpty) {
      return _buildEmptyState(theme);
    }

    // Filter summaries based on search and subject
    final filteredSummaries = summaries.where((summary) {
      final matchesSearch = _searchQuery.isEmpty ||
          summary.topic.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          summary.subject.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesSubject = _selectedSubject == 'all' ||
          summary.subject.toLowerCase() == _selectedSubject;
      return matchesSearch && matchesSubject;
    }).cast<Summary>().toList()
      ..sort((a, b) => _sortNewestFirst
          ? b.createdAt.compareTo(a.createdAt)
          : a.createdAt.compareTo(b.createdAt));

    if (filteredSummaries.isEmpty) {
      return _buildNoResultsState(theme);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredSummaries.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: _SummaryCard(
                  summary: filteredSummaries[index],
                  subjects: _subjects,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    _showSummaryPreview(context, filteredSummaries[index]);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer.withAlpha(77),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.summarize_rounded,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Summaries Yet',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your generated summaries will appear here. Upload a document to get started!',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                HapticFeedback.mediumImpact();
                _slideController.forward().then((_) {
                  _slideController.reverse();
                });

                context.pushNamed('uploadMaterial');
              },
              icon: const Icon(Icons.upload_file_rounded),
              label: const Text('Upload Document'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoResultsState(ThemeData theme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off_rounded,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No Results Found',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try adjusting your search or filter criteria',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
          ),
          const SizedBox(height: 24),
          Text(
            'Loading your summaries...',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to Load Summaries',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () {
                HapticFeedback.lightImpact();
                ref.invalidate(mySummariesProvider);
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(ThemeData theme) {
    return FloatingActionButton.extended(
      onPressed: () {
        HapticFeedback.mediumImpact();
        _slideController.forward().then((_) {
          _slideController.reverse();
        });

        context.pushNamed('uploadMaterial');
      },
      icon: const Icon(Icons.add_rounded),
      label: const Text('New Summary'),
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
    );
  }

  void _showSummaryPreview(BuildContext context, dynamic summary) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SummaryPreviewSheet(
        summary: summary,
        subjects: _subjects,
      ),
    );
  }
}

class SubjectInfo {
  final String name;
  final IconData icon;
  final Color color;

  SubjectInfo({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final Color? color;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final chipColor = color ?? theme.colorScheme.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (_) {
          HapticFeedback.selectionClick();
          onTap();
        },
        backgroundColor: theme.colorScheme.surfaceContainerHighest,
        selectedColor: chipColor.withAlpha(52),
        checkmarkColor: chipColor,
        labelStyle: TextStyle(
          color: isSelected ? chipColor : theme.colorScheme.onSurfaceVariant,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
        ),
        side: BorderSide(
          color:
              isSelected ? chipColor : theme.colorScheme.outline.withAlpha(77),
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final dynamic summary;
  final Map<String, SubjectInfo> subjects;
  final VoidCallback onTap;

  const _SummaryCard({
    required this.summary,
    required this.subjects,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subjectInfo = subjects[summary.subject.toLowerCase()];

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(52),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            (subjectInfo?.color ?? theme.colorScheme.secondary)
                                .withAlpha(26),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        subjectInfo?.icon ?? Icons.summarize_rounded,
                        color:
                            subjectInfo?.color ?? theme.colorScheme.secondary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            summary.topic,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: (subjectInfo?.color ??
                                      theme.colorScheme.secondary)
                                  .withAlpha(26),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              summary.subject,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: subjectInfo?.color ??
                                    theme.colorScheme.secondary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: theme.colorScheme.outline,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Summary preview
                if (summary.content != null) ...[
                  Text(
                    summary.content,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                ],

                // Metadata row
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 16,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      DateFormat.yMMMd().format(summary.createdAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.visibility_rounded,
                            size: 12,
                            color: theme.colorScheme.onTertiaryContainer,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'View',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onTertiaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SummaryPreviewSheet extends StatelessWidget {
  final dynamic summary;
  final Map<String, SubjectInfo> subjects;

  const _SummaryPreviewSheet({
    required this.summary,
    required this.subjects,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final subjectInfo = subjects[summary.subject.toLowerCase()];

    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: theme.colorScheme.outline.withAlpha(77),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (subjectInfo?.color ?? theme.colorScheme.secondary)
                        .withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    subjectInfo?.icon ?? Icons.summarize_rounded,
                    color: subjectInfo?.color ?? theme.colorScheme.secondary,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        summary.topic,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${summary.subject} • ${DateFormat.yMMMd().format(summary.createdAt)}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (summary.content != null) ...[
                    Text(
                      'Summary',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: theme.colorScheme.outline.withAlpha(52),
                        ),
                      ),
                      child: Text(
                        summary.content,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),

          // Actions
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outline.withAlpha(52),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                child: OutlinedButton.icon(
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      await _shareSummary(context);
                    },
                    icon: const Icon(Icons.share_rounded),
                    label: const Text('Share'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                child: FilledButton.icon(
                    onPressed: () async {
                      HapticFeedback.lightImpact();
                      await _exportSummary(context);
                    },
                    icon: const Icon(Icons.download_rounded),
                    label: const Text('Export'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _summaryText() => [
        'Topic: ${summary.topic}',
        'Subject: ${summary.subject}',
        '',
        summary.content ?? '',
      ].join('\n');

  Future<void> _shareSummary(BuildContext context) async {
    await SharePlus.instance.share(ShareParams(text: _summaryText(), subject: summary.topic));
  }

  Future<void> _exportSummary(BuildContext context) async {
    try {
      final path = await ExportService().exportDocument(
        title: summary.topic,
        content: _summaryText(),
        format: ExportFormat.pdf,
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Summary exported.'),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () => ExportService().openFile(path),
          ),
        ),
      );
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $error')),
        );
      }
    }
  }
}
