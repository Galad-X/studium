import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import 'background_job_service.dart';

typedef BackgroundJobHandler = Future<void> Function(
  Session session,
  BackgroundJob job,
  Map<String, dynamic> payload,
);

class BackgroundWorkerService {
  /// Processes up to [limit] due jobs in one bounded worker pass.
  ///
  /// Jobs are claimed transactionally before handlers run. Handler failures
  /// are persisted through the normal retry/dead-letter transition, allowing
  /// a later worker pass to continue without losing work.
  static Future<int> runOnce(
    Session session, {
    required String workerId,
    required Map<String, BackgroundJobHandler> handlers,
    int limit = 25,
    Duration staleAfter = const Duration(minutes: 15),
  }) async {
    final normalizedWorkerId = workerId.trim();
    if (normalizedWorkerId.isEmpty || limit < 1) {
      throw ArgumentError('Invalid background worker configuration.');
    }
    await BackgroundJobService.recoverStaleJobs(
      session,
      staleAfter: staleAfter,
      limit: limit,
    );
    final pending = await BackgroundJob.db.find(
      session,
      where: (t) => t.status.equals('pending'),
      orderBy: (t) => t.availableAt,
      orderDescending: false,
      limit: limit.clamp(1, 100),
    );
    var processed = 0;
    for (final candidate in pending) {
      final claimed = await BackgroundJobService.claim(
        session,
        candidate.id!,
        '$normalizedWorkerId-${candidate.id}',
      );
      if (claimed == null) continue;
      processed++;
      final handler = handlers[claimed.jobType];
      try {
        if (handler == null) {
          throw StateError('No handler registered for ${claimed.jobType}.');
        }
        final decoded = jsonDecode(claimed.payload);
        if (decoded is! Map<String, dynamic>) {
          throw FormatException('Background job payload must be an object.');
        }
        await handler(session, claimed, decoded);
        await BackgroundJobService.complete(session, claimed);
      } catch (error) {
        await BackgroundJobService.fail(session, claimed, error);
      }
    }
    return processed;
  }
}
