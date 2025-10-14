// lib/features/study_material/providers/study_material_provider.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/providers/service_providers.dart';

// 1. Define the state object
class StudyMaterialState {
  final List<StudyMaterial> materials;
  final bool isLoading;
  final String? error;
  final Map<int, String> processingStatuses;


  StudyMaterialState({
    this.materials = const [],
    this.isLoading = false,
    this.error,
    this.processingStatuses = const {},
  });

  StudyMaterialState copyWith({
    List<StudyMaterial>? materials,
    bool? isLoading,
    String? error,
     Map<int, String>? processingStatuses,
  }) {
    return StudyMaterialState(
      materials: materials ?? this.materials,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      processingStatuses: processingStatuses ?? this.processingStatuses,
    );
  }
}

class StudyMaterialNotifier extends StateNotifier<StudyMaterialState> {
  final Ref _ref;
  Timer? _pollingTimer; 

    StudyMaterialNotifier(this._ref)
      : super(StudyMaterialState(isLoading: true)) {
    fetchMaterials();
  }
  Future<void> fetchMaterials() async {
    // When we first fetch materials, we also need to fetch their initial statuses.
    state = state.copyWith(isLoading: true, error: null);
    try {
      final materials =
          await _ref.read(studyMaterialServiceProvider).getMaterials();
      final statuses = <int, String>{};
      for (final material in materials) {
        final status = await _ref
            .read(studyMaterialServiceProvider)
            .getProcessingStatus(material.id!);
        statuses[material.id!] = status?.status ?? 'unknown';
      }

      state = state.copyWith(
        materials: materials,
        isLoading: false,
        processingStatuses: statuses,
      );

      // After fetching, start polling for updates on pending files.
      _startPollingForPendingFiles();
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  void _startPollingForPendingFiles() {
    // Cancel any existing timer to avoid duplicates.
    _pollingTimer?.cancel();

    // Check if there are any files that need status updates.
    final pendingFiles = state.processingStatuses.entries
        .where(
            (entry) => entry.value == 'pending' || entry.value == 'processing')
        .toList();

    if (pendingFiles.isEmpty) {
      return; // No need to poll if everything is done.
    }

    // Start a timer that runs every 10 seconds.
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (timer) async {
     debugPrint("Polling for file processing status...");
      bool didStateChange = false;
      final currentStatuses = Map<int, String>.from(state.processingStatuses);

      for (final entry in pendingFiles) {
        final materialId = entry.key;
        final newStatus = await _ref
            .read(studyMaterialServiceProvider)
            .getProcessingStatus(materialId);

        if (newStatus != null &&
            newStatus.status != currentStatuses[materialId]) {
          currentStatuses[materialId] = newStatus.status;
          didStateChange = true;
        }
      }

      if (didStateChange) {
        state = state.copyWith(processingStatuses: currentStatuses);
        // After updating, check again if we need to continue polling.
        _startPollingForPendingFiles();
      }
    });
  }

  // Make sure to cancel the timer when the provider is disposed!
  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  Future<void> deleteMaterial(int materialId) async {
    try {
      await _ref.read(studyMaterialServiceProvider).deleteMaterial(materialId);
      // Optimistically update the UI
      state = state.copyWith(
        materials: state.materials.where((m) => m.id != materialId).toList(),
      );
    } catch (e) {
      // If error, maybe show a snackbar and refetch to get the correct state
      fetchMaterials();
    }
  }
}

final studyMaterialProvider =
    StateNotifierProvider<StudyMaterialNotifier, StudyMaterialState>((ref) {
  return StudyMaterialNotifier(ref);
});


