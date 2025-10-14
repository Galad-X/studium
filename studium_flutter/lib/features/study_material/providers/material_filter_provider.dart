import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import 'study_material_provider.dart';

// State for our filter
class MaterialFilterState {
  final String searchQuery;
  final String? fileTypeFilter;

  MaterialFilterState({this.searchQuery = '', this.fileTypeFilter});

  MaterialFilterState copyWith(
      {String? searchQuery, String? fileTypeFilter, bool clearFilter = false}) {
    return MaterialFilterState(
      searchQuery: searchQuery ?? this.searchQuery,
      fileTypeFilter:
          clearFilter ? null : fileTypeFilter ?? this.fileTypeFilter,
    );
  }
}

// Notifier to manage the filter state
class MaterialFilterNotifier extends StateNotifier<MaterialFilterState> {
  MaterialFilterNotifier() : super(MaterialFilterState());

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void setFileTypeFilter(String? type) {
    state = state.copyWith(fileTypeFilter: type);
  }

  void clearFileTypeFilter() {
    state = state.copyWith(clearFilter: true);
  }
}

final materialFilterProvider =
    StateNotifierProvider<MaterialFilterNotifier, MaterialFilterState>((ref) {
  return MaterialFilterNotifier();
});

// A new provider that combines the main material list with the current filter state
// to produce the final, visible list of materials.
final filteredMaterialsProvider = Provider<List<StudyMaterial>>((ref) {
  // Watch both the full list of materials and the filter state
  final materialsState = ref.watch(studyMaterialProvider);
  final filterState = ref.watch(materialFilterProvider);

  List<StudyMaterial> materials = materialsState.materials;

  // Apply search query filter
  if (filterState.searchQuery.isNotEmpty) {
    materials = materials
        .where((m) => m.title
            .toLowerCase()
            .contains(filterState.searchQuery.toLowerCase()))
        .toList();
  }

  // Apply file type filter
  if (filterState.fileTypeFilter != null) {
    materials = materials
        .where((m) => m.fileType == filterState.fileTypeFilter)
        .toList();
  }

  return materials;
});
