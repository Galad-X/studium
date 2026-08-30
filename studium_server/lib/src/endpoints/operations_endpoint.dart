import 'package:serverpod/server.dart';

import '../generated/protocol.dart';

class OperationsEndpoint extends Endpoint {
  @override
  bool get requireLogin => true;

  Future<Map<String, int>> getQueueHealth(Session session) async {
    await _requirePlatformAdmin(session);

    return {
      'backgroundPending': await BackgroundJob.db.count(
        session,
        where: (t) => t.status.equals('pending'),
      ),
      'backgroundProcessing': await BackgroundJob.db.count(
        session,
        where: (t) => t.status.equals('processing'),
      ),
      'backgroundDeadLetter': await BackgroundJob.db.count(
        session,
        where: (t) => t.status.equals('dead_letter'),
      ),
      'emailPending': await EmailDelivery.db.count(
        session,
        where: (t) => t.status.equals('pending'),
      ),
      'emailProcessing': await EmailDelivery.db.count(
        session,
        where: (t) => t.status.equals('processing'),
      ),
      'emailDeadLetter': await EmailDelivery.db.count(
        session,
        where: (t) => t.status.equals('dead_letter'),
      ),
      'pushPending': await PushDelivery.db.count(
        session,
        where: (t) => t.status.equals('pending'),
      ),
      'pushProcessing': await PushDelivery.db.count(
        session,
        where: (t) => t.status.equals('processing'),
      ),
      'pushDeadLetter': await PushDelivery.db.count(
        session,
        where: (t) => t.status.equals('dead_letter'),
      ),
    };
  }

  Future<Map<String, int>> getSchedulerHealth(Session session) async {
    await _requirePlatformAdmin(session);
    final now = DateTime.now().toUtc();
    return {
      'verifiedSources': await OpportunitySource.db.count(
        session,
        where: (t) => t.verificationStatus.equals('verified'),
      ),
      'sourcesDue': await OpportunitySource.db.count(
        session,
        where: (t) =>
            t.verificationStatus.equals('verified') & (t.nextSyncAt < now),
      ),
      'sourcesNeverSynced': await OpportunitySource.db.count(
        session,
        where: (t) =>
            t.verificationStatus.equals('verified') & t.nextSyncAt.equals(null),
      ),
      'sourcesFailed': await OpportunitySource.db.count(
        session,
        where: (t) => t.lastSyncStatus.equals('failed'),
      ),
      'sourcesStale': await OpportunitySource.db.count(
        session,
        where: (t) => t.staleAt.notEquals(null),
      ),
      'refreshJobsPending': await BackgroundJob.db.count(
        session,
        where: (t) =>
            t.jobType.equals('opportunity_source.refresh') &
            t.status.equals('pending'),
      ),
      'refreshJobsDeadLetter': await BackgroundJob.db.count(
        session,
        where: (t) =>
            t.jobType.equals('opportunity_source.refresh') &
            t.status.equals('dead_letter'),
      ),
    };
  }

  Future<void> _requirePlatformAdmin(Session session) async {
    final userId = int.tryParse(session.authenticated?.userIdentifier ?? '');
    if (userId == null) throw Exception('User not authenticated.');
    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    if (profile?.role != 'admin') {
      throw Exception('Platform admin role required.');
    }
  }
}
