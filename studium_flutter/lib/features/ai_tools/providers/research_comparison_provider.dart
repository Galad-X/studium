import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/providers/service_providers.dart';

/// A provider that generates a research comparison for a specific study material.
final researchComparisonProvider = FutureProvider.autoDispose
    .family<ResearchComparison, int>((ref, materialId) async {
  final aiService = ref.watch(aiServiceProvider);
  return aiService.generateResearchComparison(materialId);
});
