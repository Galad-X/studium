import 'dart:convert';

import 'package:test/test.dart';

import 'package:studium_server/src/util/backend_telemetry.dart';

void main() {
  group('BackendTelemetry', () {
    test('encodes stable operational fields and duration', () {
      final event = jsonDecode(BackendTelemetry.encode(
        'worker.pass.completed',
        outcome: 'success',
        duration: const Duration(milliseconds: 42),
        timestamp: DateTime.utc(2026, 8, 29, 12, 0),
        fields: {'claimed': 3, 'completed': 2},
      )) as Map<String, dynamic>;

      expect(event['event'], 'worker.pass.completed');
      expect(event['outcome'], 'success');
      expect(event['durationMs'], 42);
      expect(event['claimed'], 3);
      expect(event['timestamp'], '2026-08-29T12:00:00.000Z');
    });

    test('redacts sensitive keys recursively without hiding useful fields', () {
      final event = jsonDecode(BackendTelemetry.encode(
        'provider.callback',
        fields: {
          'provider': 'stripe',
          'authorization': 'Bearer secret',
          'nested': {
            'api_key': 'key',
            'status': 'paid',
          },
          'items': [
            {'signature': 'sig', 'id': 'evt_123'},
          ],
        },
        timestamp: DateTime.utc(2026, 8, 29),
      )) as Map<String, dynamic>;

      expect(event['provider'], 'stripe');
      expect(event['authorization'], '[REDACTED]');
      expect(event['nested']['api_key'], '[REDACTED]');
      expect(event['nested']['status'], 'paid');
      expect(event['items'][0]['signature'], '[REDACTED]');
      expect(event['items'][0]['id'], 'evt_123');
    });
  });
}
