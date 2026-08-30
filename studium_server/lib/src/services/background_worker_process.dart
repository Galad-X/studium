import 'dart:async';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import '../util/backend_telemetry.dart';
import 'background_worker_service.dart';
import 'opportunity_source_refresh_service.dart';

/// Long-running process boundary for durable background work.
///
/// Each pass creates and closes its own internal session. Claims and state
/// transitions remain database-backed, so multiple replicas can run safely.
class BackgroundWorkerProcess {
  BackgroundWorkerProcess(
    this.server, {
    required this.handlers,
    required this.workerId,
    this.batchSize = 25,
    this.pollInterval = const Duration(seconds: 5),
  })  : assert(batchSize > 0),
        assert(!pollInterval.isNegative);

  final Serverpod server;
  final Map<String, BackgroundJobHandler> handlers;
  final String workerId;
  final int batchSize;
  final Duration pollInterval;

  bool _stopRequested = false;

  Future<int> runOnce() async {
    final session = await server.createSession(enableLogging: false);
    try {
      await OpportunitySourceRefreshService.enqueueDueRefreshJobs(
        session,
        limit: batchSize,
      );
      final processed = await BackgroundWorkerService.runOnce(
        session,
        workerId: workerId,
        handlers: handlers,
        limit: batchSize,
      );
      BackendTelemetry.event(
        session,
        'background_worker_pass_completed',
        fields: {
          'workerId': workerId,
          'processed': processed,
        },
      );
      return processed;
    } finally {
      await session.close();
    }
  }

  Future<void> runForever() async {
    _stopRequested = false;
    final subscriptions = <StreamSubscription<ProcessSignal>>[
      ProcessSignal.sigint.watch().listen((_) => requestStop()),
    ];
    if (!Platform.isWindows) {
      subscriptions.add(
        ProcessSignal.sigterm.watch().listen((_) => requestStop()),
      );
    }
    try {
      while (!_stopRequested) {
        try {
          await runOnce();
        } catch (error, stackTrace) {
          stderr.writeln('Background worker pass failed: $error');
          stderr.writeln(stackTrace);
        }
        if (!_stopRequested) await Future<void>.delayed(pollInterval);
      }
    } finally {
      for (final subscription in subscriptions) {
        await subscription.cancel();
      }
    }
  }

  void requestStop() => _stopRequested = true;
}
