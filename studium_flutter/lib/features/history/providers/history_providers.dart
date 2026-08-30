// lib/features/history/providers/history_providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import '../../../api/serverpod_client.dart';

// Provider to fetch all academic writings
final myWritingsProvider =
    FutureProvider.autoDispose<List<AcademicWriting>>((ref) async {
  return client.academicWriting.getWritings();
});

// Provider to fetch all summaries
final mySummariesProvider =
    FutureProvider.autoDispose<List<Summary>>((ref) async {
  return client.summary.getSummaries();
});

// Provider for user analytics
final userAnalyticsProvider =
    FutureProvider.autoDispose<List<UserAnalytics>>((ref) async {
  return client.analytics.getAnalytics();
});
