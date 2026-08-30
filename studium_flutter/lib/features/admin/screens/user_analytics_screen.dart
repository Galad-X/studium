import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:studium_client/studium_client.dart';
import '../../../services/export_service.dart';
import '../../history/providers/history_providers.dart';
import '../../../core/providers/service_providers.dart';

class UserAnalyticsScreen extends ConsumerStatefulWidget {
  const UserAnalyticsScreen({super.key});

  @override
  ConsumerState<UserAnalyticsScreen> createState() =>
      _UserAnalyticsScreenState();
}

class _UserAnalyticsScreenState extends ConsumerState<UserAnalyticsScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;
  String _selectedFilter = 'all';

  final Map<String, ActivityTypeInfo> _activityTypes = {
    'document_upload': ActivityTypeInfo(
      name: 'Document Upload',
      icon: Icons.upload_file_rounded,
      color: Colors.blue,
    ),
    'summary_generated': ActivityTypeInfo(
      name: 'Summary Generated',
      icon: Icons.summarize_rounded,
      color: Colors.green,
    ),
    'quiz_completed': ActivityTypeInfo(
      name: 'Quiz Completed',
      icon: Icons.quiz_rounded,
      color: Colors.orange,
    ),
    'writing_created': ActivityTypeInfo(
      name: 'Writing Created',
      icon: Icons.edit_note_rounded,
      color: Colors.purple,
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
    final analyticsAsync = ref.watch(userAnalyticsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: _buildAppBar(theme),
      body: SlideTransition(
        position: _slideAnimation,
        child: Column(
          children: [
            _buildStatsHeader(theme, analyticsAsync),
            _buildFilterSection(theme),
            Expanded(
              child: analyticsAsync.when(
                data: (analytics) => _buildAnalyticsList(analytics, theme),
                loading: () => _buildLoadingState(theme),
                error: (err, stack) => _buildErrorState(theme, err),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'My Activity Log',
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            HapticFeedback.lightImpact();
            final analytics = ref.read(userAnalyticsProvider).valueOrNull;
            if (analytics == null || analytics.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No activity to export.')),
              );
              return;
            }
            _exportAnalytics(analytics);
          },
          icon: const Icon(Icons.download_rounded),
        ),
      ],
    );
  }

  Future<void> _exportAnalytics(List<UserAnalytics> analytics) async {
    try {
      final content = analytics
          .map((item) =>
              '${DateFormat.yMMMd().add_jm().format(item.timestamp)} • ${item.action}${item.metadata == null ? '' : ' • ${item.metadata}'}')
          .join('\n');
      final path = await ref.read(exportServiceProvider).exportDocument(
            title:
                'Studium_Activity_${DateFormat('yyyy-MM-dd').format(DateTime.now())}',
            content: content,
            format: ExportFormat.pdf,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Activity exported.'),
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

  Widget _buildStatsHeader(
      ThemeData theme, AsyncValue<List<dynamic>> analyticsAsync) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primaryContainer,
            theme.colorScheme.primaryContainer.withAlpha(77),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withAlpha(52),
        ),
      ),
      child: analyticsAsync.when(
        data: (analytics) {
          final stats = _calculateStats(analytics);
          return Column(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.analytics_rounded,
                    color: theme.colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Activity Overview',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onPrimaryContainer,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Total Activities',
                      value: stats['total'].toString(),
                      icon: Icons.timeline_rounded,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      title: 'This Week',
                      value: stats['thisWeek'].toString(),
                      icon: Icons.calendar_view_week_rounded,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _StatCard(
                      title: 'Today',
                      value: stats['today'].toString(),
                      icon: Icons.today_rounded,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        loading: () => _buildStatsLoading(theme),
        error: (_, __) => _buildStatsError(theme),
      ),
    );
  }

  Widget _buildStatsLoading(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.analytics_rounded,
          color: theme.colorScheme.primary,
          size: 28,
        ),
        const SizedBox(width: 12),
        Text(
          'Loading statistics...',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onPrimaryContainer,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsError(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.error_outline_rounded,
          color: theme.colorScheme.error,
          size: 28,
        ),
        const SizedBox(width: 12),
        Text(
          'Failed to load statistics',
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.error,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterSection(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _FilterChip(
              label: 'All Activities',
              isSelected: _selectedFilter == 'all',
              onTap: () => setState(() => _selectedFilter = 'all'),
            ),
            const SizedBox(width: 8),
            ..._activityTypes.entries.map((entry) {
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
    );
  }

  Widget _buildAnalyticsList(List<dynamic> analytics, ThemeData theme) {
    if (analytics.isEmpty) {
      return _buildEmptyState(theme);
    }

    // Filter and sort analytics
    final filteredAnalytics = analytics.where((log) {
      return _selectedFilter == 'all' || log.action.contains(_selectedFilter);
    }).toList();

    final sortedAnalytics = filteredAnalytics.reversed.toList();

    if (sortedAnalytics.isEmpty) {
      return _buildNoResultsState(theme);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedAnalytics.length,
      itemBuilder: (context, index) {
        return TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 + (index * 50)),
          tween: Tween(begin: 0.0, end: 1.0),
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 20 * (1 - value)),
              child: Opacity(
                opacity: value,
                child: _ActivityCard(
                  log: sortedAnalytics[index],
                  activityTypes: _activityTypes,
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
                Icons.history_rounded,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Activity Yet',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your activity history will appear here as you use the app.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
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
              Icons.filter_list_off_rounded,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No Activities Found',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try selecting a different filter',
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
            'Loading activity log...',
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
              'Failed to Load Activity',
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
                ref.invalidate(userAnalyticsProvider);
              },
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, int> _calculateStats(List<dynamic> analytics) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final weekStart = today.subtract(Duration(days: now.weekday - 1));

    return {
      'total': analytics.length,
      'thisWeek':
          analytics.where((log) => log.timestamp.isAfter(weekStart)).length,
      'today': analytics.where((log) => log.timestamp.isAfter(today)).length,
    };
  }
}

class ActivityTypeInfo {
  final String name;
  final IconData icon;
  final Color color;

  ActivityTypeInfo({
    required this.name,
    required this.icon,
    required this.color,
  });
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface.withAlpha(204),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withAlpha(77),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
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

class _ActivityCard extends StatelessWidget {
  final dynamic log;
  final Map<String, ActivityTypeInfo> activityTypes;

  const _ActivityCard({
    required this.log,
    required this.activityTypes,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activityType = _getActivityType(log.action);
    final typeInfo = activityTypes[activityType];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(52),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: log.metadata != null
              ? () => _showMetadataDialog(context, log)
              : null,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: (typeInfo?.color ?? theme.colorScheme.primary)
                        .withAlpha(26),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    typeInfo?.icon ?? Icons.history_rounded,
                    color: typeInfo?.color ?? theme.colorScheme.primary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        log.action,
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat.yMMMd().add_jm().format(log.timestamp),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (log.metadata != null)
                  Icon(
                    Icons.info_outline_rounded,
                    color: theme.colorScheme.outline,
                    size: 20,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getActivityType(String action) {
    if (action.toLowerCase().contains('upload')) return 'document_upload';
    if (action.toLowerCase().contains('summary')) return 'summary_generated';
    if (action.toLowerCase().contains('quiz')) return 'quiz_completed';
    if (action.toLowerCase().contains('writing')) return 'writing_created';
    return 'other';
  }

  void _showMetadataDialog(BuildContext context, dynamic log) {
    HapticFeedback.lightImpact();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(
              Icons.info_outline_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 12),
            const Text('Activity Details'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Action:',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(log.action),
            const SizedBox(height: 16),
            Text(
              'Timestamp:',
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 4),
            Text(DateFormat.yMMMd().add_jms().format(log.timestamp)),
            if (log.metadata != null) ...[
              const SizedBox(height: 16),
              Text(
                'Additional Details:',
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(log.metadata!),
            ],
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
