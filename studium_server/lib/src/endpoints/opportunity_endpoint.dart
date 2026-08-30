import 'package:serverpod/serverpod.dart';

import '../generated/protocol.dart';
import '../util/endpoint_utils.dart';
import '../services/opportunity_source_refresh_service.dart';

class OpportunityEndpoint extends Endpoint with EndpointUtils {
  @override
  bool get requireLogin => true;

  static const _trackerStatuses = {
    'interested',
    'drafting',
    'applied',
    'shortlisted',
    'awarded',
    'rejected',
    'withdrawn',
  };

  Future<OpportunitySource> registerOpportunitySource(
    Session session,
    String name,
    String provider,
    String feedUrl,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    await _requirePlatformModerator(session, userId);
    final normalizedUrl = feedUrl.trim();
    final parsedUrl = Uri.tryParse(normalizedUrl);
    if (name.trim().isEmpty ||
        provider.trim().isEmpty ||
        parsedUrl == null ||
        !{'http', 'https'}.contains(parsedUrl.scheme) ||
        parsedUrl.host.isEmpty ||
        normalizedUrl.length > 2000) {
      throw Exception('Invalid opportunity source.');
    }
    final existing = await OpportunitySource.db.findFirstRow(
      session,
      where: (t) => t.feedUrl.equals(normalizedUrl),
    );
    if (existing != null) return existing;
    return OpportunitySource.db.insertRow(
      session,
      OpportunitySource(
        name: name.trim(),
        provider: provider.trim(),
        feedUrl: normalizedUrl,
        verificationStatus: 'verified',
        createdById: userId,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<Opportunity> ingestOpportunity(
    Session session,
    int sourceId,
    String externalId,
    String title,
    String opportunityType,
    String provider,
    String country,
    String? eligibilityRegion,
    String field,
    String educationLevel,
    DateTime deadline,
    String fundingDetails,
    String officialUrl,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    await _requirePlatformModerator(session, userId);
    const allowedTypes = {
      'scholarship',
      'fellowship',
      'grant',
      'competition',
      'internship',
      'conference',
      'exchange',
    };
    if (!allowedTypes.contains(opportunityType) ||
        title.trim().isEmpty ||
        provider.trim().isEmpty ||
        country.trim().isEmpty ||
        field.trim().isEmpty ||
        educationLevel.trim().isEmpty ||
        fundingDetails.trim().isEmpty ||
        deadline.isBefore(DateTime.now())) {
      throw Exception('Invalid ingested opportunity.');
    }
    final normalizedExternalId = externalId.trim();
    if (normalizedExternalId.isEmpty || normalizedExternalId.length > 300) {
      throw Exception('Invalid external opportunity ID.');
    }
    final normalizedUrl = officialUrl.trim();
    final parsedUrl = Uri.tryParse(normalizedUrl);
    if (parsedUrl == null ||
        !{'http', 'https'}.contains(parsedUrl.scheme) ||
        parsedUrl.host.isEmpty ||
        normalizedUrl.length > 2000) {
      throw Exception('Invalid opportunity source URL.');
    }
    return session.db.transaction((transaction) async {
      final source = await OpportunitySource.db.findById(
        session,
        sourceId,
        transaction: transaction,
      );
      if (source == null || source.verificationStatus != 'verified') {
        throw Exception('Verified opportunity source not found.');
      }
      if (provider.trim() != source.provider) {
        throw Exception('Opportunity provider does not match its source.');
      }
      final existing = await Opportunity.db.findFirstRow(
        session,
        where: (t) =>
            t.sourceId.equals(sourceId) &
            t.externalId.equals(normalizedExternalId),
        transaction: transaction,
      );
      final now = DateTime.now();
      source.lastSyncedAt = now;
      source.updatedAt = now;
      await OpportunitySource.db.updateRow(
        session,
        source,
        transaction: transaction,
      );
      if (existing != null) {
        existing.title = title.trim();
        existing.deadline = deadline;
        existing.fundingDetails = fundingDetails.trim();
        existing.officialUrl = normalizedUrl;
        existing.lastSeenAt = now;
        existing.staleAt = null;
        if (existing.verificationStatus == 'stale') {
          existing.verificationStatus = 'verified';
        }
        existing.updatedAt = now;
        return Opportunity.db.updateRow(
          session,
          existing,
          transaction: transaction,
        );
      }
      return Opportunity.db.insertRow(
        session,
        Opportunity(
          title: title.trim(),
          opportunityType: opportunityType,
          provider: provider.trim(),
          country: country.trim(),
          eligibilityRegion: eligibilityRegion?.trim().isEmpty == true
              ? null
              : eligibilityRegion?.trim(),
          field: field.trim(),
          educationLevel: educationLevel.trim(),
          deadline: deadline,
          fundingDetails: fundingDetails.trim(),
          officialUrl: normalizedUrl,
          verificationStatus: 'verified',
          sourceId: sourceId,
          externalId: normalizedExternalId,
          createdAt: now,
          lastSeenAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
    });
  }

  Future<void> _requirePlatformModerator(Session session, int userId) async {
    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    if (profile == null || !{'admin', 'moderator'}.contains(profile.role)) {
      throw Exception('Moderator role required.');
    }
  }

  Future<int> syncOpportunitySource(Session session, int sourceId) async {
    final userId = await getAuthenticatedUserId(session);
    await _requirePlatformModerator(session, userId);
    return OpportunitySourceRefreshService.refreshSource(session, sourceId);
  }

  Future<List<Opportunity>> getOpportunities(
    Session session,
    int page,
    int limit,
    String? country,
    String? field,
    String? educationLevel,
    String? opportunityType,
    DateTime? deadlineBefore,
  ) async {
    await getAuthenticatedUserId(session);
    final safeLimit = limit < 1 ? 1 : (limit > 50 ? 50 : limit);
    final normalizedCountry = country?.trim();
    final normalizedField = field?.trim();
    final normalizedLevel = educationLevel?.trim();
    final normalizedType = opportunityType?.trim();
    return Opportunity.db.find(
      session,
      where: (t) {
        var expression = t.verificationStatus.equals('verified');
        if (normalizedCountry?.isNotEmpty == true) {
          expression = expression & t.country.equals(normalizedCountry!);
        }
        if (normalizedField?.isNotEmpty == true) {
          expression = expression & t.field.equals(normalizedField!);
        }
        if (normalizedLevel?.isNotEmpty == true) {
          expression = expression & t.educationLevel.equals(normalizedLevel!);
        }
        if (normalizedType?.isNotEmpty == true) {
          expression = expression & t.opportunityType.equals(normalizedType!);
        }
        if (deadlineBefore != null) {
          expression = expression & (t.deadline < deadlineBefore);
        }
        return expression;
      },
      orderBy: (t) => t.deadline,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<Opportunity> submitOpportunity(
    Session session,
    String title,
    String opportunityType,
    String provider,
    String country,
    String? eligibilityRegion,
    String field,
    String educationLevel,
    DateTime deadline,
    String fundingDetails,
    String officialUrl,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    await enforceRateLimit(
      session,
      userId: userId,
      action: 'submit-opportunity',
      maximum: 20,
      window: const Duration(hours: 1),
    );
    const allowedTypes = {
      'scholarship',
      'fellowship',
      'grant',
      'competition',
      'internship',
      'conference',
      'exchange',
    };
    final normalizedUrl = officialUrl.trim();
    final parsedUrl = Uri.tryParse(normalizedUrl);
    if (!allowedTypes.contains(opportunityType) ||
        title.trim().isEmpty ||
        provider.trim().isEmpty ||
        country.trim().isEmpty ||
        field.trim().isEmpty ||
        educationLevel.trim().isEmpty ||
        normalizedUrl.isEmpty ||
        normalizedUrl.length > 2000 ||
        parsedUrl == null ||
        !{'http', 'https'}.contains(parsedUrl.scheme) ||
        parsedUrl.host.isEmpty ||
        deadline.isBefore(DateTime.now())) {
      throw Exception('Invalid opportunity submission.');
    }
    final now = DateTime.now();
    return Opportunity.db.insertRow(
      session,
      Opportunity(
        title: title.trim(),
        opportunityType: opportunityType,
        provider: provider.trim(),
        country: country.trim(),
        eligibilityRegion: eligibilityRegion?.trim().isEmpty == true
            ? null
            : eligibilityRegion?.trim(),
        field: field.trim(),
        educationLevel: educationLevel.trim(),
        deadline: deadline,
        fundingDetails: fundingDetails.trim(),
        officialUrl: normalizedUrl,
        verificationStatus: 'pending',
        submittedById: userId,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<OpportunitySave> saveOpportunity(
    Session session,
    int opportunityId,
    bool alertEnabled,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final opportunity = await Opportunity.db.findById(session, opportunityId);
    if (opportunity == null || opportunity.verificationStatus != 'verified') {
      throw Exception('Verified opportunity not found.');
    }
    final existing = await OpportunitySave.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.opportunityId.equals(opportunityId),
    );
    if (existing != null) {
      existing.alertEnabled = alertEnabled;
      return OpportunitySave.db.updateRow(session, existing);
    }
    return OpportunitySave.db.insertRow(
      session,
      OpportunitySave(
        opportunityId: opportunityId,
        userId: userId,
        alertEnabled: alertEnabled,
        savedAt: DateTime.now(),
      ),
    );
  }

  Future<List<OpportunitySave>> getSavedOpportunities(
    Session session,
    int page,
    int limit,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final safeLimit = limit < 1 ? 1 : (limit > 50 ? 50 : limit);
    return OpportunitySave.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.savedAt,
      orderDescending: true,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<Opportunity> reviewOpportunity(
    Session session,
    int opportunityId,
    String verificationStatus,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    if (profile == null || !{'admin', 'moderator'}.contains(profile.role)) {
      throw Exception('Moderator role required.');
    }
    if (!{'verified', 'rejected', 'stale'}.contains(verificationStatus)) {
      throw Exception('Invalid verification status.');
    }
    final opportunity = await Opportunity.db.findById(session, opportunityId);
    if (opportunity == null) throw Exception('Opportunity not found.');
    opportunity.verificationStatus = verificationStatus;
    opportunity.updatedAt = DateTime.now();
    final updated = await Opportunity.db.updateRow(session, opportunity);
    await recordAuditEvent(
      session,
      actorId: userId,
      action: 'opportunity_reviewed',
      targetType: 'opportunity',
      targetId: opportunityId,
      metadata: 'status=$verificationStatus',
    );
    return updated;
  }

  Future<List<Opportunity>> getPendingOpportunityReviews(
    Session session, {
    int page = 0,
    int limit = 50,
  }) async {
    final userId = await getAuthenticatedUserId(session);
    await _requirePlatformModerator(session, userId);
    final safeLimit = limit.clamp(1, 100);
    return Opportunity.db.find(
      session,
      where: (t) => t.verificationStatus.equals('pending'),
      orderBy: (t) => t.createdAt,
      orderDescending: false,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<OpportunityAlert> createOpportunityAlert(
    Session session,
    String? country,
    String? field,
    String? educationLevel,
    List<String> opportunityTypes,
    int deadlineWithinDays,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    if (deadlineWithinDays < 1 || deadlineWithinDays > 365) {
      throw Exception('Deadline window must be between 1 and 365 days.');
    }
    const allowedTypes = {
      'scholarship',
      'fellowship',
      'grant',
      'competition',
      'internship',
      'conference',
      'exchange',
    };
    final types =
        opportunityTypes.where(allowedTypes.contains).take(7).toSet().toList();
    if (opportunityTypes.isNotEmpty && types.isEmpty) {
      throw Exception('No supported opportunity types were selected.');
    }
    final now = DateTime.now();
    return OpportunityAlert.db.insertRow(
      session,
      OpportunityAlert(
        userId: userId,
        country: country?.trim().isEmpty == true ? null : country?.trim(),
        field: field?.trim().isEmpty == true ? null : field?.trim(),
        educationLevel: educationLevel?.trim().isEmpty == true
            ? null
            : educationLevel?.trim(),
        opportunityTypes: types,
        deadlineWithinDays: deadlineWithinDays,
        active: true,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<List<OpportunityAlert>> getOpportunityAlerts(Session session) async {
    final userId = await getAuthenticatedUserId(session);
    return OpportunityAlert.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.active.equals(true),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
    );
  }

  Future<void> deactivateOpportunityAlert(
    Session session,
    int alertId,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final alert = await OpportunityAlert.db.findById(session, alertId);
    if (alert == null || alert.userId != userId) {
      throw Exception('Opportunity alert not found.');
    }
    alert.active = false;
    alert.updatedAt = DateTime.now();
    await OpportunityAlert.db.updateRow(session, alert);
  }

  Future<List<OpportunityApplicationTracker>> getApplicationTrackers(
    Session session,
    int page,
    int limit,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final safeLimit = limit < 1 ? 1 : (limit > 50 ? 50 : limit);
    return OpportunityApplicationTracker.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<OpportunityApplicationTracker> upsertApplicationTracker(
    Session session,
    int opportunityId,
    String status,
    String? notes,
    String? applicationUrl,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    if (!_trackerStatuses.contains(status)) {
      throw Exception('Unsupported application status.');
    }
    final opportunity = await Opportunity.db.findById(session, opportunityId);
    if (opportunity == null || opportunity.verificationStatus != 'verified') {
      throw Exception('Verified opportunity not found.');
    }
    final normalizedUrl = applicationUrl?.trim();
    if (normalizedUrl != null && normalizedUrl.isNotEmpty) {
      final uri = Uri.tryParse(normalizedUrl);
      if (uri == null ||
          !{'http', 'https'}.contains(uri.scheme) ||
          normalizedUrl.length > 2000) {
        throw Exception('Application URL is invalid.');
      }
    }
    final normalizedNotes = notes?.trim();
    if (normalizedNotes != null && normalizedNotes.length > 10000) {
      throw Exception('Application notes are too long.');
    }
    return session.db.transaction((transaction) async {
      final existing = await OpportunityApplicationTracker.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(userId) & t.opportunityId.equals(opportunityId),
        transaction: transaction,
      );
      final now = DateTime.now();
      if (existing != null) {
        existing.status = status;
        existing.notes =
            normalizedNotes?.isEmpty == true ? null : normalizedNotes;
        existing.applicationUrl =
            normalizedUrl?.isEmpty == true ? null : normalizedUrl;
        existing.updatedAt = now;
        return OpportunityApplicationTracker.db.updateRow(
          session,
          existing,
          transaction: transaction,
        );
      }
      return OpportunityApplicationTracker.db.insertRow(
        session,
        OpportunityApplicationTracker(
          opportunityId: opportunityId,
          userId: userId,
          status: status,
          notes: normalizedNotes?.isEmpty == true ? null : normalizedNotes,
          applicationUrl: normalizedUrl?.isEmpty == true ? null : normalizedUrl,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
    });
  }
}
