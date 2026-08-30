import 'dart:async';
import 'dart:io';

import 'package:serverpod/serverpod.dart';

import 'src/generated/endpoints.dart';
import 'src/generated/protocol.dart';
import 'src/services/background_job_handlers.dart';
import 'src/services/background_worker_process.dart';

/// Starts the durable background worker without opening an API listener.
///
/// Serverpod's maintenance role initializes the database and Redis services
/// but does not start the HTTP/websocket servers. The worker loop then uses
/// ordinary internal sessions to claim and process durable jobs.
Future<void> runWorker(List<String> args) async {
  final pod = Serverpod(
    _maintenanceArgs(args),
    Protocol(),
    Endpoints(),
  );
  await pod.start(runInGuardedZone: false);

  final runtime = BackgroundWorkerProcess(
    pod,
    handlers: BackgroundJobHandlers.defaults(),
    workerId: Platform.environment['STUDIUM_WORKER_ID'] ?? 'worker',
    batchSize: int.tryParse(
          Platform.environment['STUDIUM_WORKER_BATCH_SIZE'] ?? '',
        ) ??
        25,
    pollInterval: Duration(
      seconds: int.tryParse(
            Platform.environment['STUDIUM_WORKER_POLL_SECONDS'] ?? '',
          ) ??
          5,
    ),
  );

  try {
    // Cloud Run Jobs and other schedulers use a bounded invocation. The
    // default remains a long-lived worker for VM/container orchestrators.
    if (Platform.environment['STUDIUM_WORKER_ONCE']?.toLowerCase() == 'true') {
      await runtime.runOnce();
    } else {
      await runtime.runForever();
    }
  } finally {
    await pod.shutdown(exitProcess: false);
  }
}

List<String> _maintenanceArgs(List<String> args) {
  final result = List<String>.of(args);
  if (!result.any((arg) => arg.startsWith('--role='))) {
    result.add('--role=maintenance');
  }
  return result;
}
