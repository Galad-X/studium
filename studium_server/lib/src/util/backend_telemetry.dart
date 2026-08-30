import 'dart:convert';

import 'package:serverpod/serverpod.dart';

class BackendTelemetry {
  /// Encodes an operational event for log/trace collectors.
  ///
  /// Telemetry is deliberately treated as a boundary: callers may pass
  /// provider responses or exception metadata, but credential-like fields are
  /// removed before the event is serialized. This keeps structured logging
  /// useful without turning deployment logs into a secret store.
  static String encode(
    String name, {
    String outcome = 'success',
    Duration? duration,
    Map<String, Object?> fields = const {},
    DateTime? timestamp,
  }) {
    final payload = <String, Object?>{
      'event': name,
      'outcome': outcome,
      'timestamp': (timestamp ?? DateTime.now().toUtc()).toIso8601String(),
      if (duration != null) 'durationMs': duration.inMilliseconds,
      ..._sanitizeMap(fields),
    };
    return jsonEncode(payload);
  }

  static void event(
    Session session,
    String name, {
    String outcome = 'success',
    Duration? duration,
    Map<String, Object?> fields = const {},
  }) {
    session.log(encode(
      name,
      outcome: outcome,
      duration: duration,
      fields: fields,
    ));
  }

  static Map<String, Object?> _sanitizeMap(Map<String, Object?> fields) {
    return fields.map((key, value) {
      if (_isSensitiveKey(key)) {
        return MapEntry(key, '[REDACTED]');
      }
      return MapEntry(key, _sanitizeValue(value));
    });
  }

  static Object? _sanitizeValue(Object? value) {
    if (value is Map<String, Object?>) {
      return _sanitizeMap(value);
    }
    if (value is Map) {
      return value.map((key, nestedValue) {
        final stringKey = key.toString();
        return MapEntry(
          stringKey,
          _isSensitiveKey(stringKey)
              ? '[REDACTED]'
              : _sanitizeValue(nestedValue),
        );
      });
    }
    if (value is Iterable) {
      return value.map(_sanitizeValue).toList(growable: false);
    }
    return value;
  }

  static bool _isSensitiveKey(String key) {
    final normalized = key.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '');
    return normalized.contains('password') ||
        normalized.contains('secret') ||
        normalized.contains('token') ||
        normalized.contains('apikey') ||
        normalized.contains('authorization') ||
        normalized.contains('credential') ||
        normalized.contains('signature');
  }
}
