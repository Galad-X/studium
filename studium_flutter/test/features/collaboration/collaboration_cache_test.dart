import 'package:flutter_test/flutter_test.dart';
import 'package:studium_flutter/features/collaboration/state/collaboration_cache.dart';

void main() {
  test('stores and restores typed collaboration lists', () async {
    final cache = CollaborationCache();

    await cache.writeList<int>(
        'numbers', [1, 2, 3], (value) => {'value': value});

    final values = await cache.readList<int>(
      'numbers',
      (json) => json['value'] as int,
    );
    expect(values, [1, 2, 3]);
  });

  test('does not serve expired collaboration data', () async {
    final cache = CollaborationCache();

    await cache.writeList<String>(
        'messages', ['cached'], (value) => {'value': value});

    final values = await cache.readList<String>(
      'messages',
      (json) => json['value'] as String,
      maxAge: Duration.zero,
    );
    expect(values, isEmpty);
  });
}
