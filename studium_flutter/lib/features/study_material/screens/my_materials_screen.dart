// lib/features/study_material/screens/my_materials_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/providers/service_providers.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../../ai_tools/screens/research_comparison_screen.dart';
import '../../ai_tools/screens/summary_screen.dart';
import '../../dashboard/providers/dashboard_provider.dart';
import '../../quiz/screens/start_quiz_screen.dart';
import '../providers/material_filter_provider.dart';
import 'material_detail_screen.dart';
import 'upload_material_screen.dart';

class _SearchAppBar extends ConsumerStatefulWidget
    implements PreferredSizeWidget {
  @override
  ConsumerState<_SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends ConsumerState<_SearchAppBar> {
  bool _isSearching = false;
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filterNotifier = ref.read(materialFilterProvider.notifier);

    if (_isSearching) {
      return AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            setState(() => _isSearching = false);
            _searchController.clear();
            filterNotifier.setSearchQuery('');
          },
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search materials...',
            border: InputBorder.none,
          ),
          onChanged: (query) => filterNotifier.setSearchQuery(query),
        ),
      );
    }

    return AppBar(
      title: const Text('My Study Materials'),
      actions: [
        IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => setState(() => _isSearching = true)),
        IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(studyMaterialProvider)),
      ],
    );
  }
}

class MyMaterialsScreen extends ConsumerWidget {
  const MyMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(studyMaterialProvider);
    final filteredMaterials = ref.watch(filteredMaterialsProvider);
    // final notifier = ref.read(studyMaterialProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: _SearchAppBar(),
      body: state.isLoading
          ? _buildLoadingShimmer() // loading/error/empty views are the same
          : state.error != null
              ? _buildErrorView(context, state.error!,
                  () => ref.invalidate(studyMaterialProvider))
              : Column(
                  // Wrap in a column to add filter chips
                  children: [
                    _FilterChips(), // Add the filter chips UI
                    Expanded(
                      child: filteredMaterials.isEmpty
                          ? const EmptyStateWidget(
                              icon: Icons.search_off,
                              title: "No Matches Found",
                              message:
                                  "No study materials match your current search or filter.")
                          : RefreshIndicator(
                              onRefresh: () async =>
                                  ref.invalidate(studyMaterialProvider),
                              child: ListView.builder(
                                padding: const EdgeInsets.all(8.0),
                                itemCount: filteredMaterials.length,
                                itemBuilder: (context, index) {
                                  final material = filteredMaterials[index];
                                  final status =
                                      state.processingStatuses[material.id!] ??
                                          'unknown';
                                  return _MaterialCard(
                                    material: material,
                                    status: status,
                                    onDelete: () {
                                      ref
                                          .read(studyMaterialProvider.notifier)
                                          .deleteMaterial(material.id!)
                                          .then((_) {
                                        ref.invalidate(dashboardProvider);
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                    ),
                  ],
                ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const UploadMaterialScreen()));
        },
        label: const Text('Upload'),
        icon: const Icon(Icons.upload_file),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) => Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorView(
      BuildContext context, String error, VoidCallback onRetry) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.cloud_off, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          const Text('Failed to load materials',
              style: TextStyle(fontSize: 18)),
          const SizedBox(height: 8),
          Text(error,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
        ],
      ),
    );
  }
}

class _FilterChips extends ConsumerWidget {
  final _chipTypes = const ['pdf', 'docx', 'pptx'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filterState = ref.watch(materialFilterProvider);
    final filterNotifier = ref.read(materialFilterProvider.notifier);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            // "All" chip to clear the filter
            ActionChip(
              label: const Text("All"),
              backgroundColor: filterState.fileTypeFilter == null
                  ? Theme.of(context).colorScheme.secondaryContainer
                  : null,
              onPressed: () => filterNotifier.clearFileTypeFilter(),
            ),
            const SizedBox(width: 8),
            // Chips for each file type
            ..._chipTypes
                .map((type) => Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: FilterChip(
                        label: Text(type.toUpperCase()),
                        selected: filterState.fileTypeFilter == type,
                        onSelected: (selected) {
                          if (selected) {
                            filterNotifier.setFileTypeFilter(type);
                          }
                        },
                      ),
                    ))
                ,
          ],
        ),
      ),
    );
  }
}

class _MaterialCard extends StatelessWidget {
  final StudyMaterial material;
  final String status;
  final VoidCallback onDelete;

  const _MaterialCard(
      {required this.material, required this.status, required this.onDelete});

  IconData _getFileIcon(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'docx':
      case 'doc':
        return Icons.description;
      case 'pptx':
      case 'ppt':
        return Icons.slideshow;
      default:
        return Icons.insert_drive_file;
    }
  }

//Helper to get a widget based on status
  Widget _buildStatusIndicator(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    switch (status) {
      case 'processing':
      case 'pending':
        return Row(
          children: [
            const SizedBox(
                width: 12,
                height: 12,
                child: CircularProgressIndicator(strokeWidth: 2)),
            const SizedBox(width: 8),
            Text(status == 'pending' ? 'Pending...' : 'Processing...',
                style: textTheme.bodySmall),
          ],
        );
      case 'failed':
        return Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 16),
            const SizedBox(width: 8),
            Text('Processing Failed',
                style: textTheme.bodySmall?.copyWith(color: Colors.red)),
          ],
        );
      case 'completed':
        // For 'completed', we can show the file size or just nothing.
        return Text(
          'Uploaded on ${DateFormat.yMMMd().format(material.uploadDate)}',
          style: textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
        );
      default:
        return const SizedBox.shrink(); // Hide for 'unknown' or other states
    }
  }

  bool _areActionsEnabled() {
    return status == 'completed';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _areActionsEnabled() // Only allow tap if processing is complete
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MaterialDetailScreen(material: material),
                  ),
                );
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(_getFileIcon(material.fileType),
                      color: colorScheme.primary, size: 40),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          material.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Uploaded on ${DateFormat.yMMMd().format(material.uploadDate)}',
                          style: textTheme.bodySmall
                              ?.copyWith(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 4),
                        _buildStatusIndicator(context),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    enabled: _areActionsEnabled(),
                    onSelected: (value) {
                      if (value == 'quiz') {
                        // NEW: Navigate to start quiz screen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => StartQuizScreen(material: material),
                          ),
                        );
                      }
                      if (value == 'summary') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => SummaryScreen(
                              materialId: material.id!,
                              materialTitle: material.title,
                            ),
                          ),
                        );
                      } else if (value == 'compare') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ResearchComparisonScreen(
                                    studyMaterialId: material.id!)));
                      } else if (value == 'delete') {
                        onDelete();
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'quiz',
                        child: ListTile(
                            leading: Icon(Icons.quiz),
                            title: Text('Take a Quiz')),
                      ),
                      const PopupMenuItem<String>(
                        value: 'summary',
                        child: ListTile(
                            leading: Icon(Icons.summarize),
                            title: Text('Generate Summary')),
                      ),
                      const PopupMenuItem<String>(
                        value: 'compare',
                        child: ListTile(
                            leading: Icon(Icons.science),
                            title: Text('Research Comparison')),
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem<String>(
                        value: 'delete',
                        child: ListTile(
                            leading: Icon(Icons.delete_outline,
                                color: colorScheme.error),
                            title: Text('Delete',
                                style: TextStyle(color: colorScheme.error))),
                      ),
                    ],
                    icon: Icon(Icons.more_vert,
                        color: _areActionsEnabled() ? null : Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
