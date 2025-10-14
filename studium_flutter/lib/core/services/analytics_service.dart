import 'package:flutter/foundation.dart';

import '../../api/serverpod_client.dart';


class AnalyticsService {
  Future<void> log(String action, {String? metadata}) async {
    try {
      await client.analytics.logAction(action, metadata);
    } catch (e) {
      // Don't block UI for analytics failure
      debugPrint('Analytics logging failed: $e');
    }
  }
}
