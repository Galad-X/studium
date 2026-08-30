import 'dart:convert';
import 'dart:typed_data';

import 'package:archive/archive.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:serverpod/serverpod.dart';
import 'package:test/test.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';
import 'package:studium_server/src/generated/protocol.dart';
import 'package:studium_server/src/endpoints/collaboration_endpoint.dart';
import 'package:studium_server/src/endpoints/opportunity_endpoint.dart';
import 'package:studium_server/src/endpoints/messaging_endpoint.dart';
import 'package:studium_server/src/endpoints/subscription_endpoint.dart';
import 'package:studium_server/src/endpoints/billing_webhook_endpoint.dart';
import 'package:studium_server/src/endpoints/operations_endpoint.dart';
import 'package:studium_server/src/endpoints/user_endpoint.dart';
import 'package:studium_server/src/services/background_job_service.dart';
import 'package:studium_server/src/services/background_job_handlers.dart';
import 'package:studium_server/src/services/background_worker_service.dart';
import 'package:studium_server/src/services/aws_s3_service.dart';
import 'package:studium_server/src/services/email_delivery_service.dart';
import 'package:studium_server/src/services/push_delivery_service.dart';
import 'package:studium_server/src/services/opportunity_source_refresh_service.dart';
import 'package:studium_server/src/services/payment_refund_service.dart';
import 'package:studium_server/src/services/payment_settlement_service.dart';
import 'package:studium_server/src/services/room_resource_text_extractor.dart';
import 'package:studium_server/src/services/room_knowledge_search_service.dart';
import 'test_tools/serverpod_test_tools.dart';

class _FakeRoomStorage extends AwsS3Service {
  _FakeRoomStorage()
      : super(
          accessKey: 'test-access',
          secretKey: 'test-secret',
          region: 'test-region',
          bucketName: 'test-bucket',
        );

  final uploadedKeys = <String>[];

  @override
  Future<String> uploadFile(
    String filePath,
    Uint8List bytes,
    String contentType,
  ) async {
    uploadedKeys.add(filePath);
    return 'https://storage.test/$filePath';
  }

  @override
  Future<void> deleteFile(String filePath, {Session? session}) async {}
}

void main() {
  withServerpod('Collaboration endpoint authorization',
      (sessionBuilder, endpoints) {
    test('rejects unauthenticated institution searches', () async {
      await expectLater(
        endpoints.collaboration.searchInstitutions(sessionBuilder, '', 0, 20),
        throwsA(isA<Exception>()),
      );
    });

    test('reputation reads require authentication and start at zero', () async {
      await expectLater(
        endpoints.collaboration.getMyReputation(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      final authenticated = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo('1005', {}),
      );
      final reputation = await endpoints.collaboration.getMyReputation(
        authenticated,
      );
      expect(reputation.userId, 1005);
      expect(reputation.score, 0);
      expect(reputation.acceptedSolutions, 0);
    });

    test('profile updates cannot change the authorization role', () async {
      final authenticated = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo('1002', {}),
      );
      final session = authenticated.build();
      try {
        final now = DateTime.now();
        await UserInfo.db.insertRow(
          session,
          UserInfo(
            id: 1002,
            userIdentifier: '1002',
            userName: 'profile-user',
            email: 'profile-user@example.edu',
            created: now,
            scopeNames: const [],
            blocked: false,
          ),
        );
        await UserProfile.db.insertRow(
          session,
          UserProfile(userId: 1002, role: 'free'),
        );
        final updated = await UserEndpoint().updateProfile(
          session,
          name: 'Updated profile',
        );
        expect(updated.name, 'Updated profile');
        expect(updated.role, 'free');
      } finally {
        await session.close();
      }
    });

    test('minor privacy settings disable unknown direct messages', () async {
      final recipientBuilder = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo('1003', {}),
      );
      final recipientSession = recipientBuilder.build();
      try {
        final now = DateTime.now();
        await UserInfo.db.insert(
          recipientSession,
          [
            UserInfo(
              id: 1002,
              userIdentifier: 'sender',
              userName: 'sender',
              email: 'sender@example.edu',
              created: now,
              scopeNames: const [],
              blocked: false,
            ),
            UserInfo(
              id: 1003,
              userIdentifier: 'recipient',
              userName: 'recipient',
              email: 'recipient@example.edu',
              created: now,
              scopeNames: const [],
              blocked: false,
            ),
            UserInfo(
              id: 1004,
              userIdentifier: 'group-member',
              userName: 'group-member',
              email: 'group-member@example.edu',
              created: now,
              scopeNames: const [],
              blocked: false,
            ),
          ],
        );
        final senderBuilder = sessionBuilder.copyWith(
          authentication: AuthenticationOverride.authenticationInfo('1002', {}),
        );
        final existingConversation =
            await endpoints.messaging.createConversation(
          senderBuilder,
          const [1003],
          'Existing conversation',
        );
        final settings = await MessagingEndpoint().updateMyPrivacySettings(
          recipientSession,
          isMinor: true,
          allowUnknownDirectMessages: true,
        );
        expect(settings.isMinor, isTrue);
        expect(settings.allowUnknownDirectMessages, isFalse);

        await expectLater(
          endpoints.messaging.createConversation(
            senderBuilder,
            const [1003],
            'Restricted direct message',
          ),
          throwsA(isA<Exception>()),
        );
        await expectLater(
          endpoints.messaging.sendMessage(
            senderBuilder,
            existingConversation.id!,
            'Privacy must apply to existing conversations.',
          ),
          throwsA(isA<Exception>()),
        );
        await expectLater(
          endpoints.messaging.createConversation(
            senderBuilder,
            const [1003, 1004],
            'Restricted group conversation',
          ),
          throwsA(isA<Exception>()),
        );
      } finally {
        await recipientSession.close();
      }
    });

    test('queue health is restricted to platform admins', () async {
      await expectLater(
        endpoints.operations.getQueueHealth(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.operations.getSchedulerHealth(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      final authenticated = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo('1001', {}),
      );
      final session = authenticated.build();
      try {
        if (await UserInfo.db.findById(session, 1001) == null) {
          await UserInfo.db.insertRow(
            session,
            UserInfo(
              id: 1001,
              userIdentifier: '1001',
              userName: 'operations-admin',
              email: 'operations@example.edu',
              created: DateTime.now(),
              scopeNames: const [],
              blocked: false,
            ),
          );
        }
        await UserProfile.db.insertRow(
          session,
          UserProfile(userId: 1001, role: 'admin'),
        );
        final health = await OperationsEndpoint().getQueueHealth(session);
        expect(
            health.keys,
            containsAll(<String>[
              'backgroundPending',
              'emailDeadLetter',
              'pushProcessing',
            ]));
        expect(health.values.every((value) => value >= 0), isTrue);
        final schedulerHealth =
            await OperationsEndpoint().getSchedulerHealth(session);
        expect(
          schedulerHealth.keys,
          containsAll(<String>[
            'verifiedSources',
            'sourcesDue',
            'sourcesFailed',
            'refreshJobsPending',
          ]),
        );
        expect(schedulerHealth.values.every((value) => value >= 0), isTrue);
      } finally {
        await session.close();
      }
    });

    test('room resource extraction handles bounded text and office archives',
        () {
      final officeArchive = Archive()
        ..addFile(ArchiveFile.string(
          'word/document.xml',
          '<w:document xmlns:w="urn:test"><w:p><w:t>Office source</w:t></w:p></w:document>',
        ));
      final officeBytes =
          Uint8List.fromList(ZipEncoder().encode(officeArchive));
      expect(
        RoomResourceTextExtractor.extract('docx', officeBytes),
        contains('Office source'),
      );
      expect(
        RoomResourceTextExtractor.extract(
          'txt',
          Uint8List.fromList('Plain source'.codeUnits),
        ),
        'Plain source',
      );
      expect(
        RoomResourceTextExtractor.extract(
          'pdf',
          Uint8List.fromList('(PDF source) Tj'.codeUnits),
        ),
        contains('PDF source'),
      );
      expect(
        RoomResourceTextExtractor.extract(
            'docx', Uint8List.fromList([1, 2, 3])),
        isNull,
      );
    });

    test('database-side room knowledge search ranks authorized chunks',
        () async {
      final session = sessionBuilder.build();
      try {
        const userId = 3001;
        if (await UserInfo.db.findById(session, userId) == null) {
          await UserInfo.db.insertRow(
            session,
            UserInfo(
              id: userId,
              userIdentifier: '$userId',
              userName: 'knowledge-search-fixture',
              email: 'knowledge-search@example.edu',
              created: DateTime.now(),
              scopeNames: const [],
              blocked: false,
            ),
          );
        }
        final room = await StudyRoom.db.insertRow(
          session,
          StudyRoom(
            ownerId: userId,
            title: 'Knowledge search fixture',
            description: 'Database ranking test room',
            visibility: 'public',
            membershipPolicy: 'open',
            status: 'active',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        final resource = await RoomResource.db.insertRow(
          session,
          RoomResource(
            roomId: room.id!,
            ownerId: userId,
            resourceType: 'study_material',
            title: 'Ranking fixture',
            content: 'Fixture content',
            status: 'active',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        final relevantVector = List<double>.filled(1536, 0);
        relevantVector[0] = 1;
        final lessRelevantVector = List<double>.filled(1536, 0);
        lessRelevantVector[1] = 1;
        final relevant = await RoomResourceChunk.db.insertRow(
          session,
          RoomResourceChunk(
            roomResourceId: resource.id!,
            chunkIndex: 0,
            content: 'Relevant chunk',
            tokenCount: 2,
            embedding: jsonEncode(relevantVector),
            createdAt: DateTime.now(),
          ),
        );
        final lessRelevant = await RoomResourceChunk.db.insertRow(
          session,
          RoomResourceChunk(
            roomResourceId: resource.id!,
            chunkIndex: 1,
            content: 'Less relevant chunk',
            tokenCount: 3,
            embedding: jsonEncode(lessRelevantVector),
            createdAt: DateTime.now(),
          ),
        );
        for (final entry in [
          (id: relevant.id!, vector: relevantVector),
          (id: lessRelevant.id!, vector: lessRelevantVector),
        ]) {
          await session.db.unsafeExecute(
            'INSERT INTO "room_resource_chunk_embeddings" '
            '("roomResourceChunkId", "embedding", "updatedAt") '
            'VALUES (@id, @embedding::vector, @updatedAt)',
            parameters: QueryParameters.named({
              'id': entry.id,
              'embedding': '[${entry.vector.join(',')}]',
              'updatedAt': DateTime.now().toUtc(),
            }),
          );
        }
        final results = await RoomKnowledgeSearchService.search(
          session,
          roomId: room.id!,
          queryEmbedding: relevantVector,
          limit: 1,
        );
        expect(results, hasLength(1));
        expect(results.single.id, relevant.id);
      } finally {
        await session.close();
      }
    });

    test('image resource OCR jobs fail closed after final retry', () async {
      final session = sessionBuilder.build();
      try {
        const userId = 3002;
        if (await UserInfo.db.findById(session, userId) == null) {
          await UserInfo.db.insertRow(
            session,
            UserInfo(
              id: userId,
              userIdentifier: '$userId',
              userName: 'ocr-fixture',
              email: 'ocr-fixture@example.edu',
              created: DateTime.now(),
              scopeNames: const [],
              blocked: false,
            ),
          );
        }
        final room = await StudyRoom.db.insertRow(
          session,
          StudyRoom(
            ownerId: userId,
            title: 'OCR fixture room',
            description: 'OCR failure test room',
            visibility: 'public',
            membershipPolicy: 'open',
            status: 'active',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        final resource = await RoomResource.db.insertRow(
          session,
          RoomResource(
            roomId: room.id!,
            ownerId: userId,
            resourceType: 'material',
            title: 'Image OCR fixture',
            uri: 'http://127.0.0.1:1/unavailable.png',
            status: 'processing',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        final job = await BackgroundJobService.enqueue(
          session,
          jobType: 'room_resource.ocr',
          payload: {'resourceId': resource.id},
          maxAttempts: 1,
        );
        await BackgroundWorkerService.runOnce(
          session,
          workerId: 'integration-ocr-worker',
          handlers: BackgroundJobHandlers.defaults(),
        );
        expect(
          (await BackgroundJob.db.findById(session, job.id!))?.status,
          'dead_letter',
        );
        expect(
          (await RoomResource.db.findById(session, resource.id!))?.status,
          'failed',
        );
      } finally {
        await session.close();
      }
    });

    test('rejects unauthenticated study-history creation', () async {
      await expectLater(
        endpoints.user.createStudyHistory(sessionBuilder),
        throwsA(isA<Exception>()),
      );
    });

    test('email delivery is durable, idempotent, and retryable', () async {
      final authenticated = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo('1001', {}),
      );
      final session = authenticated.build();
      final dedupeKey =
          'integration-email-${DateTime.now().microsecondsSinceEpoch}';
      final queued = await EmailDeliveryService.enqueue(
        session,
        recipient: 'student@example.edu',
        subject: 'Verification',
        htmlBody: '<p>Code</p>',
        dedupeKey: dedupeKey,
      );
      final duplicate = await EmailDeliveryService.enqueue(
        session,
        recipient: 'different@example.edu',
        subject: 'Ignored duplicate',
        htmlBody: '<p>Ignored</p>',
        dedupeKey: dedupeKey,
      );
      expect(duplicate.id, queued.id);

      final claimed = await EmailDeliveryService.claim(
        session,
        queued.id!,
        'integration-email-worker',
      );
      expect(claimed?.status, 'processing');
      expect(
        await EmailDeliveryService.recoverStale(
          session,
          staleAfter: Duration.zero,
        ),
        1,
      );
      final reclaimed = await EmailDeliveryService.claim(
        session,
        queued.id!,
        'integration-email-reclaimed-worker',
      );
      final sent = await EmailDeliveryService.deliver(
        session,
        reclaimed!,
        sender: (_, __) async {},
      );
      expect(sent.status, 'sent');
      expect(sent.sentAt, isNotNull);

      final retry = await EmailDeliveryService.enqueue(
        session,
        recipient: 'student@example.edu',
        subject: 'Retry',
        htmlBody: '<p>Retry</p>',
        maxAttempts: 1,
      );
      final retryClaim = await EmailDeliveryService.claim(
        session,
        retry.id!,
        'integration-email-failing-worker',
      );
      final deadLettered = await EmailDeliveryService.deliver(
        session,
        retryClaim!,
        sender: (_, __) async => throw Exception('smtp unavailable'),
      );
      expect(deadLettered.status, 'dead_letter');
      expect(deadLettered.lastError, contains('smtp unavailable'));
    });

    test('push delivery is durable, retryable, and recovers stale claims',
        () async {
      final authenticated = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo('1001', {}),
      );
      final session = authenticated.build();
      if (await UserInfo.db.findById(session, 1001) == null) {
        await UserInfo.db.insertRow(
          session,
          UserInfo(
            id: 1001,
            userIdentifier: '1001',
            userName: 'push-test-user',
            email: 'push-test@example.edu',
            created: DateTime.now(),
            scopeNames: const [],
            blocked: false,
          ),
        );
      }
      final queued = await PushDeliveryService.enqueue(
        session,
        userId: 1001,
        title: 'Room update',
        message: 'A new answer was posted.',
        type: 'room_post',
        relatedId: 42,
      );
      final claimed = await PushDeliveryService.claim(
        session,
        queued.id!,
        'integration-push-worker',
      );
      expect(claimed?.status, 'processing');
      expect(
        await PushDeliveryService.recoverStale(
          session,
          staleAfter: Duration.zero,
        ),
        1,
      );
      final reclaimed = await PushDeliveryService.claim(
        session,
        queued.id!,
        'integration-push-reclaimed-worker',
      );
      final sent = await PushDeliveryService.deliver(
        session,
        reclaimed!,
        sender: (_, __) async {},
      );
      expect(sent.status, 'sent');

      final failed = await PushDeliveryService.enqueue(
        session,
        userId: 1001,
        title: 'Failure',
        message: 'Provider failure',
        maxAttempts: 1,
      );
      final failedClaim = await PushDeliveryService.claim(
        session,
        failed.id!,
        'integration-push-failing-worker',
      );
      final deadLettered = await PushDeliveryService.deliver(
        session,
        failedClaim!,
        sender: (_, __) async => throw Exception('provider unavailable'),
      );
      expect(deadLettered.status, 'dead_letter');
      expect(deadLettered.lastError, contains('provider unavailable'));
    });

    test('authenticated institution searches accept the session identity',
        () async {
      final authenticated = sessionBuilder.copyWith(
        authentication: AuthenticationOverride.authenticationInfo(
          '1001',
          {},
        ),
      );
      final session = authenticated.build();
      try {
        expect(session.authenticated?.userIdentifier, '1001');
        final institutions = await CollaborationEndpoint().searchInstitutions(
          session,
          '',
          0,
          20,
        );
        expect(institutions, isA<List>());
        await expectLater(
          CollaborationEndpoint().getRoomResources(session, 999999, 0, 20),
          throwsA(isA<Exception>()),
        );
      } finally {
        await session.close();
      }
    });

    test('verified users can collaborate while private rooms remain scoped',
        () async {
      final adminSession = sessionBuilder
          .copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
              '1001',
              {},
            ),
          )
          .build();
      final memberSession = sessionBuilder
          .copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
              '1002',
              {},
            ),
          )
          .build();
      final inviteeSession = sessionBuilder
          .copyWith(
            authentication: AuthenticationOverride.authenticationInfo(
              '1003',
              {},
            ),
          )
          .build();
      try {
        final now = DateTime.now();
        final rateLimitAction =
            'integration-rate-${now.microsecondsSinceEpoch}';
        await CollaborationEndpoint().enforceRateLimit(
          adminSession,
          userId: 1001,
          action: rateLimitAction,
          maximum: 1,
          window: const Duration(hours: 1),
        );
        await expectLater(
          CollaborationEndpoint().enforceRateLimit(
            adminSession,
            userId: 1001,
            action: rateLimitAction,
            maximum: 1,
            window: const Duration(hours: 1),
          ),
          throwsA(isA<Exception>()),
        );
        await UserInfo.db.insert(
          adminSession,
          [
            UserInfo(
              id: 1001,
              userIdentifier: '1001',
              userName: 'admin',
              email: 'admin@global.test',
              created: now,
              scopeNames: const [],
              blocked: false,
            ),
            UserInfo(
              id: 1002,
              userIdentifier: '1002',
              userName: 'member',
              created: now,
              scopeNames: const [],
              blocked: false,
            ),
            UserInfo(
              id: 1003,
              userIdentifier: '1003',
              userName: 'invitee',
              created: now,
              scopeNames: const [],
              blocked: false,
            ),
          ],
        );
        final messagingEndpoint = MessagingEndpoint();
        final blocked = await messagingEndpoint.setSafetyRelationship(
          memberSession,
          1003,
          'block',
        );
        expect(blocked.active, isTrue);
        expect(
          (await messagingEndpoint.getMySafetyRelationships(
            memberSession,
            0,
            20,
          ))
              .map((item) => item.targetUserId),
          contains(1003),
        );
        await expectLater(
          messagingEndpoint.createConversation(
            memberSession,
            const [1003],
            'Blocked conversation',
          ),
          throwsA(isA<Exception>()),
        );
        await messagingEndpoint.removeSafetyRelationship(
          memberSession,
          1003,
          'block',
        );
        final conversation = await messagingEndpoint.createConversation(
          memberSession,
          const [1003],
          'Research discussion',
        );
        final sentMessage = await messagingEndpoint.sendMessage(
          memberSession,
          conversation.id!,
          'Hello from the research group.',
        );
        expect(sentMessage.authorId, 1002);
        final receipt = await messagingEndpoint.markConversationRead(
          memberSession,
          conversation.id!,
          sentMessage.id!,
        );
        expect(receipt.conversationId, conversation.id);
        expect(receipt.userId, 1002);
        expect(receipt.lastReadMessageId, sentMessage.id);
        final receipts = await messagingEndpoint.getConversationReadReceipts(
          memberSession,
          conversation.id!,
        );
        expect(receipts.map((item) => item.userId), contains(1002));
        await messagingEndpoint.setSafetyRelationship(
          memberSession,
          1003,
          'block',
        );
        await expectLater(
          messagingEndpoint.sendMessage(
            memberSession,
            conversation.id!,
            'This should be blocked.',
          ),
          throwsA(isA<Exception>()),
        );
        await messagingEndpoint.removeSafetyRelationship(
          memberSession,
          1003,
          'block',
        );
        final restricted = await messagingEndpoint.setSafetyRelationship(
          memberSession,
          1003,
          'restrict',
        );
        expect(restricted.relationshipType, 'restrict');
        await expectLater(
          messagingEndpoint.sendMessage(
            memberSession,
            conversation.id!,
            'This should be restricted.',
          ),
          throwsA(isA<Exception>()),
        );
        await messagingEndpoint.removeSafetyRelationship(
          memberSession,
          1003,
          'restrict',
        );
        final institution = await Institution.db.insertRow(
          adminSession,
          Institution(
            name: 'Global Test University',
            country: 'NG',
            region: 'West Africa',
            domains: const ['global.test'],
            verificationStatus: 'verified',
            createdAt: now,
          ),
        );
        final unverifiedInstitution = await Institution.db.insertRow(
          adminSession,
          Institution(
            name: 'Unverified Test Institution',
            country: 'NG',
            region: 'West Africa',
            domains: const ['unverified.test'],
            verificationStatus: 'pending',
            createdAt: now,
          ),
        );
        await InstitutionMembership.db.insert(
          adminSession,
          [
            InstitutionMembership(
              userId: 1001,
              institutionId: institution.id!,
              role: 'institution_admin',
              verificationMethod: 'manual',
              status: 'verified',
              createdAt: now,
              verifiedAt: now,
            ),
            InstitutionMembership(
              userId: 1002,
              institutionId: institution.id!,
              role: 'student',
              verificationMethod: 'manual',
              status: 'verified',
              createdAt: now,
              verifiedAt: now,
            ),
          ],
        );

        final endpoint = CollaborationEndpoint();
        if (await UserProfile.db.findFirstRow(
              adminSession,
              where: (t) => t.userId.equals(1001),
            ) ==
            null) {
          await UserProfile.db.insertRow(
            adminSession,
            UserProfile(userId: 1001, role: 'admin'),
          );
        }
        final submittedInstitution = await endpoint.submitInstitution(
          memberSession,
          'Submitted Global University',
          'ng',
          'West Africa',
          const ['submitted.example.edu'],
          'https://example.com/logo.png',
        );
        expect(submittedInstitution.verificationStatus, 'pending');
        final duplicateInstitution = await endpoint.submitInstitution(
          memberSession,
          'Submitted Global University',
          'NG',
          'West Africa',
          const ['submitted.example.edu'],
          null,
        );
        expect(duplicateInstitution.id, submittedInstitution.id);
        await expectLater(
          endpoint.getPendingInstitutionReviews(memberSession, 0, 20),
          throwsA(isA<Exception>()),
        );
        final pendingInstitutions = await endpoint.getPendingInstitutionReviews(
          adminSession,
          0,
          20,
        );
        expect(
          pendingInstitutions.map((item) => item.id),
          contains(submittedInstitution.id),
        );
        await expectLater(
          endpoint.reviewInstitution(
            memberSession,
            submittedInstitution.id!,
            'verified',
          ),
          throwsA(isA<Exception>()),
        );
        final reviewedInstitution = await endpoint.reviewInstitution(
          adminSession,
          submittedInstitution.id!,
          'verified',
        );
        expect(reviewedInstitution.verificationStatus, 'verified');
        final provisionedAdmin = await InstitutionMembership.db.findFirstRow(
          adminSession,
          where: (t) =>
              t.userId.equals(1002) &
              t.institutionId.equals(submittedInstitution.id!),
        );
        expect(provisionedAdmin?.role, 'institution_admin');
        expect(provisionedAdmin?.status, 'verified');
        final institutionReviewAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) =>
              t.targetType.equals('institution') &
              t.targetId.equals(submittedInstitution.id!),
          limit: 20,
        );
        expect(
          institutionReviewAudit.map((event) => event.action),
          containsAll(
              <String>['institution_submitted', 'institution_reviewed']),
        );
        final visibleInstitutions = await endpoint.searchInstitutions(
          adminSession,
          'Global Test',
          0,
          20,
        );
        expect(visibleInstitutions.map((item) => item.id),
            contains(institution.id));
        expect(visibleInstitutions.map((item) => item.id),
            isNot(contains(unverifiedInstitution.id)));
        final emailInstitution = await Institution.db.insertRow(
          adminSession,
          Institution(
            name: 'Email Verified University',
            country: 'NG',
            region: 'West Africa',
            domains: const ['global.test'],
            verificationStatus: 'verified',
            createdAt: now,
          ),
        );
        await InstitutionMembership.db.insertRow(
          adminSession,
          InstitutionMembership(
            userId: 1001,
            institutionId: emailInstitution.id!,
            role: 'institution_admin',
            verificationMethod: 'manual',
            status: 'verified',
            createdAt: now,
            verifiedAt: now,
          ),
        );
        final emailMembership = await endpoint.requestMembership(
          adminSession,
          emailInstitution.id!,
          'institution_email',
        );
        expect(emailMembership.status, 'verified');
        final manualMembership = await endpoint.requestMembership(
          memberSession,
          emailInstitution.id!,
          'manual',
        );
        expect(manualMembership.status, 'pending');
        final evidence = await endpoint.submitVerificationEvidence(
          memberSession,
          manualMembership.id!,
          'https://example.com/student-card',
        );
        expect(evidence.evidenceUrl, 'https://example.com/student-card');
        final pendingRequests =
            await endpoint.getInstitutionVerificationRequests(
          adminSession,
          emailInstitution.id!,
          0,
          20,
        );
        expect(
          pendingRequests
              .firstWhere(
                  (request) => request.membershipId == manualMembership.id)
              .evidenceUrl,
          'https://example.com/student-card',
        );
        final verificationRequests = await endpoint.getMyVerificationRequests(
          memberSession,
        );
        expect(
          verificationRequests.map((request) => request.membershipId),
          contains(manualMembership.id),
        );
        final reviewedMembership = await endpoint.reviewMembership(
          adminSession,
          manualMembership.id!,
          'approve',
        );
        expect(reviewedMembership.status, 'verified');
        final reviewedRequests = await endpoint.getMyVerificationRequests(
          memberSession,
        );
        expect(
          reviewedRequests
              .firstWhere(
                  (request) => request.membershipId == manualMembership.id)
              .status,
          'approved',
        );
        final membershipAuditEvents = await AuditEvent.db.find(
          adminSession,
          where: (t) =>
              t.targetType.equals('institution_membership') &
              t.targetId.equals(manualMembership.id!),
        );
        expect(
          membershipAuditEvents.any(
            (event) => event.action == 'institution_membership_reviewed',
          ),
          isTrue,
        );
        final identityAuditEvents = await AuditEvent.db.find(
          adminSession,
          where: (t) => t.institutionId.equals(emailInstitution.id!),
          limit: 100,
        );
        expect(
          identityAuditEvents.any(
            (event) => event.action == 'institution_membership_requested',
          ),
          isTrue,
        );
        expect(
          identityAuditEvents.any(
            (event) =>
                event.action == 'institution_verification_evidence_submitted',
          ),
          isTrue,
        );
        final institutionAuditEvents = await endpoint.getInstitutionAuditEvents(
            adminSession, institution.id!);
        expect(institutionAuditEvents, isA<List<AuditEvent>>());
        await expectLater(
          endpoint.getInstitutionAuditEvents(memberSession, institution.id!),
          throwsA(isA<Exception>()),
        );
        final queuedJob = await BackgroundJobService.enqueue(
          adminSession,
          jobType: 'integration.test',
          payload: {'materialId': 123},
          maxAttempts: 2,
        );
        final claimedJob = await BackgroundJobService.claim(
          adminSession,
          queuedJob.id!,
          'integration-worker-1',
        );
        expect(claimedJob?.status, 'processing');
        expect(
          await BackgroundJobService.recoverStaleJobs(
            adminSession,
            staleAfter: Duration.zero,
          ),
          1,
        );
        final reclaimedJob = await BackgroundJobService.claim(
          adminSession,
          queuedJob.id!,
          'integration-worker-reclaimed',
        );
        expect(reclaimedJob?.status, 'processing');
        final deadLetteredJob = await BackgroundJobService.fail(
          adminSession,
          reclaimedJob!,
          Exception('intentional integration failure'),
        );
        expect(deadLetteredJob.status, 'dead_letter');
        expect(deadLetteredJob.lastError, contains('intentional'));
        expect(
          await BackgroundJobService.claim(
            adminSession,
            queuedJob.id!,
            'integration-worker-2',
          ),
          isNull,
        );
        final workerJob = await BackgroundJobService.enqueue(
          adminSession,
          jobType: 'integration.worker',
          payload: {'value': 7},
        );
        expect(
          await BackgroundWorkerService.runOnce(
            adminSession,
            workerId: 'integration-worker-runner',
            handlers: {
              'integration.worker': (_, __, payload) async {
                expect(payload['value'], 7);
              },
            },
          ),
          1,
        );
        expect(
          (await BackgroundJob.db.findById(adminSession, workerJob.id!))
              ?.status,
          'completed',
        );
        final unknownJob = await BackgroundJobService.enqueue(
          adminSession,
          jobType: 'integration.unknown',
          payload: const {},
          maxAttempts: 1,
        );
        await BackgroundWorkerService.runOnce(
          adminSession,
          workerId: 'integration-worker-unknown',
          handlers: const {},
        );
        expect(
          (await BackgroundJob.db.findById(adminSession, unknownJob.id!))
              ?.status,
          'dead_letter',
        );
        final invalidRefreshJob = await BackgroundJobService.enqueue(
          adminSession,
          jobType: 'opportunity_source.refresh',
          payload: const {'sourceId': 'not-an-id'},
          maxAttempts: 1,
        );
        await BackgroundWorkerService.runOnce(
          adminSession,
          workerId: 'integration-opportunity-worker',
          handlers: BackgroundJobHandlers.defaults(),
        );
        expect(
          (await BackgroundJob.db.findById(adminSession, invalidRefreshJob.id!))
              ?.status,
          'dead_letter',
        );
        final profile = await endpoint.upsertAcademicProfile(
          adminSession,
          institution.id!,
          'Engineering',
          'BSc Computer Science',
          '3',
          const ['Algorithms'],
          const ['Research'],
          const ['English'],
          'Evenings',
        );
        expect(profile.department, 'Engineering');
        expect(profile.subjects, contains('Algorithms'));
        final loadedProfile = await endpoint.getAcademicProfile(
          adminSession,
          institution.id!,
        );
        expect(loadedProfile?.programme, 'BSc Computer Science');
        final opportunity = await Opportunity.db.insertRow(
          adminSession,
          Opportunity(
            title: 'Global Research Scholarship',
            opportunityType: 'scholarship',
            provider: 'Test Foundation',
            country: 'NG',
            eligibilityRegion: 'West Africa',
            field: 'Computer science',
            educationLevel: 'Undergraduate',
            deadline: DateTime.now().add(const Duration(days: 30)),
            fundingDetails: 'Full tuition',
            officialUrl: 'https://example.com/scholarship',
            verificationStatus: 'verified',
            submittedById: 1001,
            createdAt: now,
            updatedAt: now,
          ),
        );
        final opportunityEndpoint = OpportunityEndpoint();
        await expectLater(
          opportunityEndpoint.submitOpportunity(
            memberSession,
            'Unsafe source',
            'scholarship',
            'Unknown provider',
            'NG',
            null,
            'Computer science',
            'undergraduate',
            DateTime.now().add(const Duration(days: 30)),
            'Funding details',
            'javascript:alert(1)',
          ),
          throwsA(isA<Exception>()),
        );
        final pendingOpportunity = await opportunityEndpoint.submitOpportunity(
          memberSession,
          'Pending pilot scholarship',
          'scholarship',
          'Pilot Foundation',
          'NG',
          'West Africa',
          'Computer science',
          'undergraduate',
          DateTime.now().add(const Duration(days: 45)),
          'Tuition support',
          'https://pilot.example.org/scholarship',
        );
        if (await UserProfile.db.findFirstRow(
              adminSession,
              where: (t) => t.userId.equals(1001),
            ) ==
            null) {
          await UserProfile.db.insertRow(
            adminSession,
            UserProfile(userId: 1001, role: 'admin'),
          );
        }
        final pendingReviews =
            await opportunityEndpoint.getPendingOpportunityReviews(
          adminSession,
          page: 0,
          limit: 20,
        );
        expect(
          pendingReviews.map((item) => item.id),
          contains(pendingOpportunity.id),
        );
        final tracker = await opportunityEndpoint.upsertApplicationTracker(
          memberSession,
          opportunity.id!,
          'interested',
          'Review eligibility requirements.',
          'https://example.com/application',
        );
        expect(tracker.status, 'interested');
        final updatedTracker =
            await opportunityEndpoint.upsertApplicationTracker(
          memberSession,
          opportunity.id!,
          'applied',
          'Submitted application.',
          'https://example.com/application',
        );
        expect(updatedTracker.id, tracker.id);
        expect(updatedTracker.status, 'applied');
        final trackers = await opportunityEndpoint.getApplicationTrackers(
          memberSession,
          0,
          20,
        );
        expect(trackers.map((item) => item.id), contains(tracker.id));
        await expectLater(
          opportunityEndpoint.upsertApplicationTracker(
            memberSession,
            opportunity.id!,
            'unknown',
            null,
            null,
          ),
          throwsA(isA<Exception>()),
        );
        await expectLater(
          opportunityEndpoint.upsertApplicationTracker(
            memberSession,
            opportunity.id!,
            'applied',
            null,
            'javascript:alert(1)',
          ),
          throwsA(isA<Exception>()),
        );
        await expectLater(
          endpoint.submitVerificationEvidence(
            adminSession,
            manualMembership.id!,
            'https://example.com/other-student-card',
          ),
          throwsA(isA<Exception>()),
        );
        final inviteToken = await endpoint.createInstitutionInvite(
          adminSession,
          institution.id!,
          7,
          1,
        );
        final inviteCreationAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) =>
              t.action.equals('institution_invite_created') &
              t.institutionId.equals(institution.id!),
          limit: 20,
        );
        expect(inviteCreationAudit, isNotEmpty);
        final inviteeMembership = await endpoint.acceptInstitutionInvite(
          inviteeSession,
          inviteToken,
        );
        expect(inviteeMembership.userId, 1003);
        expect(inviteeMembership.status, 'verified');
        final inviteAuditEvents = await AuditEvent.db.find(
          adminSession,
          where: (t) =>
              t.targetType.equals('institution_membership') &
              t.targetId.equals(inviteeMembership.id!),
          limit: 20,
        );
        expect(
          inviteAuditEvents.any(
            (event) => event.action == 'institution_invite_accepted',
          ),
          isTrue,
        );
        await expectLater(
          endpoint.acceptInstitutionInvite(memberSession, inviteToken),
          throwsA(isA<Exception>()),
        );
        final members = await endpoint.getInstitutionMembers(
          adminSession,
          institution.id!,
          0,
          20,
        );
        expect(members.map((item) => item.userId), contains(1003));
        final room = await endpoint.createRoom(
          adminSession,
          institution.id,
          'Global Research Room',
          'A private pilot room.',
          'Computer science',
          'private',
        );
        final discussionRoom = await endpoint.createRoom(
          adminSession,
          institution.id,
          'Open Research Discussion',
          'An open discussion room for peer answers.',
          'Computer science',
          'public',
        );
        final adminRoomMembership = await endpoint.getMyRoomMembership(
          adminSession,
          room.id!,
        );
        expect(adminRoomMembership?.role, 'owner');
        expect(
          await endpoint.getMyRoomMembership(inviteeSession, room.id!),
          isNull,
        );
        final roomPageOne = await endpoint.getRooms(adminSession, 0, 1);
        final roomPageTwo = await endpoint.getRooms(adminSession, 1, 1);
        expect(roomPageOne, hasLength(1));
        expect(roomPageTwo, hasLength(1));
        expect(roomPageOne.single.id, isNot(roomPageTwo.single.id));
        final chatMessage = await endpoint.createRoomChatMessage(
          adminSession,
          room.id!,
          'Persistent room chat message.',
        );
        final chatAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) => t.targetId.equals(chatMessage.id!),
          limit: 20,
        );
        expect(
          chatAudit.any((event) => event.action == 'room_chat_message_created'),
          isTrue,
        );
        final document = await endpoint.createDocument(
          adminSession,
          room.id!,
          'Shared notes',
          'Initial notes.',
        );
        final updatedDocument = await endpoint.updateDocument(
          adminSession,
          document.id!,
          'Shared notes',
          'Updated notes.',
          document.version,
        );
        expect(updatedDocument.version, 2);
        final documentAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) => t.targetId.equals(document.id!),
          limit: 20,
        );
        expect(
          documentAudit.any(
            (event) => event.action == 'collaborative_document_created',
          ),
          isTrue,
        );
        expect(
          documentAudit.any(
            (event) => event.action == 'collaborative_document_updated',
          ),
          isTrue,
        );
        final post = await endpoint.createPost(
          adminSession,
          discussionRoom.id!,
          'Welcome to the pilot research discussion.',
        );
        await endpoint.joinRoom(memberSession, discussionRoom.id!);
        final answer = await endpoint.createComment(
          memberSession,
          post.id!,
          'Here is a reproducible approach.',
          null,
        );
        final postAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) => t.targetId.equals(post.id!),
          limit: 20,
        );
        expect(
          postAudit.any((event) => event.action == 'discussion_post_created'),
          isTrue,
        );
        final commentAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) => t.targetId.equals(answer.id!),
          limit: 20,
        );
        expect(
          commentAudit
              .any((event) => event.action == 'discussion_comment_created'),
          isTrue,
        );
        await expectLater(
          endpoint.acceptPostComment(memberSession, post.id!, answer.id),
          throwsA(isA<Exception>()),
        );
        final acceptedPost = await endpoint.acceptPostComment(
          adminSession,
          post.id!,
          answer.id,
        );
        expect(acceptedPost.acceptedCommentId, answer.id);
        final awardedReputation = await endpoint.getMyReputation(memberSession);
        expect(awardedReputation.score, 10);
        expect(awardedReputation.acceptedSolutions, 1);
        final unacceptedPost = await endpoint.acceptPostComment(
          adminSession,
          post.id!,
          null,
        );
        expect(unacceptedPost.acceptedCommentId, isNull);
        final revokedReputation = await endpoint.getMyReputation(memberSession);
        expect(revokedReputation.score, 0);
        expect(revokedReputation.acceptedSolutions, 0);
        final reaction = await endpoint.setPostReaction(
          memberSession,
          post.id!,
          'useful',
        );
        expect(reaction?.reaction, 'useful');
        final changedReaction = await endpoint.setPostReaction(
          memberSession,
          post.id!,
          'insightful',
        );
        expect(changedReaction?.id, reaction?.id);
        expect(changedReaction?.reaction, 'insightful');
        expect(
          await endpoint.setPostReaction(memberSession, post.id!, null),
          isNull,
        );
        final reactionAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) =>
              t.targetType.equals('discussion_post') &
              t.targetId.equals(post.id!),
          limit: 50,
        );
        expect(
          reactionAudit.any(
            (event) => event.action == 'discussion_reaction_created',
          ),
          isTrue,
        );
        expect(
          reactionAudit.any(
            (event) => event.action == 'discussion_reaction_updated',
          ),
          isTrue,
        );
        expect(
          reactionAudit.any(
            (event) => event.action == 'discussion_reaction_removed',
          ),
          isTrue,
        );
        await expectLater(
          endpoint.setPostReaction(inviteeSession, post.id!, 'useful'),
          throwsA(isA<Exception>()),
        );
        await expectLater(
          endpoint.getPostComments(inviteeSession, post.id!, 0, 20),
          throwsA(isA<Exception>()),
        );
        final resource = await endpoint.addRoomResource(
          adminSession,
          room.id!,
          'link',
          'Reproducibility reference paper',
          'https://example.com/reproducibility',
          null,
          'Official reference source',
        );
        final textResource = await endpoint.addRoomResource(
          adminSession,
          room.id!,
          'material',
          'Grounded notes',
          null,
          'A persistent source paragraph for the shared room knowledge base.',
          'Pilot notes, 2026',
        );
        final posts = await endpoint.getRoomPosts(
          adminSession,
          discussionRoom.id!,
          0,
          20,
        );
        final resources = await endpoint.getRoomResources(
          adminSession,
          room.id!,
          0,
          20,
        );
        final clampedResources = await endpoint.getRoomResources(
          adminSession,
          room.id!,
          -1,
          1000,
        );
        final resourcePageOne = await endpoint.getRoomResources(
          adminSession,
          room.id!,
          0,
          1,
        );
        final resourcePageTwo = await endpoint.getRoomResources(
          adminSession,
          room.id!,
          1,
          1,
        );
        expect(posts.map((item) => item.id), contains(post.id));
        expect(resources.map((item) => item.id), contains(resource.id));
        expect(clampedResources.length, lessThanOrEqualTo(50));
        expect(resourcePageOne, hasLength(1));
        expect(resourcePageTwo, hasLength(1));
        expect(resourcePageOne.single.id, isNot(resourcePageTwo.single.id));
        final fakeStorage = _FakeRoomStorage();
        final uploadedResource = await CollaborationEndpoint(
          storage: fakeStorage,
        ).uploadRoomResource(
          adminSession,
          room.id!,
          'material',
          'Uploaded plain-text source',
          'txt',
          ByteData.sublistView(
            Uint8List.fromList('Uploaded source body.'.codeUnits),
          ),
          'Uploader citation',
        );
        expect(uploadedResource.status, 'active');
        expect(uploadedResource.content, 'Uploaded source body.');
        expect(uploadedResource.uri, startsWith('https://storage.test/'));
        expect(fakeStorage.uploadedKeys, hasLength(1));
        final uploadedChunks = await endpoint.getRoomResourceChunks(
          adminSession,
          room.id!,
          uploadedResource.id!,
          0,
          20,
        );
        expect(uploadedChunks, hasLength(1));
        expect(uploadedChunks.single.content, 'Uploaded source body.');
        final aiEndpoint = CollaborationEndpoint(
          openAiApiKey: 'test-room-ai-key',
          httpClient: MockClient((request) async {
            expect(request.url.path, '/v1/chat/completions');
            return http.Response(
              jsonEncode({
                'choices': [
                  {
                    'message': {
                      'content':
                          'The room source describes reproducibility. [R${textResource.id}]',
                    },
                  },
                ],
              }),
              200,
            );
          }),
        );
        final aiAnswer = await aiEndpoint.askRoom(
          adminSession,
          room.id!,
          'What does the room source describe?',
        );
        expect(aiAnswer.sourceResourceIds, contains(textResource.id));
        expect(aiAnswer.citations, contains('[R${textResource.id}]'));
        final persistedAiAnswer = await RoomAiAnswer.db.findById(
          adminSession,
          aiAnswer.id!,
        );
        expect(persistedAiAnswer?.confidence, 'grounded');
        await expectLater(
          CollaborationEndpoint(
            openAiApiKey: 'test-room-ai-key',
            httpClient: MockClient((_) async => http.Response(
                  jsonEncode({
                    'choices': [
                      {
                        'message': {
                          'content': 'Unsupported claim [R999999999]'
                        },
                      },
                    ],
                  }),
                  200,
                )),
          ).askRoom(
            adminSession,
            room.id!,
            'Return only sourced information.',
          ),
          throwsA(isA<Exception>()),
        );
        await expectLater(
          endpoint.askRoom(
            inviteeSession,
            room.id!,
            'What does the private room source say?',
          ),
          throwsA(isA<Exception>()),
        );
        final chunks = await endpoint.getRoomResourceChunks(
          adminSession,
          room.id!,
          textResource.id!,
          0,
          20,
        );
        expect(chunks.single.content, contains('persistent source paragraph'));
        final embeddingJobs = await BackgroundJob.db.find(
          adminSession,
          where: (t) => t.jobType.equals('room_resource.index_embeddings'),
        );
        expect(
          embeddingJobs
              .any((job) => job.payload.contains('${textResource.id}')),
          isTrue,
        );
        final embeddingWorkerJob = await BackgroundJobService.enqueue(
          adminSession,
          jobType: 'room_resource.index_embeddings',
          payload: {'resourceId': textResource.id},
          maxAttempts: 1,
        );
        await BackgroundWorkerService.runOnce(
          adminSession,
          workerId: 'integration-embedding-worker',
          handlers: BackgroundJobHandlers.defaults(),
        );
        expect(
          (await BackgroundJob.db.findById(
            adminSession,
            embeddingWorkerJob.id!,
          ))
              ?.status,
          'dead_letter',
        );
        if (await UserProfile.db.findFirstRow(
              adminSession,
              where: (t) => t.userId.equals(1001),
            ) ==
            null) {
          await UserProfile.db.insertRow(
            adminSession,
            UserProfile(userId: 1001, role: 'admin'),
          );
        }
        final source = await opportunityEndpoint.registerOpportunitySource(
          adminSession,
          'Global Scholarships Feed',
          'Official Provider Network',
          'https://provider.example.org/opportunities.json',
        );
        final dueSources =
            await OpportunitySourceRefreshService.claimDueSources(
          adminSession,
          now: DateTime.now().toUtc(),
        );
        expect(dueSources.map((item) => item.id), contains(source.id));
        final scheduledSource = dueSources.firstWhere(
          (item) => item.id == source.id,
        );
        final secondClaim =
            await OpportunitySourceRefreshService.claimDueSources(
          adminSession,
          now: DateTime.now().toUtc(),
        );
        expect(secondClaim.map((item) => item.id), isNot(contains(source.id)));
        final refreshedSource =
            await OpportunitySourceRefreshService.markSuccess(
          adminSession,
          scheduledSource,
          syncedAt: DateTime.now().toUtc(),
        );
        expect(refreshedSource.lastSyncStatus, 'succeeded');
        expect(refreshedSource.nextSyncAt, isNotNull);
        final staleSource = await OpportunitySourceRefreshService.markFailure(
          adminSession,
          refreshedSource,
          Exception('feed timeout'),
        );
        expect(staleSource.lastSyncStatus, 'failed');
        expect(staleSource.staleAt, isNotNull);
        final workerSource = await OpportunitySource.db.insertRow(
          adminSession,
          OpportunitySource(
            name: 'Worker failure feed',
            provider: 'Official Provider Network',
            feedUrl: 'http://127.0.0.1:1/unavailable.json',
            verificationStatus: 'verified',
            createdById: 1001,
            createdAt: DateTime.now().toUtc(),
            updatedAt: DateTime.now().toUtc(),
          ),
        );
        await expectLater(
          OpportunitySourceRefreshService.refreshSource(
            adminSession,
            workerSource.id!,
          ),
          throwsA(isA<Object>()),
        );
        final failedWorkerSource = await OpportunitySource.db.findById(
          adminSession,
          workerSource.id!,
        );
        expect(failedWorkerSource?.lastSyncStatus, 'failed');
        expect(failedWorkerSource?.staleAt, isNotNull);
        final ingested = await opportunityEndpoint.ingestOpportunity(
          adminSession,
          source.id!,
          'provider-opportunity-1',
          'Ingested research scholarship',
          'scholarship',
          'Official Provider Network',
          'NG',
          'West Africa',
          'Computer science',
          'undergraduate',
          DateTime.now().add(const Duration(days: 90)),
          'Tuition support',
          'https://provider.example.org/opportunities/1',
        );
        final reingested = await opportunityEndpoint.ingestOpportunity(
          adminSession,
          source.id!,
          'provider-opportunity-1',
          'Updated research scholarship',
          'scholarship',
          'Official Provider Network',
          'NG',
          'West Africa',
          'Computer science',
          'undergraduate',
          DateTime.now().add(const Duration(days: 120)),
          'Tuition and research support',
          'https://provider.example.org/opportunities/1',
        );
        expect(reingested.id, ingested.id);
        expect(reingested.title, 'Updated research scholarship');
        expect(
          await OpportunitySourceRefreshService.markMissingRecordsStale(
            adminSession,
            source.id!,
            const {},
          ),
          1,
        );
        final staleOpportunity =
            await Opportunity.db.findById(adminSession, reingested.id!);
        expect(staleOpportunity?.verificationStatus, 'stale');
        expect(staleOpportunity?.staleAt, isNotNull);
        await opportunityEndpoint.ingestOpportunity(
          adminSession,
          source.id!,
          'provider-opportunity-1',
          'Restored research scholarship',
          'scholarship',
          'Official Provider Network',
          'NG',
          'West Africa',
          'Computer science',
          'undergraduate',
          DateTime.now().add(const Duration(days: 120)),
          'Tuition and research support',
          'https://provider.example.org/opportunities/1',
        );
        final restoredOpportunity =
            await Opportunity.db.findById(adminSession, reingested.id!);
        expect(restoredOpportunity?.verificationStatus, 'verified');
        expect(restoredOpportunity?.staleAt, isNull);
        final paginationDeadline = DateTime.now().toUtc().add(
              const Duration(days: 90),
            );
        await opportunityEndpoint.ingestOpportunity(
          adminSession,
          source.id!,
          'pagination-opportunity-1',
          'Pagination scholarship one',
          'scholarship',
          'Official Provider Network',
          'ZZ',
          'Global',
          'Pagination Research',
          'postgraduate',
          paginationDeadline,
          'Research funding one',
          'https://provider.example.org/pagination/1',
        );
        await opportunityEndpoint.ingestOpportunity(
          adminSession,
          source.id!,
          'pagination-opportunity-2',
          'Pagination scholarship two',
          'scholarship',
          'Official Provider Network',
          'ZZ',
          'Global',
          'Pagination Research',
          'postgraduate',
          paginationDeadline.add(const Duration(days: 1)),
          'Research funding two',
          'https://provider.example.org/pagination/2',
        );
        final opportunityPageOne = await opportunityEndpoint.getOpportunities(
          adminSession,
          0,
          1,
          'ZZ',
          'Pagination Research',
          'postgraduate',
          'scholarship',
          paginationDeadline.add(const Duration(days: 30)),
        );
        final opportunityPageTwo = await opportunityEndpoint.getOpportunities(
          adminSession,
          1,
          1,
          'ZZ',
          'Pagination Research',
          'postgraduate',
          'scholarship',
          paginationDeadline.add(const Duration(days: 30)),
        );
        expect(opportunityPageOne, hasLength(1));
        expect(opportunityPageTwo, hasLength(1));
        expect(
          opportunityPageOne.single.id,
          isNot(opportunityPageTwo.single.id),
        );
        final clampedOpportunities = await opportunityEndpoint.getOpportunities(
          adminSession,
          -1,
          1000,
          null,
          null,
          null,
          null,
          null,
        );
        expect(clampedOpportunities.length, lessThanOrEqualTo(50));
        final filteredOpportunities =
            await opportunityEndpoint.getOpportunities(
          adminSession,
          0,
          50,
          'NG',
          'Computer science',
          'undergraduate',
          'scholarship',
          DateTime.now().add(const Duration(days: 200)),
        );
        expect(
          filteredOpportunities.map((item) => item.id),
          contains(restoredOpportunity?.id),
        );
        await expectLater(
          opportunityEndpoint.registerOpportunitySource(
            memberSession,
            'Unauthorized Feed',
            'Unknown Provider',
            'https://unknown.example.org/feed',
          ),
          throwsA(isA<Exception>()),
        );
        final subscriptionEndpoint = SubscriptionEndpoint();
        await expectLater(
          subscriptionEndpoint.createSubscription(
            adminSession,
            'stripe',
            'pm_test',
            'short-key',
          ),
          throwsA(isA<Exception>()),
        );
        await expectLater(
          subscriptionEndpoint.createSubscription(
            adminSession,
            'unsupported',
            'payment-token',
            'valid-idempotency-key-1001',
          ),
          throwsA(isA<Exception>()),
        );
        final reviewedOpportunity = await opportunityEndpoint.reviewOpportunity(
          adminSession,
          opportunity.id!,
          'verified',
        );
        expect(reviewedOpportunity.verificationStatus, 'verified');
        final report = await endpoint.reportContent(
          adminSession,
          'post',
          post.id!,
          'spam',
          'Test moderation report',
        );
        final reportAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) => t.targetId.equals(post.id!),
          limit: 50,
        );
        expect(
          reportAudit.any((event) => event.action == 'content_report_created'),
          isTrue,
        );
        final openReports = await endpoint.getOpenReports(
          adminSession,
          page: 0,
          limit: 20,
        );
        expect(openReports.map((item) => item.id), contains(report.id));
        final resolvedReport = await endpoint.resolveReport(
          adminSession,
          report.id!,
          'remove',
          'Removed during moderation test.',
        );
        expect(resolvedReport.status, 'resolved');
        final removedPost = await DiscussionPost.db.findById(
          adminSession,
          post.id!,
        );
        expect(removedPost?.status, 'removed');
        final appeal = await endpoint.submitModerationAppeal(
          adminSession,
          report.id!,
          'The post was removed in error and should be restored.',
        );
        expect(appeal.status, 'pending');
        final pendingAppeals = await endpoint.getPendingModerationAppeals(
          adminSession,
          page: 0,
          limit: 20,
        );
        expect(pendingAppeals.map((item) => item.id), contains(appeal.id));
        final appealAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) => t.targetId.equals(appeal.id!),
          limit: 20,
        );
        expect(
          appealAudit
              .any((event) => event.action == 'moderation_appeal_submitted'),
          isTrue,
        );
        final duplicateAppeal = await endpoint.submitModerationAppeal(
          adminSession,
          report.id!,
          'A second submission should reuse the existing appeal.',
        );
        expect(duplicateAppeal.id, appeal.id);
        final reviewedAppeal = await endpoint.reviewModerationAppeal(
          adminSession,
          appeal.id!,
          'approved',
          'Restored after review.',
        );
        expect(reviewedAppeal.status, 'approved');
        final moderationNotifications = await Notification.db.find(
          adminSession,
          where: (t) =>
              t.userId.equals(1001) & t.type.equals('moderation_appeal'),
        );
        expect(
          moderationNotifications.any(
            (notification) => notification.relatedId == appeal.id,
          ),
          isTrue,
        );
        final restoredPost = await DiscussionPost.db.findById(
          adminSession,
          post.id!,
        );
        expect(restoredPost?.status, 'visible');
        expect(
          (await endpoint.getMyModerationAppeals(adminSession, 0, 20))
              .map((item) => item.id),
          contains(appeal.id),
        );
        final moderationAuditEvents = await AuditEvent.db.find(
          adminSession,
          where: (t) =>
              t.targetType.equals('post') & t.targetId.equals(post.id!),
        );
        expect(
          moderationAuditEvents.any(
            (event) => event.action == 'content_report_resolved',
          ),
          isTrue,
        );
        final auditEvents = await endpoint.getAuditEvents(
          adminSession,
          targetType: 'post',
          targetId: post.id!,
          page: 0,
          limit: 20,
        );
        expect(auditEvents.map((event) => event.targetId), contains(post.id));
        final challenge = await endpoint.createChallenge(
          adminSession,
          room.id,
          'Reproducible open problem',
          'Find a reproducible solution.',
          'Computer science',
          const ['research'],
          'intermediate',
        );
        final team = await endpoint.createChallengeTeam(
          adminSession,
          challenge.id!,
          'Pilot research team',
          'Initial team for the pilot.',
        );
        expect(team.ownerId, 1001);
        expect(team.description, 'Initial team for the pilot.');
        final updatedInstitutionAuditEvents =
            await endpoint.getInstitutionAuditEvents(
          adminSession,
          institution.id!,
        );
        expect(
          updatedInstitutionAuditEvents.any(
            (event) => event.action == 'study_room_created',
          ),
          isTrue,
        );
        expect(
          updatedInstitutionAuditEvents.any(
            (event) => event.action == 'challenge_created',
          ),
          isTrue,
        );
        expect(
          updatedInstitutionAuditEvents.any(
            (event) => event.action == 'challenge_team_created',
          ),
          isTrue,
        );
        final globalChallenge = await endpoint.createChallenge(
          adminSession,
          null,
          'Global reproducibility challenge',
          'Compare results across institutions.',
          'Computer science',
          const ['open-science'],
          'advanced',
        );
        final globalTeam = await endpoint.createChallengeTeam(
          adminSession,
          globalChallenge.id!,
          'Cross-institution team',
          null,
        );
        final teamInvite = await endpoint.createChallengeTeamInvite(
          adminSession,
          globalTeam.id!,
          1003,
          7,
        );
        final invitedTeamMember = await endpoint.acceptChallengeTeamInvite(
          inviteeSession,
          teamInvite,
        );
        expect(invitedTeamMember.userId, 1003);
        final inviteAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) => t.targetType.equals('challenge_team_invite'),
          limit: 50,
        );
        expect(
          inviteAudit.any(
            (event) => event.action == 'challenge_team_invite_created',
          ),
          isTrue,
        );
        expect(
          inviteAudit.any(
            (event) => event.action == 'challenge_team_invite_accepted',
          ),
          isTrue,
        );
        await expectLater(
          endpoint.acceptChallengeTeamInvite(inviteeSession, teamInvite),
          throwsA(isA<Exception>()),
        );
        final milestone = await endpoint.createMilestone(
          adminSession,
          team.id!,
          'Reproduce baseline',
          'Document the current result.',
          DateTime.now().add(const Duration(days: 14)),
        );
        expect(milestone.description, 'Document the current result.');
        expect(milestone.dueAt, isNotNull);
        final update = await endpoint.postChallengeUpdate(
          adminSession,
          team.id!,
          'Baseline reproduction is underway.',
        );
        final milestones = await endpoint.getTeamMilestones(
          adminSession,
          team.id!,
          0,
          20,
        );
        final updates = await endpoint.getTeamUpdates(
          adminSession,
          team.id!,
          0,
          20,
        );
        final clampedUpdates = await endpoint.getTeamUpdates(
          adminSession,
          team.id!,
          -1,
          1000,
        );
        expect(milestones.map((item) => item.id), contains(milestone.id));
        expect(updates.map((item) => item.id), contains(update.id));
        expect(clampedUpdates.length, lessThanOrEqualTo(100));
        final studySession = await endpoint.createStudySession(
          adminSession,
          room.id!,
          'Weekly study session',
          'Compare the latest results.',
          DateTime.now().add(const Duration(hours: 2)),
          DateTime.now().add(const Duration(hours: 3)),
          'https://meet.example.com/studium',
        );
        expect(studySession.description, 'Compare the latest results.');
        expect(studySession.meetingUrl, 'https://meet.example.com/studium');
        final participant = await endpoint.joinStudySession(
          adminSession,
          studySession.id!,
        );
        expect(participant.userId, 1001);
        final sessionAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) => t.targetId.equals(studySession.id!),
          limit: 20,
        );
        expect(
          sessionAudit.any((event) => event.action == 'study_session_created'),
          isTrue,
        );
        final participantAudit = await AuditEvent.db.find(
          adminSession,
          where: (t) => t.targetId.equals(participant.id!),
          limit: 20,
        );
        expect(
          participantAudit
              .any((event) => event.action == 'study_session_joined'),
          isTrue,
        );
        await expectLater(
          endpoint.createStudySession(
            adminSession,
            room.id!,
            'Invalid meeting link',
            null,
            DateTime.now().add(const Duration(hours: 2)),
            DateTime.now().add(const Duration(hours: 3)),
            'javascript:alert(1)',
          ),
          throwsA(isA<Exception>()),
        );

        await UserRestriction.db.insertRow(
          adminSession,
          UserRestriction(
            userId: 1001,
            restrictionType: 'suspend',
            reason: 'Suspension enforcement test.',
            active: true,
            createdAt: DateTime.now(),
          ),
        );
        await expectLater(
          endpoint.createPost(
              adminSession, room.id!, 'This should be rejected.'),
          throwsA(isA<Exception>()),
        );

        await expectLater(
          endpoint.getRoomPosts(memberSession, room.id!, 0, 20),
          throwsA(isA<Exception>()),
        );
        await expectLater(
          endpoint.joinRoom(memberSession, room.id!),
          throwsA(isA<Exception>()),
        );
      } finally {
        await adminSession.close();
        await memberSession.close();
        await inviteeSession.close();
      }
    });

    test('rejects unauthenticated institution invites', () async {
      await expectLater(
        endpoints.collaboration.createInstitutionInvite(
          sessionBuilder,
          1,
          7,
          10,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.acceptInstitutionInvite(
          sessionBuilder,
          'invalid-institution-invite-token',
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.getMyVerificationRequests(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.getInstitutionVerificationRequests(
          sessionBuilder,
          1,
          0,
          20,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.getAcademicProfile(sessionBuilder, 1),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.upsertAcademicProfile(
          sessionBuilder,
          1,
          null,
          null,
          null,
          const [],
          const [],
          const [],
          null,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.submitVerificationEvidence(
          sessionBuilder,
          1,
          'https://example.com/evidence',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated institution member administration', () async {
      await expectLater(
        endpoints.collaboration.getInstitutionMembers(sessionBuilder, 1, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.updateInstitutionMember(
          sessionBuilder,
          1,
          'student',
          'verified',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated room creation', () async {
      await expectLater(
        endpoints.collaboration.createRoom(
          sessionBuilder,
          null,
          'Calculus study group',
          'A public room for revision.',
          'Calculus',
          'public',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated challenge creation', () async {
      await expectLater(
        endpoints.collaboration.createChallenge(
          sessionBuilder,
          null,
          'Open problem',
          'Find a reproducible solution.',
          'Computer science',
          const ['research'],
          'intermediate',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated team creation', () async {
      await expectLater(
        endpoints.collaboration.createChallengeTeam(
          sessionBuilder,
          1,
          'Research team',
          'A small team.',
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.createChallengeTeamInvite(
          sessionBuilder,
          1,
          2,
          7,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.acceptChallengeTeamInvite(
          sessionBuilder,
          'invalid-team-invite-token',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated team updates', () async {
      await expectLater(
        endpoints.collaboration.getTeamMilestones(sessionBuilder, 1, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.getTeamUpdates(sessionBuilder, 1, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.postChallengeUpdate(
          sessionBuilder,
          1,
          'Progress update',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated content reports', () async {
      await expectLater(
        endpoints.collaboration.reportContent(
          sessionBuilder,
          'post',
          1,
          'spam',
          null,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.submitModerationAppeal(
          sessionBuilder,
          1,
          'This should not be accepted.',
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.getMyModerationAppeals(sessionBuilder, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.getPendingModerationAppeals(
          sessionBuilder,
          page: 0,
          limit: 20,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.reviewModerationAppeal(
          sessionBuilder,
          1,
          'approved',
          null,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated report review', () async {
      await expectLater(
        endpoints.collaboration.getOpenReports(
          sessionBuilder,
          page: 0,
          limit: 20,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.getAuditEvents(
          sessionBuilder,
          page: 0,
          limit: 20,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.getInstitutionAuditEvents(
          sessionBuilder,
          1,
          page: 0,
          limit: 20,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.resolveReport(
          sessionBuilder,
          1,
          'dismiss',
          null,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated room resources', () async {
      await expectLater(
        endpoints.collaboration.getRoomResources(sessionBuilder, 1, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.getRoomResourceChunks(
          sessionBuilder,
          1,
          1,
          0,
          20,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration
            .indexRoomResourceEmbeddings(sessionBuilder, 1, 1),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.searchRoomKnowledge(
          sessionBuilder,
          1,
          'reproducibility',
          10,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.addRoomResource(
          sessionBuilder,
          1,
          'link',
          'Reference paper',
          'https://example.com/paper',
          null,
          null,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated room AI requests', () async {
      await expectLater(
        endpoints.collaboration.getRoomAiAnswers(
          sessionBuilder,
          1,
          0,
          20,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.askRoom(sessionBuilder, 1, 'What is this?'),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated post comments', () async {
      await expectLater(
        endpoints.collaboration.getPostComments(sessionBuilder, 1, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.createComment(
          sessionBuilder,
          1,
          'Helpful comment',
          null,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated room chat', () async {
      await expectLater(
        endpoints.collaboration.getRoomChatMessages(sessionBuilder, 1, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.roomChatStream(sessionBuilder, 1),
        emitsError(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.createRoomChatMessage(
          sessionBuilder,
          1,
          'Hello room',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated direct and group messaging', () async {
      await expectLater(
        endpoints.messaging.getMyConversations(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.messaging.createConversation(sessionBuilder, [2], null),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.messaging.getConversationMessages(sessionBuilder, 1, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.messaging.conversationStream(sessionBuilder, 1),
        emitsError(isA<Exception>()),
      );
      await expectLater(
        endpoints.messaging.sendMessage(sessionBuilder, 1, 'Hello'),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.messaging.markConversationRead(sessionBuilder, 1, 1),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.messaging.getConversationReadReceipts(sessionBuilder, 1),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.messaging.setSafetyRelationship(sessionBuilder, 2, 'block'),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.messaging.getMySafetyRelationships(sessionBuilder, 0, 20),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated room presence', () async {
      await expectLater(
        endpoints.collaboration.updateRoomPresence(sessionBuilder, 1, 'online'),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.getRoomPresence(sessionBuilder, 1),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated scheduled study sessions', () async {
      await expectLater(
        endpoints.collaboration.getRoomStudySessions(sessionBuilder, 1, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.createStudySession(
          sessionBuilder,
          1,
          'Exam preparation',
          null,
          DateTime.now().add(const Duration(hours: 1)),
          DateTime.now().add(const Duration(hours: 2)),
          null,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.joinStudySession(sessionBuilder, 1),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated notification access', () async {
      await expectLater(
        endpoints.notification.getNotifications(
          sessionBuilder,
          isRead: false,
          page: 0,
          limit: 20,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.notification.markAllNotificationsRead(sessionBuilder),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated collaborative documents', () async {
      await expectLater(
        endpoints.collaboration.getRoomDocuments(sessionBuilder, 1, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.documentStream(sessionBuilder, 1),
        emitsError(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.createDocument(
          sessionBuilder,
          1,
          'Shared notes',
          'First draft',
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.collaboration.updateDocument(
          sessionBuilder,
          1,
          'Shared notes',
          'Updated draft',
          1,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unsigned billing webhooks', () async {
      await expectLater(
        endpoints.billingWebhook.handleWebhook(
          sessionBuilder,
          'stripe',
          'evt_test_1',
          'customer.subscription.updated',
          '{}',
          'invalid-signature',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('accepts signed Stripe webhooks idempotently', () async {
      final session = sessionBuilder.build();
      try {
        const userId = 1002;
        const stripeSubscriptionId = 'sub_signed_fixture_1';
        const paystackSubscriptionId = 'paystack_signed_fixture_1';
        final user = await UserInfo.db.findById(session, userId);
        if (user == null) {
          await UserInfo.db.insertRow(
            session,
            UserInfo(
              id: userId,
              userIdentifier: '$userId',
              userName: 'billing-fixture-user',
              email: 'billing-fixture@example.edu',
              created: DateTime.now(),
              scopeNames: const [],
              blocked: false,
            ),
          );
        }
        final profile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(userId),
        );
        if (profile == null) {
          await UserProfile.db.insertRow(
            session,
            UserProfile(userId: userId, role: 'free'),
          );
        } else {
          await UserProfile.db.updateRow(
            session,
            profile.copyWith(role: 'free', subscriptionId: null),
          );
        }
        var stripeSubscription = await Subscription.db.findFirstRow(
          session,
          where: (t) => t.subscriptionId.equals(stripeSubscriptionId),
        );
        if (stripeSubscription == null) {
          stripeSubscription = await Subscription.db.insertRow(
            session,
            Subscription(
              userId: userId,
              gateway: 'stripe',
              subscriptionId: stripeSubscriptionId,
              status: 'pending',
              startDate: DateTime.now(),
            ),
          );
        } else {
          stripeSubscription.status = 'pending';
          stripeSubscription.endDate = null;
          await Subscription.db.updateRow(session, stripeSubscription);
        }

        final payload = jsonEncode({
          'subscriptionId': stripeSubscriptionId,
          'amount': 12500,
          'currency': 'usd',
          'settlement': {
            'amount': 11500,
            'currency': 'eur',
            'exchange_rate': 0.92,
          },
        });
        const secret = 'studium-test-webhook-secret';
        final timestamp = DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
        final signature = Hmac(sha256, utf8.encode(secret))
            .convert(utf8.encode('$timestamp.$payload'))
            .toString();
        final endpoint = BillingWebhookEndpoint();
        expect(
          await endpoint.handleWebhook(
            session,
            'stripe',
            'evt_signed_fixture_1',
            'customer.subscription.updated',
            payload,
            't=$timestamp,v1=$signature',
          ),
          isTrue,
        );
        expect(
          await endpoint.handleWebhook(
            session,
            'stripe',
            'evt_signed_fixture_1',
            'customer.subscription.updated',
            payload,
            't=$timestamp,v1=$signature',
          ),
          isTrue,
        );
        final events = await PaymentWebhookEvent.db.find(
          session,
          where: (t) => t.eventId.equals('evt_signed_fixture_1'),
        );
        expect(events, hasLength(1));
        expect(events.single.status, 'processed');

        final activeStripeSubscription = await Subscription.db.findFirstRow(
          session,
          where: (t) => t.subscriptionId.equals(stripeSubscriptionId),
        );
        expect(activeStripeSubscription?.status, 'active');
        final premiumProfile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(userId),
        );
        expect(premiumProfile?.role, 'premium');
        expect(premiumProfile?.subscriptionId, stripeSubscriptionId);
        final successfulStripePayments = await PaymentTransaction.db.find(
          session,
          where: (t) => t.transactionId.equals('evt_signed_fixture_1'),
        );
        expect(successfulStripePayments, hasLength(1));
        expect(successfulStripePayments.single.status, 'success');
        expect(successfulStripePayments.single.amount, 125);
        expect(successfulStripePayments.single.currency, 'USD');
        expect(successfulStripePayments.single.settlementAmount, 115);
        expect(successfulStripePayments.single.settlementCurrency, 'EUR');
        expect(successfulStripePayments.single.exchangeRate, 0.92);
        expect(successfulStripePayments.single.settlementSource,
            'gateway.settlement');

        final refundPayload = jsonEncode({
          'subscriptionId': stripeSubscriptionId,
          'amount': 12500,
          'currency': 'usd',
        });
        final refundTimestamp =
            DateTime.now().toUtc().millisecondsSinceEpoch ~/ 1000;
        final refundSignature = Hmac(sha256, utf8.encode(secret))
            .convert(utf8.encode('$refundTimestamp.$refundPayload'))
            .toString();
        expect(
          await endpoint.handleWebhook(
            session,
            'stripe',
            'evt_signed_refund_1',
            'charge.refunded',
            refundPayload,
            't=$refundTimestamp,v1=$refundSignature',
          ),
          isTrue,
        );
        expect(
          await endpoint.handleWebhook(
            session,
            'stripe',
            'evt_signed_refund_1',
            'charge.refunded',
            refundPayload,
            't=$refundTimestamp,v1=$refundSignature',
          ),
          isTrue,
        );
        final refundedSubscription = await Subscription.db.findFirstRow(
          session,
          where: (t) => t.subscriptionId.equals(stripeSubscriptionId),
        );
        expect(refundedSubscription?.status, 'canceled');
        final freeProfile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(userId),
        );
        expect(freeProfile?.role, 'free');
        expect(freeProfile?.subscriptionId, isNull);
        final refundPayments = await PaymentTransaction.db.find(
          session,
          where: (t) => t.transactionId.equals('evt_signed_refund_1'),
        );
        expect(refundPayments, hasLength(1));
        expect(refundPayments.single.status, 'refunded');

        final paystackSubscription = await Subscription.db.insertRow(
          session,
          Subscription(
            userId: userId,
            gateway: 'paystack',
            subscriptionId: paystackSubscriptionId,
            status: 'pending',
            startDate: DateTime.now(),
          ),
        );
        final paystackPayload = jsonEncode({
          'subscription_code': paystackSubscription.subscriptionId,
          'amount': 12500,
          'currency': 'ngn',
        });
        const paystackSecret = 'studium-test-paystack-webhook-secret';
        final paystackSignature = Hmac(sha512, utf8.encode(paystackSecret))
            .convert(utf8.encode(paystackPayload))
            .toString();
        expect(
          await endpoint.handleWebhook(
            session,
            'paystack',
            'evt_paystack_fixture_1',
            'subscription.updated',
            paystackPayload,
            paystackSignature,
          ),
          isTrue,
        );
        final paystackEvents = await PaymentWebhookEvent.db.find(
          session,
          where: (t) => t.eventId.equals('evt_paystack_fixture_1'),
        );
        expect(paystackEvents, hasLength(1));
        expect(paystackEvents.single.status, 'processed');
        final activePaystackSubscription = await Subscription.db.findFirstRow(
          session,
          where: (t) => t.subscriptionId.equals(paystackSubscriptionId),
        );
        expect(activePaystackSubscription?.status, 'active');
        final paystackProfile = await UserProfile.db.findFirstRow(
          session,
          where: (t) => t.userId.equals(userId),
        );
        expect(paystackProfile?.role, 'premium');
        expect(paystackProfile?.subscriptionId, paystackSubscriptionId);
        final paystackPayments = await PaymentTransaction.db.find(
          session,
          where: (t) => t.transactionId.equals('evt_paystack_fixture_1'),
        );
        expect(paystackPayments, hasLength(1));
        expect(paystackPayments.single.status, 'success');
        expect(paystackPayments.single.currency, 'NGN');
      } finally {
        await session.close();
      }
    });

    test('payment refunds distinguish partial and full entitlement reversal',
        () {
      expect(
        PaymentRefundService.transactionStatus(
          chargedAmount: 100,
          refundedAmount: 0,
          refundAmount: 25,
        ),
        'partial_refunded',
      );
      expect(
        PaymentRefundService.transactionStatus(
          chargedAmount: 100,
          refundedAmount: 25,
          refundAmount: 75,
        ),
        'refunded',
      );
      expect(
          PaymentRefundService.revokesEntitlement('partial_refunded'), isFalse);
      expect(PaymentRefundService.revokesEntitlement('refunded'), isTrue);
      expect(
        () => PaymentRefundService.transactionStatus(
          chargedAmount: 100,
          refundedAmount: 90,
          refundAmount: 20,
        ),
        throwsA(isA<StateError>()),
      );
    });

    test('rejects inconsistent payment settlement mappings', () {
      expect(
        () => PaymentSettlementService.fromPayload(
          {
            'amount': 12500,
            'currency': 'usd',
            'settlement': {
              'amount': 9000,
              'currency': 'eur',
              'exchange_rate': 0.92,
            },
          },
          chargedAmount: 125,
          chargedCurrency: 'USD',
        ),
        throwsA(isA<FormatException>()),
      );
    });

    test('rejects unauthenticated subscription creation', () async {
      final session = sessionBuilder.build();
      try {
        await expectLater(
          SubscriptionEndpoint().createSubscription(
            session,
            'stripe',
            'pm_test',
            'valid-idempotency-key-1002',
          ),
          throwsA(isA<Exception>()),
        );
      } finally {
        await session.close();
      }
    });

    test('rejects unauthenticated push-device registration', () async {
      await expectLater(
        endpoints.notification.registerPushDevice(
          sessionBuilder,
          'a' * 32,
          'android',
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.notification.unregisterPushDevice(sessionBuilder, 'a' * 32),
        throwsA(isA<Exception>()),
      );
    });

    test('rejects unauthenticated opportunity access', () async {
      await expectLater(
        endpoints.opportunity.getOpportunities(
          sessionBuilder,
          0,
          20,
          null,
          null,
          null,
          null,
          null,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.getSavedOpportunities(sessionBuilder, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.getApplicationTrackers(sessionBuilder, 0, 20),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.saveOpportunity(sessionBuilder, 1, true),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.upsertApplicationTracker(
          sessionBuilder,
          1,
          'interested',
          null,
          null,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.reviewOpportunity(sessionBuilder, 1, 'verified'),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.getPendingOpportunityReviews(
          sessionBuilder,
          page: 0,
          limit: 20,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.getOpportunityAlerts(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.createOpportunityAlert(
          sessionBuilder,
          null,
          null,
          null,
          const [],
          30,
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.deactivateOpportunityAlert(sessionBuilder, 1),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.registerOpportunitySource(
          sessionBuilder,
          'Provider feed',
          'Provider',
          'https://provider.example.org/feed',
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.ingestOpportunity(
          sessionBuilder,
          1,
          'external-1',
          'Scholarship',
          'scholarship',
          'Provider',
          'NG',
          null,
          'Computer science',
          'undergraduate',
          DateTime.now().add(const Duration(days: 30)),
          'Funding',
          'https://provider.example.org/1',
        ),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.opportunity.syncOpportunitySource(sessionBuilder, 1),
        throwsA(isA<Exception>()),
      );
    });
  });
}
