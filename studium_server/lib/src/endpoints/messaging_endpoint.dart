import 'package:serverpod/serverpod.dart';
import 'package:serverpod_auth_server/serverpod_auth_server.dart';

import '../generated/protocol.dart';
import '../util/endpoint_utils.dart';

class MessagingEndpoint extends Endpoint with EndpointUtils {
  @override
  bool get requireLogin => true;

  Future<UserPrivacySettings> getMyPrivacySettings(Session session) async {
    final userId = await getAuthenticatedUserId(session);
    final existing = await UserPrivacySettings.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    if (existing != null) return existing;
    return UserPrivacySettings(
      userId: userId,
      isMinor: false,
      allowUnknownDirectMessages: true,
      updatedAt: DateTime.now(),
    );
  }

  Future<UserPrivacySettings> updateMyPrivacySettings(
    Session session, {
    bool? isMinor,
    bool? allowUnknownDirectMessages,
  }) async {
    final userId = await getAuthenticatedUserId(session);
    final existing = await UserPrivacySettings.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(userId),
    );
    final nextIsMinor = isMinor ?? existing?.isMinor ?? false;
    final nextAllowUnknown = nextIsMinor
        ? false
        : (allowUnknownDirectMessages ??
            existing?.allowUnknownDirectMessages ??
            true);
    final settings = existing ??
        UserPrivacySettings(
          userId: userId,
          isMinor: nextIsMinor,
          allowUnknownDirectMessages: nextAllowUnknown,
          updatedAt: DateTime.now(),
        );
    settings.isMinor = nextIsMinor;
    settings.allowUnknownDirectMessages = nextAllowUnknown;
    settings.updatedAt = DateTime.now();
    return settings.id == null
        ? UserPrivacySettings.db.insertRow(session, settings)
        : UserPrivacySettings.db.updateRow(session, settings);
  }

  Future<UserSafetyRelationship> setSafetyRelationship(
    Session session,
    int targetUserId,
    String relationshipType,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    if (userId == targetUserId ||
        !{'block', 'mute', 'restrict'}.contains(relationshipType) ||
        await UserInfo.db.findById(session, targetUserId) == null) {
      throw Exception('Invalid safety relationship.');
    }
    final now = DateTime.now();
    final existing = await UserSafetyRelationship.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.targetUserId.equals(targetUserId) &
          t.relationshipType.equals(relationshipType),
    );
    if (existing != null) {
      existing.active = true;
      existing.updatedAt = now;
      return UserSafetyRelationship.db.updateRow(session, existing);
    }
    return UserSafetyRelationship.db.insertRow(
      session,
      UserSafetyRelationship(
        userId: userId,
        targetUserId: targetUserId,
        relationshipType: relationshipType,
        active: true,
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  Future<bool> removeSafetyRelationship(
    Session session,
    int targetUserId,
    String relationshipType,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    if (!{'block', 'mute', 'restrict'}.contains(relationshipType)) {
      throw Exception('Invalid safety relationship.');
    }
    final existing = await UserSafetyRelationship.db.findFirstRow(
      session,
      where: (t) =>
          t.userId.equals(userId) &
          t.targetUserId.equals(targetUserId) &
          t.relationshipType.equals(relationshipType) &
          t.active.equals(true),
    );
    if (existing == null) return false;
    existing.active = false;
    existing.updatedAt = DateTime.now();
    await UserSafetyRelationship.db.updateRow(session, existing);
    return true;
  }

  Future<List<UserSafetyRelationship>> getMySafetyRelationships(
    Session session,
    int page,
    int limit,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final safeLimit = limit.clamp(1, 100);
    return UserSafetyRelationship.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.active.equals(true),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<Conversation> createConversation(
    Session session,
    List<int> participantIds,
    String? title,
  ) async {
    final creatorId = await getAuthenticatedUserId(session);
    await enforceRateLimit(
      session,
      userId: creatorId,
      action: 'create-conversation',
      maximum: 20,
      window: const Duration(hours: 1),
    );
    final members = {...participantIds, creatorId}.toList();
    if (members.length < 2 || members.length > 50) {
      throw Exception('A conversation needs between 2 and 50 members.');
    }
    for (final userId in members) {
      if (await UserInfo.db.findById(session, userId) == null) {
        throw Exception('Conversation member not found.');
      }
      if (userId != creatorId &&
          (!await _isDirectMessageAllowed(session, creatorId, userId))) {
        throw Exception('Conversation is unavailable for this recipient.');
      }
    }
    final normalizedTitle = title?.trim();
    final now = DateTime.now();
    return session.db.transaction((transaction) async {
      final conversation = await Conversation.db.insertRow(
        session,
        Conversation(
          conversationType: members.length == 2 ? 'direct' : 'group',
          title: normalizedTitle?.isEmpty == true ? null : normalizedTitle,
          createdById: creatorId,
          createdAt: now,
          updatedAt: now,
        ),
        transaction: transaction,
      );
      for (final memberId in members) {
        await ConversationMember.db.insertRow(
          session,
          ConversationMember(
            conversationId: conversation.id!,
            userId: memberId,
            role: memberId == creatorId ? 'owner' : 'member',
            status: 'active',
            joinedAt: now,
          ),
          transaction: transaction,
        );
      }
      return conversation;
    });
  }

  Future<List<Conversation>> getMyConversations(Session session) async {
    final userId = await getAuthenticatedUserId(session);
    final memberships = await ConversationMember.db.find(
      session,
      where: (t) => t.userId.equals(userId) & t.status.equals('active'),
      orderBy: (t) => t.joinedAt,
      orderDescending: true,
      limit: 100,
    );
    if (memberships.isEmpty) return [];
    return Conversation.db.find(
      session,
      where: (t) =>
          t.id.inSet(memberships.map((m) => m.conversationId).toSet()),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      limit: 100,
    );
  }

  Future<List<DirectMessage>> getConversationMessages(
    Session session,
    int conversationId,
    int page,
    int limit,
  ) async {
    await _requireConversationMember(session, conversationId);
    final safeLimit = limit < 1 ? 1 : (limit > 100 ? 100 : limit);
    return DirectMessage.db.find(
      session,
      where: (t) =>
          t.conversationId.equals(conversationId) & t.status.equals('visible'),
      orderBy: (t) => t.createdAt,
      orderDescending: true,
      limit: safeLimit,
      offset: (page < 0 ? 0 : page) * safeLimit,
    );
  }

  Future<ConversationReadReceipt> markConversationRead(
    Session session,
    int conversationId,
    int messageId,
  ) async {
    final userId = await _requireConversationMember(session, conversationId);
    final message = await DirectMessage.db.findById(session, messageId);
    if (message == null ||
        message.conversationId != conversationId ||
        message.status != 'visible') {
      throw Exception('Message not found in conversation.');
    }
    final now = DateTime.now();
    final existing = await ConversationReadReceipt.db.findFirstRow(
      session,
      where: (t) =>
          t.conversationId.equals(conversationId) & t.userId.equals(userId),
    );
    if (existing != null) {
      final previouslyRead = await DirectMessage.db.findById(
        session,
        existing.lastReadMessageId,
      );
      if (previouslyRead != null &&
          previouslyRead.createdAt.isAfter(message.createdAt)) {
        return existing;
      }
      existing.lastReadMessageId = messageId;
      existing.updatedAt = now;
      return ConversationReadReceipt.db.updateRow(session, existing);
    }
    return ConversationReadReceipt.db.insertRow(
      session,
      ConversationReadReceipt(
        conversationId: conversationId,
        userId: userId,
        lastReadMessageId: messageId,
        updatedAt: now,
      ),
    );
  }

  Future<List<ConversationReadReceipt>> getConversationReadReceipts(
    Session session,
    int conversationId,
  ) async {
    await _requireConversationMember(session, conversationId);
    return ConversationReadReceipt.db.find(
      session,
      where: (t) => t.conversationId.equals(conversationId),
      orderBy: (t) => t.updatedAt,
      orderDescending: true,
      limit: 100,
    );
  }

  Stream<DirectMessage> conversationStream(
    Session session,
    int conversationId,
  ) async* {
    await _requireConversationMember(session, conversationId);
    yield* session.messages
        .createStream<DirectMessage>('conversation_$conversationId');
  }

  Future<DirectMessage> sendMessage(
    Session session,
    int conversationId,
    String body,
  ) async {
    final userId = await _requireConversationMember(session, conversationId);
    await _requireNotRestricted(session, userId);
    await enforceRateLimit(
      session,
      userId: userId,
      action: 'send-message',
      maximum: 120,
      window: const Duration(minutes: 1),
    );
    final members = await ConversationMember.db.find(
      session,
      where: (t) =>
          t.conversationId.equals(conversationId) &
          t.status.equals('active') &
          t.userId.notEquals(userId),
    );
    for (final member in members) {
      if (!await _isDirectMessageAllowed(session, userId, member.userId)) {
        throw Exception('Messaging is unavailable for this recipient.');
      }
    }
    if (body.trim().isEmpty || body.length > 5000) {
      throw Exception('Message body is invalid.');
    }
    final message = await DirectMessage.db.insertRow(
      session,
      DirectMessage(
        conversationId: conversationId,
        authorId: userId,
        body: body.trim(),
        status: 'visible',
        createdAt: DateTime.now(),
      ),
    );
    session.messages.postMessage('conversation_$conversationId', message);
    return message;
  }

  Future<int> _requireConversationMember(
    Session session,
    int conversationId,
  ) async {
    final userId = await getAuthenticatedUserId(session);
    final membership = await ConversationMember.db.findFirstRow(
      session,
      where: (t) =>
          t.conversationId.equals(conversationId) &
          t.userId.equals(userId) &
          t.status.equals('active'),
    );
    if (membership == null) {
      throw Exception('Conversation membership required.');
    }
    return userId;
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

  Future<bool> _isBlockedBetween(
    Session session,
    int firstUserId,
    int secondUserId,
  ) async {
    final relationship = await UserSafetyRelationship.db.findFirstRow(
      session,
      where: (t) =>
          ((t.userId.equals(firstUserId) &
                  t.targetUserId.equals(secondUserId)) |
              (t.userId.equals(secondUserId) &
                  t.targetUserId.equals(firstUserId))) &
          (t.relationshipType.equals('block') |
              t.relationshipType.equals('restrict')) &
          t.active.equals(true),
    );
    return relationship != null;
  }

  Future<bool> _isDirectMessageAllowed(
    Session session,
    int senderId,
    int recipientId,
  ) async {
    if (await _isBlockedBetween(session, senderId, recipientId)) return false;
    final privacy = await UserPrivacySettings.db.findFirstRow(
      session,
      where: (t) => t.userId.equals(recipientId),
    );
    return privacy?.allowUnknownDirectMessages ?? true;
  }
}
