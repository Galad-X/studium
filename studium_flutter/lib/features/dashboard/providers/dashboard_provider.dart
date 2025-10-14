import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/providers/service_providers.dart';

/// Provides the data needed for the dashboard screen.
/// It fetches the user's study history and details of recent items.
final dashboardProvider =
    FutureProvider.autoDispose<DashboardBundle>((ref) async {
  final userService = ref.watch(userServiceProvider);
  return userService.getDashboardBundle();
});
