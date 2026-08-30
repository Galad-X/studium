import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../api/serverpod_client.dart';

class AnalyticsService {
  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<void> log(String action, {String? metadata}) async {
    try {
      if (await _preferences.getBool('settings.analytics_opt_out') ?? false) {
        return;
      }
      await client.analytics.logAction(action, metadata);
    } catch (e) {
      // Don't block UI for analytics failure
      debugPrint('Analytics logging failed: $e');
    }
  }
}
