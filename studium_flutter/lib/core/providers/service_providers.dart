// lib/core/providers/service_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studium_client/studium_client.dart';
import '../../api/serverpod_client.dart';
import '../../features/study_material/providers/study_material_provider.dart';
import '../../features/subscription/services/subscription_service.dart';
import '../../services/export_service.dart';
import '../services/ai_service.dart';
import '../services/analytics_service.dart';
import '../services/notification_service.dart';

import '../services/study_material_service.dart';
import '../services/summary_service.dart';
import '../services/user_service.dart'; // Add this import
import '../../features/collaboration/state/collaboration_cache.dart';

// Provides the global client instance
final clientProvider = Provider<Client>((ref) => client);

final collaborationCacheProvider = Provider<CollaborationCache>((ref) {
  return CollaborationCache(SharedPreferencesAsync());
});
// Provides the AiService instance
final aiServiceProvider =
    Provider((ref) => AiService(ref.watch(clientProvider)));
// Provides the SummaryService instance
final summaryServiceProvider = Provider<SummaryService>((ref) {
  // THE FIX: You must call the constructor of the SummaryService class.
  // The name of the provider (summaryServiceProvider) is different from the class (SummaryService).
  return SummaryService(ref.watch(clientProvider));
});
// Provides the StudyMaterialService instance
final studyMaterialServiceProvider =
    Provider((ref) => StudyMaterialService(ref.watch(clientProvider)));

final studyMaterialProvider =
    StateNotifierProvider<StudyMaterialNotifier, StudyMaterialState>((ref) {
  return StudyMaterialNotifier(ref);
});

final userServiceProvider =
    Provider((ref) => UserService(ref.watch(clientProvider)));

final subscriptionServiceProvider = Provider<SubscriptionService>((ref) {
  return SubscriptionService(ref.watch(clientProvider));
});

final notificationServiceProvider =
    Provider((ref) => NotificationService(ref.watch(clientProvider)));

final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return AnalyticsService();
});

/// Provider for the document export service.
final exportServiceProvider = Provider<ExportService>((ref) {
  return ExportService();
});
