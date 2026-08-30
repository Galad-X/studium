import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/providers/service_providers.dart';
import '../providers/history_providers.dart';
import '../../../services/export_service.dart';

class MyWritingsScreen extends ConsumerStatefulWidget {
  const MyWritingsScreen({super.key});

  @override
  ConsumerState<MyWritingsScreen> createState() => _MyWritingsScreenState();
}

class _MyWritingsScreenState extends ConsumerState<MyWritingsScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  String _searchQuery = '';
  String _selectedFilter = 'all';
  bool _sortNewestFirst = true;

  final Map<String, DocumentTypeInfo> _documentTypes = {
    'undergraduate_project': DocumentTypeInfo(
      name: 'Undergraduate Project',
      icon: Icons.school_rounded,
      color: Colors.blue,
    ),
    'dissertation': DocumentTypeInfo(
      name: 'Dissertation',
      icon: Icons.menu_book_rounded,
      color: Colors.purple,
    ),
    'business_plan': DocumentTypeInfo(
      name: 'Business Plan',
      icon: Icons.business_center_rounded,
      color: Colors.green,
    ),
    'field_trip_report': DocumentTypeInfo(
      name: 'Field Trip Report',
      icon: Icons.explore_rounded,
      color: Colors.orange,
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
  Widget build(
    BuildContext context,
  ) {
    final writingsAsync = ref.watch(myWritingsProvider);
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
              child: writingsAsync.when(
                data: (writings) => _buildWritingsList(writings, theme),
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
        'My Writings',
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
          icon: const Icon(Icons.sort_rounded),
        ),
        IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            final writings = ref.read(myWritingsProvider).valueOrNull;
            if (writings == null || writings.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No writings to export.')),
              );
              return;
            }
            _exportAll(writings);
          },
          icon: const Icon(Icons.download_rounded),
        ),
      ],
    );
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
                hintText: 'Search your writings...',
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

          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _FilterChip(
                  label: 'All',
                  isSelected: _selectedFilter == 'all',
                  onTap: () => setState(() => _selectedFilter = 'all'),
                ),
                const SizedBox(width: 8),
                ..._documentTypes.entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _FilterChip(
                      label: entry.value.name,
                      isSelected: _selectedFilter == entry.key,
                      onTap: () => setState(() => _selectedFilter = entry.key),
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

  Widget _buildWritingsList(List<dynamic> writings, ThemeData theme) {
    if (writings.isEmpty) {
      return _buildEmptyState(theme);
    }

    // Filter writings based on search and filter
    final filteredWritings = writings.where((writing) {
      final matchesSearch = _searchQuery.isEmpty ||
          writing.title.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesFilter =
          _selectedFilter == 'all' || writing.type == _selectedFilter;
      return matchesSearch && matchesFilter;
    }).cast<AcademicWriting>().toList()
      ..sort((a, b) => _sortNewestFirst
          ? b.createdAt.compareTo(a.createdAt)
          : a.createdAt.compareTo(b.createdAt));

    if (filteredWritings.isEmpty) {
      return _buildNoResultsState(theme);
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredWritings.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 100)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: _WritingCard(
                  writing: filteredWritings[index],
                  documentTypes: _documentTypes,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    context.pushNamed('writingResult',
                        extra: filteredWritings[index]);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _exportAll(List<AcademicWriting> writings) async {
    try {
      final content = writings.map((writing) => [
            'Title: ${writing.title}',
            'Type: ${writing.type}',
            'Created: ${DateFormat.yMMMd().format(writing.createdAt)}',
            '',
            writing.content,
            '\n========================================\n',
          ].join('\n')).join();
      final path = await ref.read(exportServiceProvider).exportDocument(
            title: 'All_Writings_${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
            content: content,
            format: ExportFormat.pdf,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Writings exported.'),
          action: SnackBarAction(
            label: 'Open',
            onPressed: () => ref.read(exportServiceProvider).openFile(path),
          ),
        ),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Export failed: $error')),
        );
      }
    }
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
                Icons.edit_note_rounded,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Writings Yet',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your AI-generated academic writings will appear here. Start by creating your first document!',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: () {
                HapticFeedback.mediumImpact();
                context.goNamed('writer');
              },
              icon: const Icon(Icons.add_rounded),
              label: const Text('Create First Writing'),
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
            'Loading your writings...',
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
              'Failed to Load Writings',
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
                ref.invalidate(myWritingsProvider);
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
        context.goNamed('writer');
      },
      icon: const Icon(Icons.add_rounded),
      label: const Text('New Writing'),
      backgroundColor: theme.colorScheme.primary,
      foregroundColor: theme.colorScheme.onPrimary,
    );
  }
}

class DocumentTypeInfo {
  final String name;
  final IconData icon;
  final Color color;
  final String? description;
  final String? estimatedTime;

  DocumentTypeInfo({
    required this.name,
    required this.icon,
    required this.color,
    this.description,
    this.estimatedTime,
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

class _WritingCard extends StatelessWidget {
  final dynamic writing;
  final Map<String, DocumentTypeInfo> documentTypes;
  final VoidCallback onTap;

  const _WritingCard({
    required this.writing,
    required this.documentTypes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final typeInfo = documentTypes[writing.type];

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
                        color: (typeInfo?.color ?? theme.colorScheme.primary)
                            .withAlpha(26),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        typeInfo?.icon ?? Icons.article_rounded,
                        color: typeInfo?.color ?? theme.colorScheme.primary,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            writing.title,
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
                              color:
                                  (typeInfo?.color ?? theme.colorScheme.primary)
                                      .withAlpha(26),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              typeInfo?.name ?? writing.type,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: typeInfo?.color ??
                                    theme.colorScheme.primary,
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
                      DateFormat.yMMMd().format(writing.createdAt),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondaryContainer,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.text_fields_rounded,
                            size: 12,
                            color: theme.colorScheme.onSecondaryContainer,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${writing.wordCount ?? 0}w',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
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
