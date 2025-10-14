import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/providers/service_providers.dart';

/// A provider that generates a summary for a specific study material.
/// It takes the material ID as an argument.
/// The `.autoDispose` modifier ensures the state is cleared when the
/// summary screen is closed, saving memory.
final summaryProvider =
    FutureProvider.autoDispose.family<Summary, int>((ref, materialId) async {
  final aiService = ref.watch(aiServiceProvider);
  return aiService.generateSummary(materialId);
});
