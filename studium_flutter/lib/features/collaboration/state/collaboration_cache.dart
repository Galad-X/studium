import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// Offline fallback for read-only collaboration data. Server responses stay
/// authoritative and replace cached data whenever connectivity returns.
class CollaborationCache {
  CollaborationCache(this.preferences);
  final SharedPreferencesAsync preferences;

  Future<void> writeList<T>(
    String key,
    List<T> values,
    Map<String, dynamic> Function(T value) encode,
  ) async {
    await preferences.setString(
      key,
      jsonEncode({
        'savedAt': DateTime.now().toUtc().toIso8601String(),
        'items': values.map(encode).toList(),
      }),
    );
  }

  Future<List<T>> readList<T>(
    String key,
    T Function(Map<String, dynamic> value) decode, {
    Duration maxAge = const Duration(hours: 24),
  }) async {
    final raw = await preferences.getString(key);
    if (raw == null) return const [];
    try {
      final value = jsonDecode(raw) as Map<String, dynamic>;
      final savedAt = DateTime.tryParse(value['savedAt'] as String? ?? '');
      if (savedAt == null ||
          DateTime.now().toUtc().difference(savedAt) > maxAge) {
        return const [];
      }
      return (value['items'] as List<dynamic>)
          .map((item) => decode(Map<String, dynamic>.from(item as Map)))
          .toList();
    } catch (_) {
      return const [];
    }
  }
}
