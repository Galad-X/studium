import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/backend_telemetry.dart';
import 'background_job_service.dart';

class OpportunitySourceRefreshService {
  static const defaultRefreshInterval = Duration(hours: 24);

  /// Claims due verified sources by advancing their schedule atomically.
  /// A worker can then fetch each returned source and call [markSuccess] or
  /// [markFailure]. The schedule is advanced before network work so multiple
  /// workers cannot continuously claim the same source.
  static Future<List<OpportunitySource>> claimDueSources(
    Session session, {
    int limit = 25,
    DateTime? now,
  }) async {
    if (limit < 1) throw ArgumentError('Refresh limit must be positive.');
    final current = (now ?? DateTime.now()).toUtc();
    return session.db.transaction((transaction) async {
      final sources = await OpportunitySource.db.find(
        session,
        where: (t) => t.verificationStatus.equals('verified'),
        orderBy: (t) => t.nextSyncAt,
        limit: (limit * 4).clamp(1, 200),
        transaction: transaction,
        lockMode: LockMode.forUpdate,
        lockBehavior: LockBehavior.skipLocked,
      );
      final due = <OpportunitySource>[];
      for (final source in sources) {
        final nextSyncAt = source.nextSyncAt;
        if (nextSyncAt != null && nextSyncAt.isAfter(current)) continue;
        source.nextSyncAt = current.add(defaultRefreshInterval);
        source.lastSyncStatus = 'scheduled';
        source.lastSyncError = null;
        source.updatedAt = current;
        due.add(await OpportunitySource.db.updateRow(
          session,
          source,
          transaction: transaction,
        ));
        if (due.length == limit) break;
      }
      BackendTelemetry.event(
        session,
        'opportunity_source_refresh_claimed',
        fields: {'count': due.length},
      );
      return due;
    });
  }

  static Future<OpportunitySource> markSuccess(
    Session session,
    OpportunitySource source, {
    DateTime? syncedAt,
  }) async {
    final now = (syncedAt ?? DateTime.now()).toUtc();
    source.lastSyncedAt = now;
    source.nextSyncAt = now.add(defaultRefreshInterval);
    source.lastSyncStatus = 'succeeded';
    source.lastSyncError = null;
    source.staleAt = null;
    source.updatedAt = now;
    return OpportunitySource.db.updateRow(session, source);
  }

  static Future<OpportunitySource> markFailure(
    Session session,
    OpportunitySource source,
    Object error, {
    DateTime? failedAt,
  }) async {
    final now = (failedAt ?? DateTime.now()).toUtc();
    final message = error.toString();
    source.lastSyncStatus = 'failed';
    source.lastSyncError = message.substring(0, message.length.clamp(0, 2000));
    source.nextSyncAt = now.add(const Duration(hours: 1));
    source.staleAt ??= now;
    source.updatedAt = now;
    BackendTelemetry.event(
      session,
      'opportunity_source_refresh_failed',
      outcome: 'failed',
      fields: {'sourceId': source.id},
    );
    return OpportunitySource.db.updateRow(session, source);
  }

  static Future<int> enqueueDueRefreshJobs(
    Session session, {
    int limit = 25,
    DateTime? now,
  }) async {
    final dueSources = await claimDueSources(session, limit: limit, now: now);
    for (final source in dueSources) {
      await BackgroundJobService.enqueue(
        session,
        jobType: 'opportunity_source.refresh',
        payload: {'sourceId': source.id},
      );
    }
    return dueSources.length;
  }

  /// Refreshes one already-claimed source without relying on endpoint auth.
  /// This is the worker-only counterpart to the moderator-triggered endpoint.
  static Future<int> refreshSource(Session session, int sourceId) async {
    final source = await OpportunitySource.db.findById(session, sourceId);
    if (source == null || source.verificationStatus != 'verified') {
      throw StateError('Verified opportunity source not found.');
    }
    try {
      final response = await http
          .get(Uri.parse(source.feedUrl))
          .timeout(const Duration(seconds: 15));
      if (response.statusCode != 200 ||
          response.body.length > 2 * 1024 * 1024) {
        throw StateError('Opportunity source feed could not be downloaded.');
      }
      final decoded = jsonDecode(response.body);
      final records = decoded is List<dynamic>
          ? decoded
          : (decoded is Map<String, dynamic> ? decoded['opportunities'] : null);
      if (records is! List<dynamic> || records.length > 100) {
        throw FormatException(
            'Opportunity source feed format or size is invalid.');
      }
      var imported = 0;
      final seen = <String>{};
      for (final raw in records) {
        if (raw is! Map<String, dynamic>) {
          throw FormatException(
              'Opportunity source contains an invalid record.');
        }
        final externalId = '${raw['externalId'] ?? ''}'.trim();
        final deadline = DateTime.tryParse('${raw['deadline'] ?? ''}');
        final officialUrl = '${raw['officialUrl'] ?? ''}'.trim();
        final parsedUrl = Uri.tryParse(officialUrl);
        final type = '${raw['opportunityType'] ?? ''}';
        const allowedTypes = {
          'scholarship',
          'fellowship',
          'grant',
          'competition',
          'internship',
          'conference',
          'exchange',
        };
        if (externalId.isEmpty ||
            deadline == null ||
            deadline.isBefore(DateTime.now()) ||
            !allowedTypes.contains(type) ||
            officialUrl.length > 2000 ||
            parsedUrl == null ||
            !{'http', 'https'}.contains(parsedUrl.scheme) ||
            parsedUrl.host.isEmpty) {
          throw FormatException(
              'Opportunity source contains an invalid record.');
        }
        final title = '${raw['title'] ?? ''}'.trim();
        final provider = '${raw['provider'] ?? source.provider}'.trim();
        final country = '${raw['country'] ?? ''}'.trim();
        final field = '${raw['field'] ?? ''}'.trim();
        final level = '${raw['educationLevel'] ?? ''}'.trim();
        final funding = '${raw['fundingDetails'] ?? ''}'.trim();
        if (title.isEmpty ||
            provider != source.provider ||
            country.isEmpty ||
            field.isEmpty ||
            level.isEmpty ||
            funding.isEmpty) {
          throw FormatException(
              'Opportunity source contains an invalid record.');
        }
        final now = DateTime.now().toUtc();
        await session.db.transaction((transaction) async {
          final existing = await Opportunity.db.findFirstRow(
            session,
            where: (t) =>
                t.sourceId.equals(sourceId) & t.externalId.equals(externalId),
            transaction: transaction,
          );
          if (existing == null) {
            await Opportunity.db.insertRow(
                session,
                Opportunity(
                  title: title,
                  opportunityType: type,
                  provider: provider,
                  country: country,
                  eligibilityRegion: raw['eligibilityRegion']?.toString(),
                  field: field,
                  educationLevel: level,
                  deadline: deadline,
                  fundingDetails: funding,
                  officialUrl: officialUrl,
                  verificationStatus: 'verified',
                  sourceId: sourceId,
                  externalId: externalId,
                  createdAt: now,
                  lastSeenAt: now,
                  updatedAt: now,
                ),
                transaction: transaction);
          } else {
            existing.title = title;
            existing.deadline = deadline;
            existing.fundingDetails = funding;
            existing.officialUrl = officialUrl;
            existing.lastSeenAt = now;
            existing.staleAt = null;
            existing.verificationStatus = 'verified';
            existing.updatedAt = now;
            await Opportunity.db
                .updateRow(session, existing, transaction: transaction);
          }
        });
        seen.add(externalId);
        imported++;
      }
      await markMissingRecordsStale(session, sourceId, seen);
      await markSuccess(session, source);
      return imported;
    } catch (error) {
      await markFailure(session, source, error);
      rethrow;
    }
  }

  static Future<int> markMissingRecordsStale(
    Session session,
    int sourceId,
    Set<String> seenExternalIds, {
    DateTime? at,
  }) async {
    final now = (at ?? DateTime.now()).toUtc();
    final opportunities = await Opportunity.db.find(
      session,
      where: (t) => t.sourceId.equals(sourceId),
      limit: 500,
    );
    var marked = 0;
    for (final opportunity in opportunities) {
      final externalId = opportunity.externalId;
      if (externalId != null && seenExternalIds.contains(externalId)) {
        opportunity.lastSeenAt = now;
        opportunity.staleAt = null;
        if (opportunity.verificationStatus == 'stale') {
          opportunity.verificationStatus = 'verified';
        }
      } else if (opportunity.verificationStatus == 'verified') {
        opportunity.staleAt = now;
        opportunity.verificationStatus = 'stale';
        marked++;
      }
      opportunity.updatedAt = now;
      await Opportunity.db.updateRow(session, opportunity);
    }
    BackendTelemetry.event(
      session,
      'opportunity_records_marked_stale',
      fields: {'sourceId': sourceId, 'count': marked},
    );
    return marked;
  }
}
