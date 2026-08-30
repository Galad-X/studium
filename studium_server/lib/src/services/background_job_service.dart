import 'dart:convert';

import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/backend_telemetry.dart';

class BackgroundJobService {
  static Future<BackgroundJob> enqueue(
    Session session, {
    required String jobType,
    required Map<String, dynamic> payload,
    int maxAttempts = 3,
    DateTime? availableAt,
  }) {
    if (jobType.trim().isEmpty || maxAttempts < 1) {
      throw ArgumentError('Invalid background job configuration.');
    }
    final now = DateTime.now().toUtc();
    return BackgroundJob.db.insertRow(
      session,
      BackgroundJob(
        jobType: jobType.trim(),
        payload: jsonEncode(payload),
        status: 'pending',
        attempts: 0,
        maxAttempts: maxAttempts,
        availableAt: availableAt ?? now,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  static Future<BackgroundJob?> claim(
    Session session,
    int jobId,
    String lockToken,
  ) async {
    if (lockToken.trim().isEmpty) return null;
    return session.db.transaction((transaction) async {
      final job = await BackgroundJob.db.findById(
        session,
        jobId,
        transaction: transaction,
      );
      final now = DateTime.now().toUtc();
      if (job == null ||
          job.status != 'pending' ||
          job.availableAt.isAfter(now) ||
          job.attempts >= job.maxAttempts) {
        BackendTelemetry.event(
          session,
          'background_job_claim_skipped',
          outcome: 'skipped',
          fields: {'jobId': jobId},
        );
        return null;
      }
      job.status = 'processing';
      job.attempts += 1;
      job.lockedAt = now;
      job.lockToken = lockToken;
      job.updatedAt = now;
      BackendTelemetry.event(
        session,
        'background_job_claimed',
        fields: {'jobId': jobId, 'attempt': job.attempts},
      );
      return BackgroundJob.db.updateRow(
        session,
        job,
        transaction: transaction,
      );
    });
  }

  static Future<BackgroundJob> complete(
      Session session, BackgroundJob job) async {
    job.status = 'completed';
    job.lockedAt = null;
    job.lockToken = null;
    job.lastError = null;
    job.updatedAt = DateTime.now().toUtc();
    BackendTelemetry.event(
      session,
      'background_job_completed',
      fields: {'jobId': job.id, 'jobType': job.jobType},
    );
    return BackgroundJob.db.updateRow(session, job);
  }

  static Future<BackgroundJob> fail(
    Session session,
    BackgroundJob job,
    Object error,
  ) async {
    final message = error.toString();
    job.status = job.attempts >= job.maxAttempts ? 'dead_letter' : 'pending';
    job.availableAt = DateTime.now().toUtc().add(
          Duration(seconds: 30 * job.attempts),
        );
    job.lockedAt = null;
    job.lockToken = null;
    job.lastError = message.substring(0, message.length.clamp(0, 2000));
    job.updatedAt = DateTime.now().toUtc();
    BackendTelemetry.event(
      session,
      'background_job_failed',
      outcome: job.status == 'dead_letter' ? 'dead_letter' : 'retry',
      fields: {'jobId': job.id, 'jobType': job.jobType},
    );
    return BackgroundJob.db.updateRow(session, job);
  }

  static Future<int> recoverStaleJobs(
    Session session, {
    Duration staleAfter = const Duration(minutes: 15),
    int limit = 100,
  }) async {
    if (staleAfter.isNegative || limit < 1) {
      throw ArgumentError('Invalid stale-job recovery configuration.');
    }
    final cutoff = DateTime.now().toUtc().subtract(staleAfter);
    final jobs = await BackgroundJob.db.find(
      session,
      where: (t) => t.status.equals('processing'),
      orderBy: (t) => t.lockedAt,
      limit: limit.clamp(1, 500),
    );
    var recovered = 0;
    for (final job in jobs) {
      final lockedAt = job.lockedAt;
      if (lockedAt == null || lockedAt.isAfter(cutoff)) continue;
      job.status = job.attempts >= job.maxAttempts ? 'dead_letter' : 'pending';
      job.lockedAt = null;
      job.lockToken = null;
      job.availableAt = DateTime.now().toUtc();
      job.updatedAt = DateTime.now().toUtc();
      await BackgroundJob.db.updateRow(session, job);
      recovered++;
    }
    return recovered;
  }
}
