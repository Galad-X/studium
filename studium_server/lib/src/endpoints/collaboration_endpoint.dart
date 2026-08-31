import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:serverpod/server.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import '../generated/protocol.dart';
import '../services/aws_s3_service.dart';
import '../services/background_job_service.dart';
import '../services/room_embedding_service.dart';
import '../services/room_knowledge_search_service.dart';
import '../services/room_resource_text_extractor.dart';
import '../util/endpoint_utils.dart';
import '../util/configuration_secrets.dart';

class CollaborationEndpoint extends Endpoint with EndpointUtils {
  CollaborationEndpoint({
    http.Client? httpClient,
    String? openAiApiKey,
    AwsS3Service? storage,
  })  : _httpClient = httpClient ?? http.Client(),
        _openAiApiKey = openAiApiKey,
        _storage = storage;

  final http.Client _httpClient;
  final String? _openAiApiKey;
  final AwsS3Service? _storage;

  @override
  bool get requireLogin => true;

  Future<UserReputation> getMyReputation(Session session) async {
    final userId = await getAuthenticatedUserId(session);
    return _getReputation(session, userId);
  }

  Future<RoomWhiteboardState?> getRoomWhiteboard(
    Session session,
    int roomId,
  ) async {
    await _requireActiveMember(session, roomId);
    return RoomWhiteboardState.db.findFirstRow(
      session,
      where: (t) => t.roomId.equals(roomId),
    );
  }

  Future<RoomWhiteboardState> saveRoomWhiteboard(
    Session session,
    int roomId,
    int expectedVersion,
    String strokesJson,
  ) async {
    final userId = await _requireActiveMember(session, roomId);
    if (strokesJson.length > 2 * 1024 * 1024) {
      throw Exception('Whiteboard payload is too large.');
    }
    return session.db.transaction((transaction) async {
      final existing = await RoomWhiteboardState.db.findFirstRow(
        session,
        where: (t) => t.roomId.equals(roomId),
        transaction: transaction,
      );
      if (existing != null && existing.version != expectedVersion) {
        throw Exception('Whiteboard changed remotely. Reload before saving.');
      }
      final now = DateTime.now();
      if (existing == null) {
        return RoomWhiteboardState.db.insertRow(
          session,
          RoomWhiteboardState(
            roomId: roomId,
            version: 1,
            strokesJson: strokesJson,
            updatedById: userId,
            updatedAt: now,
          ),
          transaction: transaction,
        );
      }
      existing.version += 1;
      existing.strokesJson = strokesJson;
      existing.updatedById = userId;
      existing.updatedAt = now;
      return RoomWhiteboardState.db
          .updateRow(session, existing, transaction: transaction);
    });
  }

  /// Returns the public contribution signal for an authenticated member.
  /// Detailed moderation history is intentionally not exposed here.
  Future<UserReputation> getUserReputation(
    Session session,
    int userId,
  ) async {
    await getAuthenticatedUserId(session);
    if (userId <= 0) {
      throw Exception('Invalid user id.');
    }
    return _getReputation(session, userId);
  }

  Future<UserReputation> _getReputation(Session session, int userId) async {
    final existing = await UserReputation.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    return existing ??
        UserReputation(
          userId: userId,
          score: 0,
          acceptedSolutions: 0,
          verifiedContributions: 0,
          updatedAt: DateTime.now(),
        );
  }

  Future<List<Institution>> searchInstitutions(
    Session session,
    String query,
    int page,
    int limit,
  ) async {
    await getAuthenticatedUserId(session);
    final safeLimit = limit < 1 ? 1 : (limit > 50 ? 50 : limit);
    final safePage = page < 0 ? 0 : page;
    final normalized = query.trim();
    return Institution.db.find(
      session,
      where: normalized.isEmpty
          ? (t) => t.verificationStatus.equals('verified')
          : (t) =>
              t.verificationStatus.equals('verified') &
              t.name.like('%$normalized%'),
      orderBy: (t) => t.name,
      limit: safeLimit,
      offset: safePage * safeLimit,
    );
  }

  Future<Institution> submitInstitution(
    Session session,
    String name,
    String country,
    String? region,
    List<String> domains,
    String? logoUrl,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final normalizedName = name.trim();
    final normalizedCountry = country.trim().toUpperCase();
    final normalizedDomains = domains
        .map((domain) => domain.trim().toLowerCase().replaceFirst('@', ''))
        .where((domain) => domain.isNotEmpty)
        .toSet()
        .toList();
    final parsedLogo = logoUrl == null ? null : Uri.tryParse(logoUrl.trim());
    if (normalizedName.isEmpty ||
        normalizedName.length > 200 ||
        normalizedCountry.isEmpty ||
        normalizedCountry.length > 3 ||
        normalizedDomains.isEmpty ||
        normalizedDomains.length > 20 ||
        normalizedDomains
            .any((domain) => domain.length > 255 || !domain.contains('.')) ||
        (logoUrl != null &&
            (parsedLogo == null ||
                !{'http', 'https'}.contains(parsedLogo.scheme) ||
                parsedLogo.host.isEmpty ||
                logoUrl.trim().length > 2000))) {
      throw Exception('Invalid institution submission.');
    }
    return session.db.transaction((transaction) async {
      final existing = await Institution.db.findFirstRow(
        session,
        where: (t) =>
            t.name.equals(normalizedName) & t.country.equals(normalizedCountry),
        transaction: transaction,
      );
      if (existing != null) return existing;
      final institution = await Institution.db.insertRow(
        session,
        Institution(
          name: normalizedName,
          country: normalizedCountry,
          region: _cleanOptional(region),
          domains: normalizedDomains,
          submittedById: userId,
          logoUrl: parsedLogo?.toString(),
          verificationStatus: 'pending',
          createdAt: DateTime.now().toUtc(),
        ),
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'institution_submitted',
        targetType: 'institution',
        targetId: institution.id!,
        institutionId: institution.id,
        transaction: transaction,
      );
      return institution;
    });
  }

  Future<Institution> reviewInstitution(
    Session session,
    int institutionId,
    String decision,
  ) async {
    final reviewerId = await _requirePlatformModerator(session);
    if (!{'verified', 'rejected'}.contains(decision)) {
      throw Exception('Unsupported institution decision.');
    }
    return session.db.transaction((transaction) async {
      final institution = await Institution.db.findById(
        session,
        institutionId,
        transaction: transaction,
      );
      if (institution == null || institution.verificationStatus != 'pending') {
        throw Exception('Pending institution not found.');
      }
      institution.verificationStatus = decision;
      final updated = await Institution.db.updateRow(
        session,
        institution,
        transaction: transaction,
      );
      if (decision == 'verified' && institution.submittedById != null) {
        final existingMembership = await InstitutionMembership.db.findFirstRow(
          session,
          where: (t) =>
              t.userId.equals(institution.submittedById!) &
              t.institutionId.equals(institutionId),
          transaction: transaction,
        );
        if (existingMembership == null) {
          final now = DateTime.now().toUtc();
          final adminMembership = await InstitutionMembership.db.insertRow(
            session,
            InstitutionMembership(
              userId: institution.submittedById!,
              institutionId: institutionId,
              role: 'institution_admin',
              verificationMethod: 'institution_submission',
              status: 'verified',
              createdAt: now,
              verifiedAt: now,
            ),
            transaction: transaction,
          );
          await recordAuditEvent(
            session,
            actorId: reviewerId,
            action: 'institution_admin_provisioned',
            targetType: 'institution_membership',
            targetId: adminMembership.id!,
            institutionId: institutionId,
            metadata: 'userId=${institution.submittedById}',
            transaction: transaction,
          );
        }
      }
      await recordAuditEvent(
        session,
        actorId: reviewerId,
        action: 'institution_reviewed',
        targetType: 'institution',
        targetId: institutionId,
        institutionId: institutionId,
        metadata: 'decision=$decision',
        transaction: transaction,
      );
      return updated;
    });
  }

  Future<List<Institution>> getPendingInstitutionReviews(
    Session session,
    int page,
    int limit,
  ) async {
    await _requirePlatformModerator(session);
    final safeLimit = limit.clamp(1, 100);
    final safePage = page < 0 ? 0 : page;
    return Institution.db.find(
      session,
      where: (t) => t.verificationStatus.equals('pending'),
      orderBy: (t) => t.createdAt,
      orderDescending: false,
      limit: safeLimit,
      offset: safePage * safeLimit,
    );
  }

  Future<List<InstitutionMembership>> getMyMemberships(Session session) async {
    final userId = await getAuthenticatedUserId(session);
    return InstitutionMembership.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 100,
    );
  }

  Future<List<VerificationRequest>> getMyVerificationRequests(
      Session session) async {
    final userId = await getAuthenticatedUserId(session);
    final memberships = await InstitutionMembership.db.find(
      session,
      where: (t) => t.userId.equals(userId),
      limit: 100,
    );
    final membershipIds =
        memberships.map((membership) => membership.id).whereType<int>().toSet();
    if (membershipIds.isEmpty) return [];
    return VerificationRequest.db.find(
      session,
      where: (t) => t.membershipId.inSet(membershipIds),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 200,
    );
  }

  Future<AcademicProfile?> getAcademicProfile(
      Session session, int institutionId) async {
    final userId = await getAuthenticatedUserId(session);
    return AcademicProfile.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) & t.institutionId.equals(institutionId),
    );
  }

  Future<AcademicProfile> upsertAcademicProfile(
    Session session,
    int institutionId,
    String? department,
    String? programme,
    String? level,
    List<String> subjects,
    List<String> interests,
    List<String> languages,
    String? availability,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final membership = await InstitutionMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.institutionId.equals(institutionId) &
          t.status.equals('verified'),
    );
    if (membership == null) {
      throw Exception('Verified institution membership required.');
    }
    return session.db.transaction((transaction) async {
      var profile = await AcademicProfile.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(userId) & t.institutionId.equals(institutionId),
        transaction: transaction,
      );
      final now = DateTime.now();
      profile ??= AcademicProfile(
        userId: userId,
        institutionId: institutionId,
        subjects: const [],
        interests: const [],
        languages: const [],
        updatedAt: now,
      );
      profile.department = _cleanOptional(department);
      profile.programme = _cleanOptional(programme);
      profile.level = _cleanOptional(level);
      profile.subjects = _cleanList(subjects, 50);
      profile.interests = _cleanList(interests, 50);
      profile.languages = _cleanList(languages, 20);
      profile.availability = _cleanOptional(availability);
      profile.updatedAt = now;
      final saved = profile.id == null
          ? await AcademicProfile.db
              .insertRow(session, profile, transaction: transaction)
          : await AcademicProfile.db
              .updateRow(session, profile, transaction: transaction);
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'academic_profile_updated',
        targetType: 'academic_profile',
        targetId: saved.id!,
        institutionId: institutionId,
        transaction: transaction,
      );
      return saved;
    });
  }

  String? _cleanOptional(String? value) {
    final normalized = value?.trim();
    return normalized == null || normalized.isEmpty ? null : normalized;
  }

  List<String> _cleanList(List<String> values, int maxItems) => values
      .map((value) => value.trim())
      .where((value) => value.isNotEmpty)
      .take(maxItems)
      .toList();

  Future<String> createInstitutionInvite(
    Session session,
    int institutionId,
    int expiresInDays,
    int maxUses,
  ) async {
    final creatorId = await getAuthenticatedUserId(session);
    final membership = await InstitutionMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(creatorId) &
          t.institutionId.equals(institutionId) &
          t.status.equals('verified'),
    );
    if (membership == null ||
        !{'institution_admin', 'moderator'}.contains(membership.role)) {
      throw Exception('Institution admin or moderator role required.');
    }
    if (expiresInDays < 1 ||
        expiresInDays > 30 ||
        maxUses < 1 ||
        maxUses > 500) {
      throw Exception('Invalid invite settings.');
    }
    final token = base64UrlEncode(
      List<int>.generate(32, (_) => Random.secure().nextInt(256)),
    ).replaceAll('=', '');
    await session.db.transaction((transaction) async {
      final invite = await InstitutionInvite.db.insertRow(
        session,
        InstitutionInvite(
          institutionId: institutionId,
          createdById: creatorId,
          tokenHash: sha256.convert(utf8.encode(token)).toString(),
          expiresAt: DateTime.now().add(Duration(days: expiresInDays)),
          maxUses: maxUses,
          uses: 0,
          status: 'active',
          createdAt: DateTime.now(),
        ),
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: creatorId,
        action: 'institution_invite_created',
        targetType: 'institution_invite',
        targetId: invite.id!,
        institutionId: institutionId,
        metadata: 'expiresInDays=$expiresInDays;maxUses=$maxUses',
        transaction: transaction,
      );
    });
    return token;
  }

  Future<InstitutionMembership> acceptInstitutionInvite(
    Session session,
    String token,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final hash = sha256.convert(utf8.encode(token.trim())).toString();
    return session.db.transaction((transaction) async {
      final invite = await InstitutionInvite.db.findFirstRow(
        session,
        where: (t) => t.tokenHash.equals(hash) & t.status.equals('active'),
        transaction: transaction,
      );
      if (invite == null ||
          invite.expiresAt.isBefore(DateTime.now()) ||
          invite.uses >= invite.maxUses) {
        throw Exception('Invite is invalid or expired.');
      }
      var membership = await InstitutionMembership.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(userId) &
            t.institutionId.equals(invite.institutionId),
        transaction: transaction,
      );
      membership ??= await InstitutionMembership.db.insertRow(
        session,
        InstitutionMembership(
          userId: userId,
          institutionId: invite.institutionId,
          role: 'student',
          verificationMethod: 'invite',
          status: 'verified',
          createdAt: DateTime.now(),
          verifiedAt: DateTime.now(),
        ),
        transaction: transaction,
      );
      invite.uses += 1;
      if (invite.uses >= invite.maxUses) invite.status = 'exhausted';
      await InstitutionInvite.db
          .updateRow(session, invite, transaction: transaction);
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'institution_invite_accepted',
        targetType: 'institution_membership',
        targetId: membership.id!,
        institutionId: invite.institutionId,
        metadata: 'inviteId=${invite.id}',
        transaction: transaction,
      );
      return membership;
    });
  }

  Future<List<InstitutionMembership>> getInstitutionMembers(
    Session session,
    int institutionId,
    int page,
    int limit,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final membership = await InstitutionMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.institutionId.equals(institutionId) &
          t.status.equals('verified'),
    );
    if (membership == null) throw Exception('Institution membership required.');
    final safeLimit = limit.clamp(1, 100);
    return InstitutionMembership.db.find(
      session,
      where: (t) => t.institutionId.equals(institutionId),
      orderBy: (t) => t.createdAt,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<List<VerificationRequest>> getInstitutionVerificationRequests(
    Session session,
    int institutionId,
    int page,
    int limit,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final reviewer = await InstitutionMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.institutionId.equals(institutionId) &
          t.status.equals('verified'),
    );
    if (reviewer == null ||
        !{'institution_admin', 'moderator'}.contains(reviewer.role)) {
      throw Exception('Institution moderator role required.');
    }
    final membershipRows = await InstitutionMembership.db.find(
      session,
      where: (t) => t.institutionId.equals(institutionId),
      limit: 500,
    );
    final membershipIds =
        membershipRows.map((item) => item.id).whereType<int>();
    if (membershipIds.isEmpty) return [];
    final safeLimit = limit.clamp(1, 100);
    return VerificationRequest.db.find(
      session,
      where: (t) =>
          t.membershipId.inSet(membershipIds.toSet()) &
          t.status.equals('pending'),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<InstitutionMembership> updateInstitutionMember(
    Session session,
    int membershipId,
    String role,
    String status,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final target =
        await InstitutionMembership.db.findById(session, membershipId);
    if (target == null ||
        !{'student', 'lecturer', 'moderator', 'institution_admin'}
            .contains(role) ||
        !{'pending', 'verified', 'rejected', 'suspended'}.contains(status)) {
      throw Exception('Invalid membership update.');
    }
    final reviewer = await InstitutionMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.institutionId.equals(target.institutionId) &
          t.status.equals('verified'),
    );
    if (reviewer == null || reviewer.role != 'institution_admin') {
      throw Exception('Institution admin role required.');
    }
    target.role = role;
    target.status = status;
    target.verifiedAt = status == 'verified' ? DateTime.now() : null;
    final updated = await InstitutionMembership.db.updateRow(session, target);
    await recordAuditEvent(
      session,
      actorId: userId,
      action: 'institution_membership_updated',
      targetType: 'institution_membership',
      targetId: target.id!,
      institutionId: target.institutionId,
      metadata: 'role=$role;status=$status',
    );
    return updated;
  }

  Future<InstitutionMembership> requestMembership(
    Session session,
    int institutionId,
    String verificationMethod,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final institution = await Institution.db.findById(session, institutionId);
    if (institution == null || institution.verificationStatus != 'verified') {
      throw Exception('Institution is not available for membership requests.');
    }
    if (!{'institution_email', 'manual', 'invite'}
        .contains(verificationMethod)) {
      throw Exception('Unsupported verification method.');
    }
    final userInfo = verificationMethod == 'institution_email'
        ? await UserInfo.db.findById(session, userId)
        : null;
    final domainVerified = verificationMethod == 'institution_email' &&
        userInfo?.email != null &&
        _matchesInstitutionDomain(userInfo!.email!, institution.domains);
    return session.db.transaction((transaction) async {
      final existing = await InstitutionMembership.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(userId) & t.institutionId.equals(institutionId),
        transaction: transaction,
      );
      if (existing != null) return existing;
      final now = DateTime.now();
      final membership = await InstitutionMembership.db.insertRow(
        session,
        InstitutionMembership(
          userId: userId,
          institutionId: institutionId,
          role: 'student',
          verificationMethod: verificationMethod,
          status: domainVerified ? 'verified' : 'pending',
          createdAt: now,
          verifiedAt: domainVerified ? now : null,
        ),
        transaction: transaction,
      );
      await VerificationRequest.db.insertRow(
        session,
        VerificationRequest(
          membershipId: membership.id!,
          method: verificationMethod,
          status: domainVerified ? 'approved' : 'pending',
          createdAt: now,
        ),
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'institution_membership_requested',
        targetType: 'institution_membership',
        targetId: membership.id!,
        institutionId: institutionId,
        metadata:
            'verificationMethod=$verificationMethod;status=${membership.status}',
        transaction: transaction,
      );
      return membership;
    });
  }

  bool _matchesInstitutionDomain(String email, List<String> domains) {
    final separator = email.lastIndexOf('@');
    if (separator < 1 || separator == email.length - 1) return false;
    final emailDomain = email.substring(separator + 1).trim().toLowerCase();
    return domains.any((domain) {
      final normalized = domain.trim().toLowerCase().replaceFirst('@', '');
      return normalized.isNotEmpty && normalized == emailDomain;
    });
  }

  Future<VerificationRequest> submitVerificationEvidence(
    Session session,
    int membershipId,
    String evidenceUrl,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final membership = await InstitutionMembership.db.findById(
      session,
      membershipId,
    );
    if (membership == null ||
        membership.userId != userId ||
        membership.status != 'pending') {
      throw Exception('Pending membership not found.');
    }
    final uri = Uri.tryParse(evidenceUrl.trim());
    if (uri == null ||
        !{'http', 'https'}.contains(uri.scheme) ||
        evidenceUrl.trim().length > 2000) {
      throw Exception('Evidence URL is invalid.');
    }
    final request = await VerificationRequest.db.findFirstRow(
      session,
      where: (t) => t.membershipId.equals(membershipId),
    );
    if (request == null || request.status == 'rejected') {
      throw Exception('Verification request is not available.');
    }
    return session.db.transaction((transaction) async {
      request.evidenceUrl = uri.toString();
      request.status = 'pending';
      final updated = await VerificationRequest.db.updateRow(
        session,
        request,
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'institution_verification_evidence_submitted',
        targetType: 'verification_request',
        targetId: request.id!,
        institutionId: membership.institutionId,
        metadata: 'membershipId=$membershipId',
        transaction: transaction,
      );
      return updated;
    });
  }

  Future<InstitutionMembership> reviewMembership(
    Session session,
    int membershipId,
    String decision,
  ) async {
    final reviewerId = await getAuthenticatedUserId(session);
    if (!{'approve', 'reject'}.contains(decision)) {
      throw Exception('Unsupported membership decision.');
    }

    return session.db.transaction((transaction) async {
      final membership = await InstitutionMembership.db.findById(
        session,
        membershipId,
        transaction: transaction,
      );
      if (membership == null || membership.status != 'pending') {
        throw Exception('Pending membership not found.');
      }

      final reviewerMembership = await InstitutionMembership.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(reviewerId) &
            t.institutionId.equals(membership.institutionId) &
            t.status.equals('verified'),
        transaction: transaction,
      );
      if (reviewerMembership == null ||
          !{'institution_admin', 'moderator'}
              .contains(reviewerMembership.role)) {
        throw Exception('Institution admin or moderator role required.');
      }

      membership.status = decision == 'approve' ? 'verified' : 'rejected';
      membership.verifiedAt = decision == 'approve' ? DateTime.now() : null;
      final updatedMembership = await InstitutionMembership.db.updateRow(
        session,
        membership,
        transaction: transaction,
      );
      final verificationRequest = await VerificationRequest.db.findFirstRow(
        session,
        where: (t) => t.membershipId.equals(membership.id!),
        transaction: transaction,
      );
      if (verificationRequest != null) {
        verificationRequest.status =
            decision == 'approve' ? 'approved' : 'rejected';
        verificationRequest.reviewerId = reviewerId;
        verificationRequest.reviewedAt = DateTime.now();
        await VerificationRequest.db.updateRow(
          session,
          verificationRequest,
          transaction: transaction,
        );
      }
      await recordAuditEvent(
        session,
        actorId: reviewerId,
        action: 'institution_membership_reviewed',
        targetType: 'institution_membership',
        targetId: membership.id!,
        institutionId: membership.institutionId,
        metadata: 'decision=$decision',
        transaction: transaction,
      );
      return updatedMembership;
    });
  }

  Future<List<StudyRoom>> getRooms(
    Session session,
    int page,
    int limit, [
    int? institutionId,
    String? subject,
  ]) async {
    final userId = await getAuthenticatedUserId(session);
    final safeLimit = limit < 1 ? 1 : (limit > 50 ? 50 : limit);
    final roomMemberships = await RoomMembership.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('active'),
    );
    final memberRoomIds =
        roomMemberships.map((membership) => membership.roomId).toSet();
    final institutionMemberships = await InstitutionMembership.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('verified'),
    );
    final verifiedInstitutionIds = institutionMemberships
        .map((membership) => membership.institutionId)
        .toSet();
    final rooms = await StudyRoom.db.find(
      session,
      where: (t) => t.status.equals('active'),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      limit: 500,
    );
    final normalizedSubject = subject?.trim().toLowerCase();
    final visibleRooms = rooms.where((room) {
      final matchesInstitution =
          institutionId == null || room.institutionId == institutionId;
      final matchesSubject = normalizedSubject == null ||
          normalizedSubject.isEmpty ||
          room.subject?.toLowerCase() == normalizedSubject;
      if (!matchesInstitution || !matchesSubject) return false;
      if (room.ownerId == userId || room.visibility == 'public') return true;
      if (room.visibility == 'institution') {
        return room.institutionId != null &&
            verifiedInstitutionIds.contains(room.institutionId);
      }
      return room.visibility == 'private' && memberRoomIds.contains(room.id);
    }).toList();
    final offset = (page < 0 ? 0 : page) * safeLimit;
    return visibleRooms.skip(offset).take(safeLimit).toList();
  }

  Future<StudyRoom> createRoom(
    Session session,
    int? institutionId,
    String title,
    String description,
    String? subject,
    String visibility,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    await _requireNotRestricted(session, userId);
    await enforceRateLimit(
      session,
      userId: userId,
      action: 'create-room',
      maximum: 10,
      window: const Duration(hours: 1),
    );
    if (title.trim().length < 3) {
      throw Exception('Room title is too short.');
    }
    if (!{'public', 'institution', 'private'}.contains(visibility)) {
      throw Exception('Unsupported room visibility.');
    }
    if (visibility == 'institution' && institutionId == null) {
      throw Exception('Institution rooms require an institution.');
    }
    if (institutionId != null) {
      final membership = await InstitutionMembership.db.findFirstRow(
        session,
        where: (t) =>
            t.userId.equals(userId) &
            t.institutionId.equals(institutionId) &
            t.status.equals('verified'),
      );
      if (membership == null) {
        throw Exception('Verified institution membership required.');
      }
    }
    return session.db.transaction((transaction) async {
      final now = DateTime.now();
      final room = await StudyRoom.db.insertRow(
        session,
        StudyRoom(
          institutionId: institutionId,
          ownerId: userId,
          title: title.trim(),
          description: description.trim(),
          subject: subject?.trim().isEmpty == true ? null : subject?.trim(),
          visibility: visibility,
          membershipPolicy: 'open',
          status: 'active',
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      await RoomMembership.db.insertRow(
        session,
        RoomMembership(
          roomId: room.id!,
          userId: userId,
          role: 'owner',
          status: 'active',
          joinedAt: now,
        ),
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'study_room_created',
        targetType: 'study_room',
        targetId: room.id!,
        institutionId: room.institutionId,
        metadata: 'visibility=${room.visibility}',
        transaction: transaction,
      );
      return room;
    });
  }

  Future<RoomMembership> joinRoom(Session session, int roomId) async {
    final userId = await getAuthenticatedUserId(session);
    final room = await StudyRoom.db.findById(session, roomId);
    if (room == null || room.status != 'active') {
      throw Exception('Room not found.');
    }
    if (room.visibility == 'private') {
      throw Exception('This room requires an invite.');
    }
    if (room.institutionId != null) {
      final membership = await InstitutionMembership.db.findFirstRow(session,
          where: (t) =>
              t.userId.equals(userId) &
              t.institutionId.equals(room.institutionId!) &
              t.status.equals('verified'));
      if (membership == null) {
        throw Exception('Verified institution membership required.');
      }
    }
    return session.db.transaction((transaction) async {
      final existing = await RoomMembership.db.findFirstRow(
        session,
        where: (t) => t.roomId.equals(roomId) & t.userId.equals(userId),
        transaction: transaction,
      );
      if (existing != null) return existing;
      final joined = await RoomMembership.db.insertRow(
        session,
        RoomMembership(
          roomId: roomId,
          userId: userId,
          role: 'member',
          status: 'active',
          joinedAt: DateTime.now(),
        ),
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'room_membership_created',
        targetType: 'room_membership',
        targetId: joined.id!,
        institutionId: room.institutionId,
        transaction: transaction,
      );
      return joined;
    });
  }

  Future<RoomMembership?> getMyRoomMembership(
    Session session,
    int roomId,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    return RoomMembership.db.findFirstRow(
      session,
      where: (t) => t.roomId.equals(roomId) & t.userId.equals(userId),
    );
  }

  Future<List<DiscussionPost>> getRoomPosts(
      Session session, int roomId, int page, int limit) async {
    await _requireActiveMember(session, roomId);
    final safeLimit = limit < 1 ? 1 : (limit > 50 ? 50 : limit);
    return DiscussionPost.db.find(session,
        where: (t) => t.roomId.equals(roomId) & t.status.equals('visible'),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: safeLimit,
        offset: (page < 0 ? 0 : page) * safeLimit);
  }

  Future<DiscussionPost> createPost(
      Session session, int roomId, String body) async {
    final userId = await _requireActiveMember(session, roomId);
    await _requireNotRestricted(session, userId);
    if (body.trim().isEmpty || body.length > 10000) {
      throw Exception('Post body is invalid.');
    }
    final now = DateTime.now();
    return session.db.transaction((transaction) async {
      final post = await DiscussionPost.db.insertRow(
        session,
        DiscussionPost(
          roomId: roomId,
          authorId: userId,
          body: body.trim(),
          status: 'visible',
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      final room = await StudyRoom.db.findById(
        session,
        roomId,
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'discussion_post_created',
        targetType: 'discussion_post',
        targetId: post.id!,
        institutionId: room?.institutionId,
        transaction: transaction,
      );
      return post;
    });
  }

  Future<List<Challenge>> getChallenges(
      Session session, int page, int limit, int? roomId) async {
    final userId = await getAuthenticatedUserId(session);
    if (roomId != null) await _requireActiveMember(session, roomId);
    final safeLimit = limit < 1 ? 1 : (limit > 50 ? 50 : limit);
    final challenges = await Challenge.db.find(
      session,
      where: roomId == null ? null : (t) => t.roomId.equals(roomId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      limit: 500,
    );
    if (roomId != null) {
      return challenges
          .skip((page < 0 ? 0 : page) * safeLimit)
          .take(safeLimit)
          .toList();
    }
    final memberships = await RoomMembership.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('active'),
    );
    final memberRoomIds = memberships.map((item) => item.roomId).toSet();
    final institutionMemberships = await InstitutionMembership.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('verified'),
    );
    final verifiedInstitutionIds = institutionMemberships
        .map((membership) => membership.institutionId)
        .toSet();
    final roomIds =
        challenges.map((item) => item.roomId).whereType<int>().toSet();
    final rooms = roomIds.isEmpty
        ? <StudyRoom>[]
        : await StudyRoom.db.find(
            session,
            where: (t) => t.id.inSet(roomIds),
          );
    final visibleRoomIds = rooms
        .where((room) =>
            room.ownerId == userId ||
            room.visibility == 'public' ||
            (room.visibility == 'institution' &&
                room.institutionId != null &&
                verifiedInstitutionIds.contains(room.institutionId)) ||
            (room.visibility == 'private' && memberRoomIds.contains(room.id)))
        .map((room) => room.id)
        .whereType<int>()
        .toSet();
    return challenges
        .where((challenge) =>
            challenge.roomId == null ||
            visibleRoomIds.contains(challenge.roomId))
        .skip((page < 0 ? 0 : page) * safeLimit)
        .take(safeLimit)
        .toList();
  }

  Future<Challenge> createChallenge(
      Session session,
      int? roomId,
      String title,
      String problemStatement,
      String field,
      List<String> tags,
      String difficulty) async {
    final userId = await getAuthenticatedUserId(session);
    await _requireNotRestricted(session, userId);
    await enforceRateLimit(
      session,
      userId: userId,
      action: 'create-challenge',
      maximum: 10,
      window: const Duration(hours: 1),
    );
    if (roomId != null) await _requireActiveMember(session, roomId);
    if (title.trim().isEmpty || problemStatement.trim().isEmpty) {
      throw Exception('Challenge title and problem are required.');
    }
    if (!{'beginner', 'intermediate', 'advanced'}.contains(difficulty)) {
      throw Exception('Unsupported difficulty.');
    }
    final institutionId = roomId == null
        ? null
        : (await StudyRoom.db.findById(session, roomId))?.institutionId;
    final now = DateTime.now();
    final challenge = await Challenge.db.insertRow(
        session,
        Challenge(
            roomId: roomId,
            ownerId: userId,
            title: title.trim(),
            problemStatement: problemStatement.trim(),
            field: field.trim(),
            tags: tags
                .map((tag) => tag.trim())
                .where((tag) => tag.isNotEmpty)
                .take(20)
                .toList(),
            difficulty: difficulty,
            status: 'open',
            createdAt: now,
            updatedAt: now));
    await recordAuditEvent(
      session,
      actorId: userId,
      action: 'challenge_created',
      targetType: 'challenge',
      targetId: challenge.id!,
      institutionId: institutionId,
      metadata: 'status=open',
    );
    return challenge;
  }

  Future<List<RoomResource>> getRoomResources(
    Session session,
    int roomId,
    int page,
    int limit,
  ) async {
    await _requireActiveMember(session, roomId);
    final safeLimit = limit.clamp(1, 50);
    return RoomResource.db.find(
      session,
      where: (t) => t.roomId.equals(roomId) & t.status.equals('active'),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<RoomResource> addRoomResource(
    Session session,
    int roomId,
    String resourceType,
    String title,
    String? uri,
    String? content,
    String? citation,
  ) async {
    final ownerId = await _requireActiveMember(session, roomId);
    const allowed = {'material', 'summary', 'question_set', 'writing', 'link'};
    if (!allowed.contains(resourceType) ||
        title.trim().isEmpty ||
        ((uri?.trim().isEmpty ?? true) && (content?.trim().isEmpty ?? true))) {
      throw Exception('Invalid room resource.');
    }
    final now = DateTime.now();
    final resource = await RoomResource.db.insertRow(
      session,
      RoomResource(
        roomId: roomId,
        ownerId: ownerId,
        resourceType: resourceType,
        title: title.trim(),
        uri: uri?.trim().isEmpty == true ? null : uri?.trim(),
        content: content?.trim().isEmpty == true ? null : content?.trim(),
        citation: citation?.trim().isEmpty == true ? null : citation?.trim(),
        status: 'active',
        createdAt: now,
        updatedAt: now,
      ),
    );
    await _persistResourceChunks(session, resource);
    final room = await StudyRoom.db.findById(session, roomId);
    await recordAuditEvent(
      session,
      actorId: ownerId,
      action: 'room_resource_created',
      targetType: 'room_resource',
      targetId: resource.id!,
      institutionId: room?.institutionId,
      metadata: 'resourceType=$resourceType',
    );
    return resource;
  }

  Future<RoomResource> uploadRoomResource(
    Session session,
    int roomId,
    String resourceType,
    String title,
    String fileType,
    ByteData fileData,
    String? citation,
  ) async {
    final ownerId = await _requireActiveMember(session, roomId);
    await _requireNotRestricted(session, ownerId);
    const allowedTypes = {'material', 'summary', 'question_set', 'writing'};
    const allowedExtensions = {
      'pdf',
      'doc',
      'docx',
      'ppt',
      'pptx',
      'txt',
      'md',
      'xlsx',
      'png',
      'jpg',
      'jpeg',
      'webp',
    };
    final normalizedTitle = title.trim();
    final normalizedExtension =
        fileType.trim().toLowerCase().replaceFirst('.', '');
    if (!allowedTypes.contains(resourceType) || normalizedTitle.isEmpty) {
      throw Exception('Invalid room resource.');
    }
    if (!allowedExtensions.contains(normalizedExtension)) {
      throw Exception('Unsupported room resource file type.');
    }
    if (normalizedTitle.length > 300 ||
        fileData.lengthInBytes > 50 * 1024 * 1024) {
      throw Exception('Room resource file is too large.');
    }
    final sanitizedTitle = normalizedTitle.replaceAll(
      RegExp(r'[^a-zA-Z0-9\\-_]'),
      '_',
    );
    final objectKey =
        'room-resources/$roomId/$ownerId/${DateTime.now().millisecondsSinceEpoch}_$sanitizedTitle.$normalizedExtension';
    final storage = _storage ?? AwsS3Service.fromConfig(session.serverpod);
    final uri = await storage.uploadFile(
      objectKey,
      fileData.buffer.asUint8List(),
      _roomResourceContentType(normalizedExtension),
    );
    try {
      final now = DateTime.now();
      final extractedContent = RoomResourceTextExtractor.extract(
        normalizedExtension,
        fileData.buffer.asUint8List(),
      );
      final resource = await RoomResource.db.insertRow(
        session,
        RoomResource(
          roomId: roomId,
          ownerId: ownerId,
          resourceType: resourceType,
          title: normalizedTitle,
          uri: uri,
          content: extractedContent,
          citation: citation?.trim().isEmpty == true ? null : citation?.trim(),
          status: extractedContent == null ? 'processing' : 'active',
          createdAt: now,
          updatedAt: now,
        ),
      );
      if (extractedContent == null) {
        await BackgroundJobService.enqueue(
          session,
          jobType: 'room_resource.ocr',
          payload: {'resourceId': resource.id},
        );
      } else {
        await _persistResourceChunks(session, resource);
      }
      final room = await StudyRoom.db.findById(session, roomId);
      await recordAuditEvent(
        session,
        actorId: ownerId,
        action: 'room_resource_uploaded',
        targetType: 'room_resource',
        targetId: resource.id!,
        institutionId: room?.institutionId,
        metadata: 'fileType=$normalizedExtension',
      );
      return resource;
    } catch (_) {
      await storage.deleteFile(objectKey, session: session);
      rethrow;
    }
  }

  Future<void> _persistResourceChunks(
      Session session, RoomResource resource) async {
    final content = resource.content?.trim();
    if (content == null || content.isEmpty || resource.id == null) return;
    const chunkSize = 6000;
    var index = 0;
    for (var start = 0; start < content.length; start += chunkSize) {
      final end = (start + chunkSize).clamp(0, content.length);
      final chunk = content.substring(start, end).trim();
      if (chunk.isNotEmpty) {
        await RoomResourceChunk.db.insertRow(
          session,
          RoomResourceChunk(
            roomResourceId: resource.id!,
            chunkIndex: index,
            content: chunk,
            tokenCount: chunk.split(RegExp(r'\s+')).length,
            createdAt: DateTime.now(),
          ),
        );
        index++;
      }
    }
    if (index > 0) {
      await BackgroundJobService.enqueue(
        session,
        jobType: 'room_resource.index_embeddings',
        payload: {'roomId': resource.roomId, 'resourceId': resource.id},
      );
    }
  }

  Future<List<RoomResourceChunk>> getRoomResourceChunks(
      Session session, int roomId, int resourceId, int page, int limit) async {
    await _requireActiveMember(session, roomId);
    final resource = await RoomResource.db.findById(session, resourceId);
    if (resource == null ||
        resource.roomId != roomId ||
        resource.status != 'active') {
      throw Exception('Room resource not found.');
    }
    final safeLimit = limit.clamp(1, 100);
    return RoomResourceChunk.db.find(
      session,
      where: (t) => t.roomResourceId.equals(resourceId),
      orderBy: (t) => t.chunkIndex,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<int> indexRoomResourceEmbeddings(
      Session session, int roomId, int resourceId) async {
    final userId = await _requireActiveMember(session, roomId);
    await enforceRateLimit(
      session,
      userId: userId,
      action: 'index-room-embeddings',
      maximum: 10,
      window: const Duration(hours: 1),
    );
    final resource = await RoomResource.db.findById(session, resourceId);
    if (resource == null ||
        resource.roomId != roomId ||
        resource.status != 'active') {
      throw Exception('Room resource not found.');
    }
    return RoomEmbeddingService.indexResource(session, resourceId);
  }

  Future<List<RoomResourceChunk>> searchRoomKnowledge(
      Session session, int roomId, String query, int limit) async {
    final userId = await _requireActiveMember(session, roomId);
    await enforceRateLimit(
      session,
      userId: userId,
      action: 'search-room-knowledge',
      maximum: 30,
      window: const Duration(hours: 1),
    );
    final normalizedQuery = query.trim();
    if (normalizedQuery.isEmpty || normalizedQuery.length > 2000) {
      throw Exception('Knowledge search query is invalid.');
    }
    final apiKey =
        _openAiApiKey ?? ConfigurationSecrets.read(session, 'openAi');
    if (apiKey == null || apiKey.isEmpty || apiKey == 'replace-me') {
      throw Exception('Room embeddings are not configured.');
    }
    final embeddingResponse = await _httpClient.post(
      Uri.parse('https://api.openai.com/v1/embeddings'),
      headers: {
        'authorization': 'Bearer $apiKey',
        'content-type': 'application/json',
      },
      body: jsonEncode({
        'model': 'text-embedding-3-small',
        'input': normalizedQuery,
      }),
    );
    if (embeddingResponse.statusCode < 200 ||
        embeddingResponse.statusCode >= 300) {
      throw Exception('Room knowledge search failed.');
    }
    final payload = jsonDecode(embeddingResponse.body) as Map<String, dynamic>;
    final data = payload['data'];
    final rawQueryEmbedding = data is List<dynamic> && data.isNotEmpty
        ? (data.first as Map<String, dynamic>)['embedding']
        : null;
    if (rawQueryEmbedding is! List<dynamic> || rawQueryEmbedding.isEmpty) {
      throw Exception('Room knowledge search returned no embedding.');
    }
    final queryEmbedding =
        rawQueryEmbedding.map((value) => value as num).toList();
    return RoomKnowledgeSearchService.search(
      session,
      roomId: roomId,
      queryEmbedding: queryEmbedding,
      limit: limit,
    );
  }

  String _roomResourceContentType(String extension) {
    return switch (extension) {
      'pdf' => 'application/pdf',
      'doc' => 'application/msword',
      'docx' =>
        'application/vnd.openxmlformats-officedocument.wordprocessingml.document',
      'ppt' => 'application/vnd.ms-powerpoint',
      'pptx' =>
        'application/vnd.openxmlformats-officedocument.presentationml.presentation',
      'xlsx' =>
        'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
      'png' => 'image/png',
      'jpg' || 'jpeg' => 'image/jpeg',
      'webp' => 'image/webp',
      _ => 'text/plain',
    };
  }

  Future<List<ChallengeTeam>> getChallengeTeams(
    Session session,
    int challengeId,
  ) async {
    final challenge = await Challenge.db.findById(session, challengeId);
    if (challenge == null) throw Exception('Challenge not found.');
    if (challenge.roomId != null) {
      await _requireActiveMember(session, challenge.roomId!);
    }
    return ChallengeTeam.db.find(
      session,
      where: (t) =>
          t.challengeId.equals(challengeId) & t.status.equals('active'),
      orderBy: (t) => t.createdAt,
    );
  }

  Future<List<ChallengeTeamMember>> getChallengeTeamMembers(
      Session session, int teamId, int page, int limit) async {
    await _requireTeamMember(session, teamId);
    final safeLimit = limit.clamp(1, 100);
    return ChallengeTeamMember.db.find(
      session,
      where: (t) => t.teamId.equals(teamId),
      orderBy: (t) => t.joinedAt,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<ChallengeTeam> createChallengeTeam(
    Session session,
    int challengeId,
    String name,
    String? description,
  ) async {
    final ownerId = await getAuthenticatedUserId(session);
    await _requireNotRestricted(session, ownerId);
    final challenge = await Challenge.db.findById(session, challengeId);
    if (challenge == null) throw Exception('Challenge not found.');
    if (challenge.roomId != null) {
      await _requireActiveMember(session, challenge.roomId!);
    }
    if (name.trim().isEmpty) throw Exception('Team name is required.');
    return session.db.transaction((transaction) async {
      final now = DateTime.now();
      final team = await ChallengeTeam.db.insertRow(
        session,
        ChallengeTeam(
          challengeId: challengeId,
          ownerId: ownerId,
          name: name.trim(),
          description:
              description?.trim().isEmpty == true ? null : description?.trim(),
          status: 'active',
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      await ChallengeTeamMember.db.insertRow(
        session,
        ChallengeTeamMember(
          teamId: team.id!,
          userId: ownerId,
          role: 'owner',
          status: 'active',
          joinedAt: now,
        ),
        transaction: transaction,
      );
      final institutionId = challenge.roomId == null
          ? null
          : (await StudyRoom.db.findById(
              session,
              challenge.roomId!,
              transaction: transaction,
            ))
              ?.institutionId;
      await recordAuditEvent(
        session,
        actorId: ownerId,
        action: 'challenge_team_created',
        targetType: 'challenge_team',
        targetId: team.id!,
        institutionId: institutionId,
        metadata: 'challengeId=$challengeId',
        transaction: transaction,
      );
      return team;
    });
  }

  Future<ChallengeTeamMember> joinChallengeTeam(
      Session session, int teamId) async {
    final userId = await getAuthenticatedUserId(session);
    await _requireNotRestricted(session, userId);
    final team = await ChallengeTeam.db.findById(session, teamId);
    if (team == null || team.status != 'active') {
      throw Exception('Team not found.');
    }
    final challenge = await Challenge.db.findById(session, team.challengeId);
    if (challenge?.roomId != null) {
      await _requireActiveMember(session, challenge!.roomId!);
    }
    final existing = await ChallengeTeamMember.db.findFirstRow(
      session,
      where: (t) => t.teamId.equals(teamId) & t.userId.equals(userId),
    );
    if (existing != null) return existing;
    final member = await ChallengeTeamMember.db.insertRow(
      session,
      ChallengeTeamMember(
        teamId: teamId,
        userId: userId,
        role: 'member',
        status: 'active',
        joinedAt: DateTime.now(),
      ),
    );
    final institutionId = challenge?.roomId == null
        ? null
        : (await StudyRoom.db.findById(session, challenge!.roomId!))
            ?.institutionId;
    await recordAuditEvent(
      session,
      actorId: userId,
      action: 'challenge_team_member_joined',
      targetType: 'challenge_team_member',
      targetId: member.id!,
      institutionId: institutionId,
      metadata: 'teamId=$teamId',
    );
    return member;
  }

  Future<String> createChallengeTeamInvite(
    Session session,
    int teamId,
    int inviteeId,
    int expiresInDays,
  ) async {
    final inviterId = await _requireTeamMember(session, teamId);
    await _requireNotRestricted(session, inviterId);
    if (expiresInDays < 1 || expiresInDays > 30) {
      throw Exception('Invite expiry must be between 1 and 30 days.');
    }
    if (await UserInfo.db.findById(session, inviteeId) == null) {
      throw Exception('Invitee not found.');
    }
    final team = await ChallengeTeam.db.findById(session, teamId);
    if (team == null || team.status != 'active') {
      throw Exception('Team not found.');
    }
    final existing = await ChallengeTeamMember.db.findFirstRow(
      session,
      where: (t) =>
          t.teamId.equals(teamId) &
          t.userId.equals(inviteeId) &
          t.status.equals('active'),
    );
    if (existing != null) throw Exception('User is already on this team.');
    final token = base64UrlEncode(
      List<int>.generate(32, (_) => Random.secure().nextInt(256)),
    );
    final now = DateTime.now();
    final invite = await ChallengeTeamInvite.db.insertRow(
      session,
      ChallengeTeamInvite(
        teamId: teamId,
        inviterId: inviterId,
        inviteeId: inviteeId,
        tokenHash: sha256.convert(utf8.encode(token)).toString(),
        status: 'active',
        expiresAt: now.add(Duration(days: expiresInDays)),
        createdAt: now,
      ),
    );
    await recordAuditEvent(
      session,
      actorId: inviterId,
      action: 'challenge_team_invite_created',
      targetType: 'challenge_team_invite',
      targetId: invite.id!,
      institutionId: await _challengeInstitutionId(
        session,
        await _teamChallenge(session, teamId),
      ),
      metadata: 'teamId=$teamId;inviteeId=$inviteeId',
    );
    return token;
  }

  Future<ChallengeTeamMember> acceptChallengeTeamInvite(
    Session session,
    String token,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    await _requireNotRestricted(session, userId);
    final hash = sha256.convert(utf8.encode(token.trim())).toString();
    return session.db.transaction((transaction) async {
      final invite = await ChallengeTeamInvite.db.findFirstRow(
        session,
        where: (t) => t.tokenHash.equals(hash) & t.status.equals('active'),
        transaction: transaction,
      );
      if (invite == null || invite.inviteeId != userId) {
        throw Exception('Team invite not found.');
      }
      if (invite.expiresAt.isBefore(DateTime.now())) {
        invite.status = 'expired';
        await ChallengeTeamInvite.db.updateRow(
          session,
          invite,
          transaction: transaction,
        );
        throw Exception('Team invite has expired.');
      }
      final team = await ChallengeTeam.db.findById(
        session,
        invite.teamId,
        transaction: transaction,
      );
      if (team == null || team.status != 'active') {
        throw Exception('Team is no longer active.');
      }
      final existing = await ChallengeTeamMember.db.findFirstRow(
        session,
        where: (t) => t.teamId.equals(invite.teamId) & t.userId.equals(userId),
        transaction: transaction,
      );
      final member = existing ??
          await ChallengeTeamMember.db.insertRow(
            session,
            ChallengeTeamMember(
              teamId: invite.teamId,
              userId: userId,
              role: 'member',
              status: 'active',
              joinedAt: DateTime.now(),
            ),
            transaction: transaction,
          );
      invite.status = 'accepted';
      invite.acceptedAt = DateTime.now();
      await ChallengeTeamInvite.db.updateRow(
        session,
        invite,
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'challenge_team_invite_accepted',
        targetType: 'challenge_team_invite',
        targetId: invite.id!,
        institutionId: await _challengeInstitutionId(
          session,
          await _teamChallenge(session, invite.teamId),
        ),
        metadata: 'teamId=${invite.teamId}',
        transaction: transaction,
      );
      return member;
    });
  }

  Future<List<ChallengeMilestone>> getTeamMilestones(
      Session session, int teamId, int page, int limit) async {
    await _requireTeamMember(session, teamId);
    final safeLimit = limit.clamp(1, 50);
    return ChallengeMilestone.db.find(session,
        where: (t) => t.teamId.equals(teamId),
        orderBy: (t) => t.createdAt,
        limit: safeLimit,
        offset: (page < 0 ? 0 : page) * safeLimit);
  }

  Future<ChallengeMilestone> createMilestone(Session session, int teamId,
      String title, String? description, DateTime? dueAt) async {
    final userId = await _requireTeamMember(session, teamId);
    await _requireNotRestricted(session, userId);
    if (title.trim().isEmpty) throw Exception('Milestone title is required.');
    final challenge = await _teamChallenge(session, teamId);
    final now = DateTime.now();
    final milestone = await ChallengeMilestone.db.insertRow(
        session,
        ChallengeMilestone(
            teamId: teamId,
            title: title.trim(),
            description: description?.trim().isEmpty == true
                ? null
                : description?.trim(),
            status: 'open',
            dueAt: dueAt,
            createdAt: now,
            updatedAt: now));
    await recordAuditEvent(
      session,
      actorId: await getAuthenticatedUserId(session),
      action: 'challenge_milestone_created',
      targetType: 'challenge_milestone',
      targetId: milestone.id!,
      institutionId: await _challengeInstitutionId(session, challenge),
      metadata: 'teamId=$teamId',
    );
    return milestone;
  }

  Future<ChallengeMilestone> updateChallengeMilestone(
    Session session,
    int milestoneId,
    String title,
    String? description,
    String status,
    DateTime? dueAt,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final milestone =
        await ChallengeMilestone.db.findById(session, milestoneId);
    if (milestone == null ||
        title.trim().isEmpty ||
        !{'open', 'in_progress', 'completed'}.contains(status)) {
      throw Exception('Invalid milestone update.');
    }
    final team = await ChallengeTeam.db.findById(session, milestone.teamId);
    if (team == null || team.ownerId != userId) {
      throw Exception('Team owner role required.');
    }
    milestone.title = title.trim();
    milestone.description =
        description?.trim().isEmpty == true ? null : description?.trim();
    milestone.status = status;
    milestone.dueAt = dueAt;
    milestone.completedAt = status == 'completed' ? DateTime.now() : null;
    milestone.updatedAt = DateTime.now();
    final updated = await ChallengeMilestone.db.updateRow(session, milestone);
    final challenge = await _teamChallenge(session, milestone.teamId);
    await recordAuditEvent(
      session,
      actorId: userId,
      action: 'challenge_milestone_updated',
      targetType: 'challenge_milestone',
      targetId: updated.id!,
      institutionId: await _challengeInstitutionId(session, challenge),
      metadata: 'teamId=${milestone.teamId};status=$status',
    );
    return updated;
  }

  Future<ChallengeTeamMember> updateChallengeTeamMember(
    Session session,
    int membershipId,
    String role,
    String status,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    if (!{'member', 'lead', 'researcher'}.contains(role) ||
        !{'active', 'removed'}.contains(status)) {
      throw Exception('Invalid team member update.');
    }
    final member = await ChallengeTeamMember.db.findById(session, membershipId);
    if (member == null) throw Exception('Team member not found.');
    final team = await ChallengeTeam.db.findById(session, member.teamId);
    if (team == null || team.ownerId != userId) {
      throw Exception('Team owner role required.');
    }
    member.role = role;
    member.status = status;
    final updated = await ChallengeTeamMember.db.updateRow(session, member);
    final challenge = await _teamChallenge(session, member.teamId);
    await recordAuditEvent(
      session,
      actorId: userId,
      action: 'challenge_team_member_updated',
      targetType: 'challenge_team_member',
      targetId: updated.id!,
      institutionId: await _challengeInstitutionId(session, challenge),
      metadata:
          'teamId=${member.teamId};userId=${member.userId};status=$status',
    );
    return updated;
  }

  Future<List<ChallengeProgressUpdate>> getTeamUpdates(
      Session session, int teamId, int page, int limit) async {
    await _requireTeamMember(session, teamId);
    final safeLimit = limit.clamp(1, 50);
    return ChallengeProgressUpdate.db.find(session,
        where: (t) => t.teamId.equals(teamId) & t.status.equals('visible'),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: safeLimit,
        offset: (page < 0 ? 0 : page) * safeLimit);
  }

  Future<ChallengeProgressUpdate> postChallengeUpdate(
      Session session, int teamId, String body) async {
    final userId = await _requireTeamMember(session, teamId);
    await _requireNotRestricted(session, userId);
    if (body.trim().isEmpty) throw Exception('Update body is required.');
    final update = await ChallengeProgressUpdate.db.insertRow(
        session,
        ChallengeProgressUpdate(
            teamId: teamId,
            authorId: userId,
            body: body.trim(),
            status: 'visible',
            createdAt: DateTime.now()));
    final challenge = await _teamChallenge(session, teamId);
    await recordAuditEvent(
      session,
      actorId: userId,
      action: 'challenge_progress_update_created',
      targetType: 'challenge_progress_update',
      targetId: update.id!,
      institutionId: await _challengeInstitutionId(session, challenge),
      metadata: 'teamId=$teamId',
    );
    return update;
  }

  Future<int> _requireTeamMember(Session session, int teamId) async {
    final userId = await getAuthenticatedUserId(session);
    final member = await ChallengeTeamMember.db.findFirstRow(session,
        where: (t) =>
            t.teamId.equals(teamId) &
            t.userId.equals(userId) &
            t.status.equals('active'));
    if (member == null) {
      throw Exception('Active challenge team membership required.');
    }
    return userId;
  }

  Future<Challenge> _teamChallenge(Session session, int teamId) async {
    final team = await ChallengeTeam.db.findById(session, teamId);
    if (team == null || team.status != 'active') {
      throw Exception('Team not found.');
    }
    final challenge = await Challenge.db.findById(session, team.challengeId);
    if (challenge == null) throw Exception('Challenge not found.');
    return challenge;
  }

  Future<int?> _challengeInstitutionId(
    Session session,
    Challenge challenge,
  ) async {
    final roomId = challenge.roomId;
    if (roomId == null) return null;
    return (await StudyRoom.db.findById(session, roomId))?.institutionId;
  }

  Future<List<Comment>> getPostComments(
      Session session, int postId, int page, int limit) async {
    final post = await DiscussionPost.db.findById(session, postId);
    if (post == null || post.status != 'visible') {
      throw Exception('Post not found.');
    }
    await _requireActiveMember(session, post.roomId);
    final safeLimit = limit.clamp(1, 100);
    return Comment.db.find(session,
        where: (t) => t.postId.equals(postId) & t.status.equals('visible'),
        orderBy: (t) => t.createdAt,
        limit: safeLimit,
        offset: (page < 0 ? 0 : page) * safeLimit);
  }

  Future<Comment> createComment(
      Session session, int postId, String body, int? parentCommentId) async {
    final userId = await getAuthenticatedUserId(session);
    await _requireNotRestricted(session, userId);
    final post = await DiscussionPost.db.findById(session, postId);
    if (post == null || post.status != 'visible') {
      throw Exception('Post not found.');
    }
    await _requireActiveMember(session, post.roomId);
    if (body.trim().isEmpty) throw Exception('Comment body is required.');
    final now = DateTime.now();
    return session.db.transaction((transaction) async {
      final comment = await Comment.db.insertRow(
        session,
        Comment(
          postId: postId,
          authorId: userId,
          parentCommentId: parentCommentId,
          body: body.trim(),
          status: 'visible',
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      final room = await StudyRoom.db.findById(
        session,
        post.roomId,
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'discussion_comment_created',
        targetType: 'comment',
        targetId: comment.id!,
        institutionId: room?.institutionId,
        metadata: 'postId=$postId',
        transaction: transaction,
      );
      return comment;
    });
  }

  Future<DiscussionPost> acceptPostComment(
    Session session,
    int postId,
    int? commentId,
  ) async {
    final actorId = await getAuthenticatedUserId(session);
    final post = await DiscussionPost.db.findById(session, postId);
    if (post == null || post.status != 'visible') {
      throw Exception('Discussion post not found.');
    }
    final membership = await RoomMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.roomId.equals(post.roomId) &
          t.userId.equals(actorId) &
          t.status.equals('active'),
    );
    if (membership == null ||
        (post.authorId != actorId &&
            !{'owner', 'moderator'}.contains(membership.role))) {
      throw Exception('Post owner or room moderator required.');
    }
    Comment? comment;
    if (commentId != null) {
      comment = await Comment.db.findById(session, commentId);
      if (comment == null ||
          comment.postId != postId ||
          comment.status != 'visible') {
        throw Exception('Comment not found.');
      }
    }
    return session.db.transaction((transaction) async {
      final previousAcceptedCommentId = post.acceptedCommentId;
      post.acceptedCommentId = commentId;
      post.updatedAt = DateTime.now().toUtc();
      final updated = await DiscussionPost.db.updateRow(
        session,
        post,
        transaction: transaction,
      );
      final room = await StudyRoom.db.findById(
        session,
        post.roomId,
        transaction: transaction,
      );
      if (previousAcceptedCommentId != commentId) {
        if (previousAcceptedCommentId != null) {
          final previousComment = await Comment.db.findById(
            session,
            previousAcceptedCommentId,
            transaction: transaction,
          );
          if (previousComment != null) {
            await _adjustReputation(
              session,
              previousComment.authorId,
              scoreDelta: -10,
              acceptedDelta: -1,
              transaction: transaction,
            );
          }
        }
        if (comment != null) {
          await _adjustReputation(
            session,
            comment.authorId,
            scoreDelta: 10,
            acceptedDelta: 1,
            transaction: transaction,
          );
        }
      }
      await recordAuditEvent(
        session,
        actorId: actorId,
        action: commentId == null
            ? 'discussion_answer_unaccepted'
            : 'discussion_answer_accepted',
        targetType: 'discussion_post',
        targetId: postId,
        institutionId: room?.institutionId,
        metadata: 'commentId=$commentId',
        transaction: transaction,
      );
      return updated;
    });
  }

  Future<DiscussionReaction?> setPostReaction(
    Session session,
    int postId,
    String? reaction,
  ) async {
    final userId = await _requireActiveMemberForPost(session, postId);
    const allowedReactions = {'useful', 'insightful', 'support'};
    final normalized = reaction?.trim().toLowerCase();
    if (normalized != null && !allowedReactions.contains(normalized)) {
      throw Exception('Unsupported reaction.');
    }
    return session.db.transaction((transaction) async {
      final existing = await DiscussionReaction.db.findFirstRow(
        session,
        where: (t) => t.postId.equals(postId) & t.userId.equals(userId),
        transaction: transaction,
      );
      if (normalized == null) {
        if (existing != null) {
          await DiscussionReaction.db.deleteRow(
            session,
            existing,
            transaction: transaction,
          );
          final post = await DiscussionPost.db.findById(
            session,
            postId,
            transaction: transaction,
          );
          final room = post == null
              ? null
              : await StudyRoom.db.findById(
                  session,
                  post.roomId,
                  transaction: transaction,
                );
          await recordAuditEvent(
            session,
            actorId: userId,
            action: 'discussion_reaction_removed',
            targetType: 'discussion_post',
            targetId: postId,
            institutionId: room?.institutionId,
            metadata: 'reaction=${existing.reaction}',
            transaction: transaction,
          );
        }
        return null;
      }
      final now = DateTime.now().toUtc();
      final saved = existing ??
          DiscussionReaction(
            postId: postId,
            userId: userId,
            reaction: normalized,
            createdAt: now,
            updatedAt: now,
          );
      saved.reaction = normalized;
      saved.updatedAt = now;
      final result = saved.id == null
          ? DiscussionReaction.db.insertRow(
              session,
              saved,
              transaction: transaction,
            )
          : DiscussionReaction.db.updateRow(
              session,
              saved,
              transaction: transaction,
            );
      final persisted = await result;
      final post = await DiscussionPost.db.findById(
        session,
        postId,
        transaction: transaction,
      );
      final room = post == null
          ? null
          : await StudyRoom.db.findById(
              session,
              post.roomId,
              transaction: transaction,
            );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: existing == null
            ? 'discussion_reaction_created'
            : 'discussion_reaction_updated',
        targetType: 'discussion_post',
        targetId: postId,
        institutionId: room?.institutionId,
        metadata: 'reaction=$normalized',
        transaction: transaction,
      );
      return persisted;
    });
  }

  Future<int> _requireActiveMemberForPost(Session session, int postId) async {
    final userId = await getAuthenticatedUserId(session);
    final post = await DiscussionPost.db.findById(session, postId);
    if (post == null || post.status != 'visible') {
      throw Exception('Discussion post not found.');
    }
    await _requireActiveMember(session, post.roomId);
    return userId;
  }

  Stream<DiscussionPost> roomPostStream(Session session, int roomId) async* {
    await _requireActiveMember(session, roomId);
    yield* session.messages.createStream<DiscussionPost>('room_$roomId');
  }

  Future<List<RoomChatMessage>> getRoomChatMessages(
      Session session, int roomId, int page, int limit) async {
    await _requireActiveMember(session, roomId);
    final safeLimit = limit.clamp(1, 100);
    return RoomChatMessage.db.find(session,
        where: (t) => t.roomId.equals(roomId) & t.status.equals('visible'),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: safeLimit,
        offset: (page < 0 ? 0 : page) * safeLimit);
  }

  Stream<RoomChatMessage> roomChatStream(Session session, int roomId) async* {
    await _requireActiveMember(session, roomId);
    yield* session.messages.createStream<RoomChatMessage>('chat_$roomId');
  }

  Future<RoomChatMessage> createRoomChatMessage(
      Session session, int roomId, String body) async {
    final userId = await _requireActiveMember(session, roomId);
    await _requireNotRestricted(session, userId);
    if (body.trim().isEmpty) throw Exception('Chat message is required.');
    final message = await RoomChatMessage.db.insertRow(
        session,
        RoomChatMessage(
          roomId: roomId,
          authorId: userId,
          body: body.trim(),
          status: 'visible',
          createdAt: DateTime.now(),
        ));
    final room = await StudyRoom.db.findById(session, roomId);
    await recordAuditEvent(
      session,
      actorId: userId,
      action: 'room_chat_message_created',
      targetType: 'room_chat_message',
      targetId: message.id!,
      institutionId: room?.institutionId,
    );
    session.messages.postMessage('chat_$roomId', message);
    return message;
  }

  Future<List<RoomAiAnswer>> getRoomAiAnswers(
      Session session, int roomId, int page, int limit) async {
    await _requireActiveMember(session, roomId);
    final safeLimit = limit.clamp(1, 50);
    return RoomAiAnswer.db.find(session,
        where: (t) => t.roomId.equals(roomId),
        orderBy: (t) => t.createdAt,
        orderDescending: true,
        limit: safeLimit,
        offset: (page < 0 ? 0 : page) * safeLimit);
  }

  Future<RoomAiAnswer> askRoom(
      Session session, int roomId, String question) async {
    final askerId = await _requireActiveMember(session, roomId);
    await enforceRateLimit(
      session,
      userId: askerId,
      action: 'ask-room-ai',
      maximum: 20,
      window: const Duration(hours: 1),
    );
    final normalizedQuestion = question.trim();
    if (normalizedQuestion.isEmpty || normalizedQuestion.length > 4000) {
      throw Exception('Question is invalid.');
    }
    final resources = await RoomResource.db.find(
      session,
      where: (t) => t.roomId.equals(roomId) & t.status.equals('active'),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: 25,
    );
    if (resources.isEmpty) {
      throw Exception('Add a room source before asking the room AI.');
    }
    final apiKey =
        _openAiApiKey ?? ConfigurationSecrets.read(session, 'openAi');
    if (apiKey == null || apiKey.isEmpty || apiKey == 'replace-me') {
      throw Exception('Room AI is not configured.');
    }
    final sourceContext = resources.asMap().entries.map((entry) {
      final index = entry.key + 1;
      final resource = entry.value;
      final text = (resource.content ?? resource.citation ?? resource.uri ?? '')
          .trim()
          .replaceAll(RegExp(r'\s+'), ' ');
      return '[R${resource.id ?? index}] ${resource.title}: '
          '${text.substring(0, text.length > 12000 ? 12000 : text.length)}';
    }).join('\n');
    final response = await _httpClient.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'authorization': 'Bearer $apiKey',
        'content-type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-4o-mini',
        'temperature': 0.2,
        'messages': [
          {
            'role': 'system',
            'content':
                'Answer only from the supplied room sources. Cite every material claim with [R{id}]. If the sources do not support an answer, say so.',
          },
          {
            'role': 'user',
            'content': '$sourceContext\n\nQuestion: $normalizedQuestion'
          },
        ],
      }),
    );
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Room AI request failed.');
    }
    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = payload['choices'] as List<dynamic>?;
    final answer = choices?.isNotEmpty == true
        ? ((choices!.first as Map<String, dynamic>)['message']
                as Map<String, dynamic>)['content']
            ?.toString()
            .trim()
        : null;
    if (answer == null || answer.isEmpty) {
      throw Exception('Room AI returned no answer.');
    }
    final citedIds = RegExp(r'\[R(\d+)\]')
        .allMatches(answer)
        .map((match) => int.tryParse(match.group(1)!))
        .whereType<int>()
        .where((id) => resources.any((resource) => resource.id == id))
        .toSet()
        .toList();
    if (citedIds.isEmpty) {
      throw Exception('Room AI returned no valid citations.');
    }
    return RoomAiAnswer.db.insertRow(
      session,
      RoomAiAnswer(
        roomId: roomId,
        askerId: askerId,
        question: normalizedQuestion,
        answer: answer,
        sourceResourceIds: citedIds,
        citations: citedIds.map((id) => '[R$id]').toList(),
        confidence: 'grounded',
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<CollaborationPresence> updateRoomPresence(
      Session session, int roomId, String state) async {
    final userId = await _requireActiveMember(session, roomId);
    if (!{'online', 'away', 'offline'}.contains(state)) {
      throw Exception('Invalid presence state.');
    }
    final existing = await CollaborationPresence.db.findFirstRow(session,
        where: (t) =>
            t.userId.equals(userId) &
            t.scopeType.equals('room') &
            t.scopeId.equals(roomId));
    final presence = existing ??
        CollaborationPresence(
          userId: userId,
          scopeType: 'room',
          scopeId: roomId,
          state: state,
          lastSeenAt: DateTime.now(),
        );
    presence.state = state;
    presence.lastSeenAt = DateTime.now();
    return presence.id == null
        ? CollaborationPresence.db.insertRow(session, presence)
        : CollaborationPresence.db.updateRow(session, presence);
  }

  Future<List<CollaborationPresence>> getRoomPresence(
      Session session, int roomId) async {
    await _requireActiveMember(session, roomId);
    return CollaborationPresence.db.find(session,
        where: (t) => t.scopeType.equals('room') & t.scopeId.equals(roomId));
  }

  Future<List<ScheduledStudySession>> getRoomStudySessions(
      Session session, int roomId, int page, int limit) async {
    await _requireActiveMember(session, roomId);
    final safeLimit = limit.clamp(1, 50);
    return ScheduledStudySession.db.find(session,
        where: (t) => t.roomId.equals(roomId) & t.status.equals('scheduled'),
        orderBy: (t) => t.startsAt,
        limit: safeLimit,
        offset: (page < 0 ? 0 : page) * safeLimit);
  }

  Future<ScheduledStudySession> createStudySession(
      Session session,
      int roomId,
      String title,
      String? description,
      DateTime startsAt,
      DateTime endsAt,
      String? meetingUrl) async {
    final userId = await _requireActiveMember(session, roomId);
    await _requireNotRestricted(session, userId);
    final normalizedMeetingUrl = meetingUrl?.trim();
    if (!endsAt.isAfter(startsAt) ||
        title.trim().isEmpty ||
        title.trim().length > 300 ||
        (description?.length ?? 0) > 5000) {
      throw Exception('Invalid study session.');
    }
    if (normalizedMeetingUrl != null && normalizedMeetingUrl.isNotEmpty) {
      final uri = Uri.tryParse(normalizedMeetingUrl);
      if (uri == null ||
          !{'http', 'https'}.contains(uri.scheme) ||
          normalizedMeetingUrl.length > 2000) {
        throw Exception('Meeting URL is invalid.');
      }
    }
    return session.db.transaction((transaction) async {
      final now = DateTime.now();
      final scheduled = await ScheduledStudySession.db.insertRow(
        session,
        ScheduledStudySession(
          roomId: roomId,
          organizerId: userId,
          title: title.trim(),
          description:
              description?.trim().isEmpty == true ? null : description?.trim(),
          startsAt: startsAt,
          endsAt: endsAt,
          meetingUrl: normalizedMeetingUrl?.isEmpty == true
              ? null
              : normalizedMeetingUrl,
          status: 'scheduled',
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'study_session_created',
        targetType: 'scheduled_study_session',
        targetId: scheduled.id!,
        institutionId: (await StudyRoom.db.findById(
          session,
          roomId,
          transaction: transaction,
        ))
            ?.institutionId,
        transaction: transaction,
      );
      return scheduled;
    });
  }

  Future<StudySessionParticipant> joinStudySession(
      Session session, int sessionId) async {
    final userId = await getAuthenticatedUserId(session);
    await _requireNotRestricted(session, userId);
    final studySession =
        await ScheduledStudySession.db.findById(session, sessionId);
    if (studySession == null || studySession.status != 'scheduled') {
      throw Exception('Study session not found.');
    }
    await _requireActiveMember(session, studySession.roomId);
    final existing = await StudySessionParticipant.db.findFirstRow(session,
        where: (t) => t.sessionId.equals(sessionId) & t.userId.equals(userId));
    if (existing != null) return existing;
    return session.db.transaction((transaction) async {
      final participant = await StudySessionParticipant.db.insertRow(
        session,
        StudySessionParticipant(
          sessionId: sessionId,
          userId: userId,
          status: 'joined',
          joinedAt: DateTime.now(),
        ),
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: userId,
        action: 'study_session_joined',
        targetType: 'study_session_participant',
        targetId: participant.id!,
        transaction: transaction,
      );
      return participant;
    });
  }

  Future<ContentReport> reportContent(
    Session session,
    String contentType,
    int contentId,
    String reason,
    String? details,
  ) async {
    final reporterId = await getAuthenticatedUserId(session);
    await enforceRateLimit(
      session,
      userId: reporterId,
      action: 'report-content',
      maximum: 20,
      window: const Duration(hours: 1),
    );
    if (!{'post', 'comment', 'file', 'profile', 'challenge', 'ai_output'}
        .contains(contentType)) {
      throw Exception('Unsupported report content type.');
    }
    final text = [
      reason.trim(),
      if (details?.trim().isNotEmpty == true) details!.trim()
    ].join(': ');
    if (text.isEmpty) throw Exception('Report reason is required.');
    return session.db.transaction((transaction) async {
      final report = await ContentReport.db.insertRow(
        session,
        ContentReport(
          reporterId: reporterId,
          contentType: contentType,
          contentId: contentId,
          reason: text,
          status: 'open',
          createdAt: DateTime.now(),
        ),
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: reporterId,
        action: 'content_report_created',
        targetType: contentType,
        targetId: contentId,
        institutionId: await _reportedInstitutionId(
          session,
          report,
          transaction,
        ),
        metadata: 'reportId=${report.id}',
        transaction: transaction,
      );
      return report;
    });
  }

  Future<List<ContentReport>> getOpenReports(Session session,
      {int page = 0, int limit = 50}) async {
    await _requirePlatformModerator(session);
    final safeLimit = limit.clamp(1, 100);
    return ContentReport.db.find(session,
        where: (t) => t.status.equals('open'),
        orderBy: (t) => t.createdAt,
        limit: safeLimit,
        offset: (page < 0 ? 0 : page) * safeLimit);
  }

  Future<List<ContentReport>> getMyContentReports(Session session,
      {int page = 0, int limit = 50}) async {
    final userId = await getAuthenticatedUserId(session);
    final safeLimit = limit.clamp(1, 100);
    return ContentReport.db.find(
      session,
      where: (t) => t.reporterId.equals(userId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<List<AuditEvent>> getAuditEvents(
    Session session, {
    String? targetType,
    int? targetId,
    int page = 0,
    int limit = 50,
  }) async {
    await _requirePlatformModerator(session);
    final safeLimit = limit.clamp(1, 100);
    final normalizedTargetType = targetType?.trim();
    return AuditEvent.db.find(
      session,
      where: (t) {
        var expression = t.id.notEquals(-1);
        if (normalizedTargetType?.isNotEmpty == true) {
          expression = expression & t.targetType.equals(normalizedTargetType!);
        }
        if (targetId != null) {
          expression = expression & t.targetId.equals(targetId);
        }
        return expression;
      },
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<List<AuditEvent>> getInstitutionAuditEvents(
    Session session,
    int institutionId, {
    int page = 0,
    int limit = 50,
  }) async {
    final userId = await getAuthenticatedUserId(session);
    final membership = await InstitutionMembership.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.institutionId.equals(institutionId) &
          t.status.equals('verified'),
    );
    if (membership == null ||
        !{'institution_admin', 'moderator'}.contains(membership.role)) {
      throw Exception('Institution moderator role required.');
    }
    final safeLimit = limit.clamp(1, 100);
    final filtered = <AuditEvent>[];
    filtered.addAll(await AuditEvent.db.find(
      session,
      where: (t) =>
          t.targetType.equals('institution') & t.targetId.equals(institutionId),
    ));
    final institutionMemberships = await InstitutionMembership.db.find(
      session,
      limit: 500,
    );
    for (final targetMembership in institutionMemberships.where(
      (item) => item.institutionId == institutionId,
    )) {
      final membershipEvents = await AuditEvent.db.find(
        session,
        where: (t) =>
            t.targetType.equals('institution_membership') &
            t.targetId.equals(targetMembership.id!),
      );
      filtered.addAll(membershipEvents);
    }
    final directlyScoped = await AuditEvent.db.find(
      session,
      where: (t) => t.institutionId.equals(institutionId),
    );
    filtered.addAll(directlyScoped);
    filtered.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    final start = (page < 0 ? 0 : page) * safeLimit;
    return filtered.skip(start).take(safeLimit).toList();
  }

  Future<ModerationAppeal> submitModerationAppeal(
    Session session,
    int reportId,
    String reason,
  ) async {
    final appellantId = await getAuthenticatedUserId(session);
    final report = await ContentReport.db.findById(session, reportId);
    if (report == null || report.status == 'open') {
      throw Exception('Only resolved moderation actions can be appealed.');
    }
    final subjectId = await _reportedSubjectId(session, report);
    if (subjectId != appellantId) {
      throw Exception('Only the affected user can appeal this action.');
    }
    final normalizedReason = reason.trim();
    if (normalizedReason.length < 10 || normalizedReason.length > 5000) {
      throw Exception('Appeal reason must be between 10 and 5000 characters.');
    }
    final existing = await ModerationAppeal.db.findFirstRow(
      session,
      where: (t) =>
          t.reportId.equals(reportId) & t.appellantId.equals(appellantId),
    );
    if (existing != null) return existing;
    return session.db.transaction((transaction) async {
      final appeal = await ModerationAppeal.db.insertRow(
        session,
        ModerationAppeal(
          reportId: reportId,
          appellantId: appellantId,
          reason: normalizedReason,
          status: 'pending',
          createdAt: DateTime.now(),
        ),
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: appellantId,
        action: 'moderation_appeal_submitted',
        targetType: 'moderation_appeal',
        targetId: appeal.id!,
        institutionId: await _reportedInstitutionId(
          session,
          report,
          transaction,
        ),
        metadata: 'reportId=$reportId',
        transaction: transaction,
      );
      return appeal;
    });
  }

  Future<List<ModerationAppeal>> getMyModerationAppeals(
    Session session,
    int page,
    int limit,
  ) async {
    final appellantId = await getAuthenticatedUserId(session);
    final safeLimit = limit.clamp(1, 100);
    return ModerationAppeal.db.find(
      session,
      where: (t) => t.appellantId.equals(appellantId),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<List<ModerationAppeal>> getPendingModerationAppeals(
    Session session, {
    int page = 0,
    int limit = 50,
  }) async {
    await _requirePlatformModerator(session);
    final safeLimit = limit.clamp(1, 100);
    return ModerationAppeal.db.find(
      session,
      where: (t) => t.status.equals('pending'),
      orderBy: (t) => t.createdAt,
      orderDescending: false,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<ModerationAppeal> reviewModerationAppeal(
    Session session,
    int appealId,
    String decision,
    String? notes,
  ) async {
    final reviewerId = await _requirePlatformModerator(session);
    if (!{'approved', 'rejected'}.contains(decision)) {
      throw Exception('Unsupported appeal decision.');
    }
    return session.db.transaction((transaction) async {
      final appeal = await ModerationAppeal.db.findById(
        session,
        appealId,
        transaction: transaction,
      );
      if (appeal == null || appeal.status != 'pending') {
        throw Exception('Pending appeal not found.');
      }
      final report = await ContentReport.db.findById(
        session,
        appeal.reportId,
        transaction: transaction,
      );
      if (report == null) throw Exception('Appealed report not found.');
      if (decision == 'approved') {
        final moderation = await ModerationLog.db.find(
          session,
          where: (t) => t.reportId.equals(report.id!),
          orderBy: (t) => t.createdAt,
          orderDescending: true,
          limit: 1,
          transaction: transaction,
        );
        if (moderation.isNotEmpty) {
          await _reverseModeration(
            session,
            report,
            moderation.first.action,
            transaction,
          );
        }
      }
      appeal.status = decision;
      appeal.reviewerId = reviewerId;
      appeal.reviewNotes = notes?.trim().isEmpty == true ? null : notes?.trim();
      appeal.reviewedAt = DateTime.now();
      final updated = await ModerationAppeal.db.updateRow(
        session,
        appeal,
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: reviewerId,
        action: 'moderation_appeal_reviewed',
        targetType: 'moderation_appeal',
        targetId: appeal.id!,
        metadata: 'decision=$decision;reportId=${report.id}',
        transaction: transaction,
      );
      await Notification.db.insertRow(
        session,
        Notification(
          userId: appeal.appellantId,
          message: 'Your moderation appeal was $decision.',
          relatedId: appeal.id,
          type: 'moderation_appeal',
          isRead: false,
          createdAt: DateTime.now(),
        ),
        transaction: transaction,
      );
      return updated;
    });
  }

  Future<int?> _reportedSubjectId(
    Session session,
    ContentReport report,
  ) async {
    switch (report.contentType) {
      case 'profile':
        return report.contentId;
      case 'post':
        return (await DiscussionPost.db.findById(session, report.contentId))
            ?.authorId;
      case 'comment':
        return (await Comment.db.findById(session, report.contentId))?.authorId;
      case 'file':
        return (await RoomResource.db.findById(session, report.contentId))
            ?.ownerId;
      case 'challenge':
        return (await Challenge.db.findById(session, report.contentId))
            ?.ownerId;
      case 'ai_output':
        return (await RoomAiAnswer.db.findById(session, report.contentId))
            ?.askerId;
      default:
        return null;
    }
  }

  Future<int?> _reportedInstitutionId(
    Session session,
    ContentReport report,
    dynamic transaction,
  ) async {
    int? roomId;
    if (report.contentType == 'post') {
      roomId = (await DiscussionPost.db.findById(
        session,
        report.contentId,
        transaction: transaction,
      ))
          ?.roomId;
    } else if (report.contentType == 'comment') {
      final comment = await Comment.db.findById(
        session,
        report.contentId,
        transaction: transaction,
      );
      if (comment != null) {
        roomId = (await DiscussionPost.db.findById(
          session,
          comment.postId,
          transaction: transaction,
        ))
            ?.roomId;
      }
    } else if (report.contentType == 'file') {
      roomId = (await RoomResource.db.findById(
        session,
        report.contentId,
        transaction: transaction,
      ))
          ?.roomId;
    } else if (report.contentType == 'challenge') {
      roomId = (await Challenge.db.findById(
        session,
        report.contentId,
        transaction: transaction,
      ))
          ?.roomId;
    }
    if (roomId == null) return null;
    return (await StudyRoom.db.findById(
      session,
      roomId,
      transaction: transaction,
    ))
        ?.institutionId;
  }

  Future<void> _reverseModeration(
    Session session,
    ContentReport report,
    String action,
    dynamic transaction,
  ) async {
    if (action == 'remove') {
      if (report.contentType == 'post') {
        final item = await DiscussionPost.db.findById(
          session,
          report.contentId,
          transaction: transaction,
        );
        if (item != null) {
          item.status = 'visible';
          await DiscussionPost.db
              .updateRow(session, item, transaction: transaction);
        }
      } else if (report.contentType == 'comment') {
        final item = await Comment.db.findById(
          session,
          report.contentId,
          transaction: transaction,
        );
        if (item != null) {
          item.status = 'visible';
          await Comment.db.updateRow(session, item, transaction: transaction);
        }
      } else if (report.contentType == 'file') {
        final item = await RoomResource.db.findById(
          session,
          report.contentId,
          transaction: transaction,
        );
        if (item != null) {
          item.status = 'active';
          await RoomResource.db
              .updateRow(session, item, transaction: transaction);
        }
      } else if (report.contentType == 'challenge') {
        final item = await Challenge.db.findById(
          session,
          report.contentId,
          transaction: transaction,
        );
        if (item != null) {
          item.status = 'open';
          await Challenge.db.updateRow(session, item, transaction: transaction);
        }
      }
    }
    if (action == 'restrict' || action == 'suspend') {
      final subjectId = await _reportedSubjectId(session, report);
      if (subjectId != null) {
        final restriction = await UserRestriction.db.findFirstRow(
          session,
          where: (t) =>
              t.userId.equals(subjectId) &
              t.restrictionType.equals(action) &
              t.active.equals(true),
          transaction: transaction,
        );
        if (restriction != null) {
          restriction.active = false;
          await UserRestriction.db.updateRow(
            session,
            restriction,
            transaction: transaction,
          );
        }
      }
    }
  }

  Future<ContentReport> resolveReport(
      Session session, int reportId, String action, String? notes) async {
    final moderatorId = await _requirePlatformModerator(session);
    const actions = {'dismiss', 'remove', 'restrict', 'suspend'};
    if (!actions.contains(action)) {
      throw Exception('Unsupported moderation action.');
    }
    return session.db.transaction((transaction) async {
      final report = await ContentReport.db.findById(
        session,
        reportId,
        transaction: transaction,
      );
      if (report == null || report.status != 'open') {
        throw Exception('Open report not found.');
      }
      if (action == 'remove') {
        await _hideReportedContent(session, report, transaction);
      }
      if (action == 'restrict' || action == 'suspend') {
        await UserRestriction.db.insertRow(
          session,
          UserRestriction(
            userId: report.contentType == 'profile'
                ? report.contentId
                : report.reporterId,
            restrictionType: action,
            reason: notes?.trim().isEmpty == true
                ? 'Moderation action from report $reportId'
                : notes!.trim(),
            active: true,
            createdAt: DateTime.now(),
          ),
          transaction: transaction,
        );
      }
      report.status = action == 'dismiss' ? 'dismissed' : 'resolved';
      report.resolvedAt = DateTime.now();
      final updated = await ContentReport.db.updateRow(
        session,
        report,
        transaction: transaction,
      );
      await ModerationLog.db.insertRow(
        session,
        ModerationLog(
          reportId: reportId,
          moderatorId: moderatorId,
          action: action,
          targetType: report.contentType,
          targetId: report.contentId,
          note: notes?.trim().isEmpty == true ? null : notes?.trim(),
          createdAt: DateTime.now(),
        ),
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: moderatorId,
        action: 'content_report_resolved',
        targetType: report.contentType,
        targetId: report.contentId,
        institutionId: await _reportedInstitutionId(
          session,
          report,
          transaction,
        ),
        metadata: 'action=$action;reportId=${report.id}',
        transaction: transaction,
      );
      final subjectId = await _reportedSubjectId(session, report);
      if (subjectId != null && subjectId != moderatorId) {
        await Notification.db.insertRow(
          session,
          Notification(
            userId: subjectId,
            message:
                'A moderator resolved your ${report.contentType} report: $action.',
            relatedId: report.id,
            type: 'moderation_report',
            isRead: false,
            createdAt: DateTime.now(),
          ),
          transaction: transaction,
        );
      }
      return updated;
    });
  }

  Future<int> _requirePlatformModerator(Session session) async {
    final userId = await getAuthenticatedUserId(session);
    final profile = await UserProfile.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    if (profile == null || !{'admin', 'moderator'}.contains(profile.role)) {
      throw Exception('Platform moderator role required.');
    }
    return userId;
  }

  Future<void> _hideReportedContent(
    Session session,
    ContentReport report,
    dynamic transaction,
  ) async {
    if (report.contentType == 'post') {
      final post = await DiscussionPost.db.findById(
        session,
        report.contentId,
        transaction: transaction,
      );
      if (post != null) {
        post.status = 'removed';
        await DiscussionPost.db
            .updateRow(session, post, transaction: transaction);
      }
    } else if (report.contentType == 'comment') {
      final comment = await Comment.db.findById(
        session,
        report.contentId,
        transaction: transaction,
      );
      if (comment != null) {
        comment.status = 'removed';
        await Comment.db.updateRow(session, comment, transaction: transaction);
      }
    } else if (report.contentType == 'file') {
      final resource = await RoomResource.db.findById(
        session,
        report.contentId,
        transaction: transaction,
      );
      if (resource != null) {
        resource.status = 'removed';
        await RoomResource.db
            .updateRow(session, resource, transaction: transaction);
      }
    } else if (report.contentType == 'challenge') {
      final challenge = await Challenge.db.findById(
        session,
        report.contentId,
        transaction: transaction,
      );
      if (challenge != null) {
        challenge.status = 'archived';
        await Challenge.db
            .updateRow(session, challenge, transaction: transaction);
      }
    }
  }

  Future<List<CollaborativeDocument>> getRoomDocuments(
      Session session, int roomId, int page, int limit) async {
    await _requireActiveMember(session, roomId);
    final safeLimit = limit.clamp(1, 50);
    return CollaborativeDocument.db.find(session,
        where: (t) => t.roomId.equals(roomId) & t.status.equals('active'),
        orderBy: (t) => t.updatedAt,
        orderDescending: true,
        limit: safeLimit,
        offset: (page < 0 ? 0 : page) * safeLimit);
  }

  Stream<CollaborativeDocument> documentStream(
      Session session, int documentId) async* {
    final document =
        await CollaborativeDocument.db.findById(session, documentId);
    if (document == null) throw Exception('Document not found.');
    await _requireActiveMember(session, document.roomId);
    yield* session.messages
        .createStream<CollaborativeDocument>('document_$documentId');
  }

  Future<CollaborativeDocument> createDocument(
      Session session, int roomId, String title, String body) async {
    final ownerId = await _requireActiveMember(session, roomId);
    await _requireNotRestricted(session, ownerId);
    if (title.trim().isEmpty) throw Exception('Document title is required.');
    final now = DateTime.now();
    return session.db.transaction((transaction) async {
      final document = await CollaborativeDocument.db.insertRow(
        session,
        CollaborativeDocument(
          roomId: roomId,
          ownerId: ownerId,
          title: title.trim(),
          body: body,
          version: 1,
          status: 'active',
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      final room = await StudyRoom.db.findById(
        session,
        roomId,
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: ownerId,
        action: 'collaborative_document_created',
        targetType: 'collaborative_document',
        targetId: document.id!,
        institutionId: room?.institutionId,
        transaction: transaction,
      );
      return document;
    });
  }

  Future<CollaborativeDocument> updateDocument(Session session, int documentId,
      String title, String body, int expectedVersion) async {
    final actorId = await getAuthenticatedUserId(session);
    await _requireNotRestricted(session, actorId);
    final document =
        await CollaborativeDocument.db.findById(session, documentId);
    if (document == null) throw Exception('Document not found.');
    await _requireActiveMember(session, document.roomId);
    if (document.version != expectedVersion) {
      throw Exception('Document version conflict.');
    }
    document.title = title.trim();
    document.body = body;
    document.version += 1;
    document.updatedAt = DateTime.now();
    final updated = await session.db.transaction((transaction) async {
      final saved = await CollaborativeDocument.db.updateRow(
        session,
        document,
        transaction: transaction,
      );
      final room = await StudyRoom.db.findById(
        session,
        document.roomId,
        transaction: transaction,
      );
      await recordAuditEvent(
        session,
        actorId: actorId,
        action: 'collaborative_document_updated',
        targetType: 'collaborative_document',
        targetId: document.id!,
        institutionId: room?.institutionId,
        metadata: 'version=${document.version}',
        transaction: transaction,
      );
      return saved;
    });
    session.messages.postMessage('document_$documentId', updated);
    return updated;
  }

  Future<int> _requireActiveMember(Session session, int roomId) async {
    final userId = await getAuthenticatedUserId(session);
    final membership = await RoomMembership.db.findFirstRow(session,
        where: (t) =>
            t.roomId.equals(roomId) &
            t.userId.equals(userId) &
            t.status.equals('active'));
    if (membership == null) throw Exception('Active room membership required.');
    return userId;
  }

  Future<void> _adjustReputation(
    Session session,
    int userId, {
    required int scoreDelta,
    int acceptedDelta = 0,
    int verifiedDelta = 0,
    dynamic transaction,
  }) async {
    final existing = await UserReputation.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
      transaction: transaction,
    );
    final reputation = existing ??
        UserReputation(
          userId: userId,
          score: 0,
          acceptedSolutions: 0,
          verifiedContributions: 0,
          updatedAt: DateTime.now(),
        );
    reputation.score = max(0, reputation.score + scoreDelta);
    reputation.acceptedSolutions =
        max(0, reputation.acceptedSolutions + acceptedDelta);
    reputation.verifiedContributions =
        max(0, reputation.verifiedContributions + verifiedDelta);
    reputation.updatedAt = DateTime.now();
    if (reputation.id == null) {
      await UserReputation.db.insertRow(
        session,
        reputation,
        transaction: transaction,
      );
    } else {
      await UserReputation.db.updateRow(
        session,
        reputation,
        transaction: transaction,
      );
    }
  }

  Future<void> _requireNotRestricted(Session session, int userId) async {
    final restriction = await UserRestriction.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId) & t.active.equals(true),
    );
    if (restriction != null &&
        (restriction.expiresAt == null ||
            restriction.expiresAt!.isAfter(DateTime.now()))) {
      throw Exception('This account is currently restricted.');
    }
  }
}
