/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:studium_client/src/protocol/academic_writings.dart' as _i3;
import 'package:studium_client/src/protocol/questions.dart' as _i4;
import 'package:studium_client/src/protocol/answers.dart' as _i5;
import 'package:studium_client/src/protocol/summaries.dart' as _i6;
import 'package:studium_client/src/protocol/research_comparisons.dart' as _i7;
import 'package:studium_client/src/protocol/user_analytics.dart' as _i8;
import 'package:studium_client/src/protocol/notifications.dart' as _i9;
import 'package:studium_client/src/protocol/study_materials.dart' as _i10;
import 'dart:typed_data' as _i11;
import 'package:studium_client/src/protocol/file_processing.dart' as _i12;
import 'package:studium_client/src/protocol/subscriptions.dart' as _i13;
import 'package:studium_client/src/protocol/user_profile_bundle.dart' as _i14;
import 'package:studium_client/src/protocol/user_profile.dart' as _i15;
import 'package:studium_client/src/protocol/dashboard_bundle.dart' as _i16;
import 'package:studium_client/src/protocol/study_history.dart' as _i17;
import 'package:serverpod_auth_client/serverpod_auth_client.dart' as _i18;
import 'protocol.dart' as _i19;

/// {@category Endpoint}
class EndpointAcademicWriting extends _i1.EndpointRef {
  EndpointAcademicWriting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'academicWriting';

  _i2.Future<_i3.AcademicWriting> generateWriting(
    int? studyMaterialId,
    String type,
    String title,
    String format,
    int? targetWordCount,
  ) =>
      caller.callServerEndpoint<_i3.AcademicWriting>(
        'academicWriting',
        'generateWriting',
        {
          'studyMaterialId': studyMaterialId,
          'type': type,
          'title': title,
          'format': format,
          'targetWordCount': targetWordCount,
        },
      );

  _i2.Future<List<_i3.AcademicWriting>> getWritings() =>
      caller.callServerEndpoint<List<_i3.AcademicWriting>>(
        'academicWriting',
        'getWritings',
        {},
      );

  _i2.Future<bool> deleteWriting(int writingId) =>
      caller.callServerEndpoint<bool>(
        'academicWriting',
        'deleteWriting',
        {'writingId': writingId},
      );
}

/// {@category Endpoint}
class EndpointAi extends _i1.EndpointRef {
  EndpointAi(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'ai';

  _i2.Future<List<_i4.Question>> generateQuestions(
    int studyMaterialId,
    List<String>? questionTypes,
    int count,
  ) =>
      caller.callServerEndpoint<List<_i4.Question>>(
        'ai',
        'generateQuestions',
        {
          'studyMaterialId': studyMaterialId,
          'questionTypes': questionTypes,
          'count': count,
        },
      );

  /// Submit and evaluate an answer
  _i2.Future<_i5.Answer> submitAnswer(
    int questionId,
    String answerText,
  ) =>
      caller.callServerEndpoint<_i5.Answer>(
        'ai',
        'submitAnswer',
        {
          'questionId': questionId,
          'answerText': answerText,
        },
      );

  _i2.Future<_i6.Summary> generateSummary(
    int studyMaterialId,
    int? maxWords,
  ) =>
      caller.callServerEndpoint<_i6.Summary>(
        'ai',
        'generateSummary',
        {
          'studyMaterialId': studyMaterialId,
          'maxWords': maxWords,
        },
      );

  _i2.Future<_i6.Summary> generateSampleSummary(int maxWords) =>
      caller.callServerEndpoint<_i6.Summary>(
        'ai',
        'generateSampleSummary',
        {'maxWords': maxWords},
      );

  _i2.Future<_i3.AcademicWriting> generateAcademicWriting(
    int? studyMaterialId,
    String type,
    String title,
    String format,
    int? targetWordCount,
  ) =>
      caller.callServerEndpoint<_i3.AcademicWriting>(
        'ai',
        'generateAcademicWriting',
        {
          'studyMaterialId': studyMaterialId,
          'type': type,
          'title': title,
          'format': format,
          'targetWordCount': targetWordCount,
        },
      );

  _i2.Future<_i7.ResearchComparison> generateResearchComparison(
          int studyMaterialId) =>
      caller.callServerEndpoint<_i7.ResearchComparison>(
        'ai',
        'generateResearchComparison',
        {'studyMaterialId': studyMaterialId},
      );
}

/// {@category Endpoint}
class EndpointAnalytics extends _i1.EndpointRef {
  EndpointAnalytics(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'analytics';

  _i2.Future<bool> logAction(
    String action,
    String? metadata,
  ) =>
      caller.callServerEndpoint<bool>(
        'analytics',
        'logAction',
        {
          'action': action,
          'metadata': metadata,
        },
      );

  _i2.Future<List<_i8.UserAnalytics>> getAnalytics() =>
      caller.callServerEndpoint<List<_i8.UserAnalytics>>(
        'analytics',
        'getAnalytics',
        {},
      );
}

/// {@category Endpoint}
class EndpointNotification extends _i1.EndpointRef {
  EndpointNotification(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'notification';

  _i2.Future<List<_i9.Notification>> getNotifications({required bool isRead}) =>
      caller.callServerEndpoint<List<_i9.Notification>>(
        'notification',
        'getNotifications',
        {'isRead': isRead},
      );

  _i2.Future<bool> markNotificationRead(int notificationId) =>
      caller.callServerEndpoint<bool>(
        'notification',
        'markNotificationRead',
        {'notificationId': notificationId},
      );
}

/// {@category Endpoint}
class EndpointQuestion extends _i1.EndpointRef {
  EndpointQuestion(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'question';

  /// Generate sample questions for unauthorized/demo users
  _i2.Future<List<_i4.Question>> getSampleQuestions(int count) =>
      caller.callServerEndpoint<List<_i4.Question>>(
        'question',
        'getSampleQuestions',
        {'count': count},
      );
}

/// {@category Endpoint}
class EndpointStudyMaterial extends _i1.EndpointRef {
  EndpointStudyMaterial(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'studyMaterial';

  /// Upload study material
  _i2.Future<_i10.StudyMaterial> uploadMaterial(
    String title,
    String fileType,
    _i11.ByteData? fileData,
    String? fileUrl,
  ) =>
      caller.callServerEndpoint<_i10.StudyMaterial>(
        'studyMaterial',
        'uploadMaterial',
        {
          'title': title,
          'fileType': fileType,
          'fileData': fileData,
          'fileUrl': fileUrl,
        },
      );

  /// Get all materials for authenticated user
  _i2.Future<List<_i10.StudyMaterial>> getMaterials() =>
      caller.callServerEndpoint<List<_i10.StudyMaterial>>(
        'studyMaterial',
        'getMaterials',
        {},
      );

  /// Get sample material for demo purposes
  _i2.Future<_i10.StudyMaterial> getSampleMaterial() =>
      caller.callServerEndpoint<_i10.StudyMaterial>(
        'studyMaterial',
        'getSampleMaterial',
        {},
      );

  /// Delete a study material
  _i2.Future<void> deleteMaterial(int materialId) =>
      caller.callServerEndpoint<void>(
        'studyMaterial',
        'deleteMaterial',
        {'materialId': materialId},
      );

  /// Update study material metadata
  _i2.Future<_i10.StudyMaterial> updateMaterial(
    int materialId,
    String? title,
    Map<String, dynamic>? metadata,
  ) =>
      caller.callServerEndpoint<_i10.StudyMaterial>(
        'studyMaterial',
        'updateMaterial',
        {
          'materialId': materialId,
          'title': title,
          'metadata': metadata,
        },
      );

  /// Get processing status of a material
  _i2.Future<_i12.FileProcessing?> getProcessingStatus(int materialId) =>
      caller.callServerEndpoint<_i12.FileProcessing?>(
        'studyMaterial',
        'getProcessingStatus',
        {'materialId': materialId},
      );

  /// Get materials by file type (for authenticated user)
  _i2.Future<List<_i10.StudyMaterial>> getMaterialsByType(String fileType) =>
      caller.callServerEndpoint<List<_i10.StudyMaterial>>(
        'studyMaterial',
        'getMaterialsByType',
        {'fileType': fileType},
      );

  /// Search materials by title
  _i2.Future<List<_i10.StudyMaterial>> searchMaterials(String query) =>
      caller.callServerEndpoint<List<_i10.StudyMaterial>>(
        'studyMaterial',
        'searchMaterials',
        {'query': query},
      );

  /// Get material statistics for user
  _i2.Future<Map<String, dynamic>> getMaterialStats() =>
      caller.callServerEndpoint<Map<String, dynamic>>(
        'studyMaterial',
        'getMaterialStats',
        {},
      );
}

/// {@category Endpoint}
class EndpointSubscription extends _i1.EndpointRef {
  EndpointSubscription(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'subscription';

  _i2.Future<_i13.Subscription> createSubscription(
    String gateway,
    String paymentToken,
  ) =>
      caller.callServerEndpoint<_i13.Subscription>(
        'subscription',
        'createSubscription',
        {
          'gateway': gateway,
          'paymentToken': paymentToken,
        },
      );

  /// Cancels the user's active subscription.
  _i2.Future<bool> cancelSubscription() => caller.callServerEndpoint<bool>(
        'subscription',
        'cancelSubscription',
        {},
      );

  _i2.Future<_i13.Subscription?> getSubscriptionStatus() =>
      caller.callServerEndpoint<_i13.Subscription?>(
        'subscription',
        'getSubscriptionStatus',
        {},
      );
}

/// {@category Endpoint}
class EndpointSummary extends _i1.EndpointRef {
  EndpointSummary(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'summary';

  _i2.Future<List<_i6.Summary>> getSummaries() =>
      caller.callServerEndpoint<List<_i6.Summary>>(
        'summary',
        'getSummaries',
        {},
      );
}

/// {@category Endpoint}
class EndpointUser extends _i1.EndpointRef {
  EndpointUser(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'user';

  /// Fetches the user's profile and their active subscription in one call.
  /// Creates a default profile if none exists (for new users).
  _i2.Future<_i14.UserProfileBundle> getProfileBundle() =>
      caller.callServerEndpoint<_i14.UserProfileBundle>(
        'user',
        'getProfileBundle',
        {},
      );

  /// Updates the user's profile information
  _i2.Future<_i15.UserProfile> updateProfile({
    String? name,
    String? role,
  }) =>
      caller.callServerEndpoint<_i15.UserProfile>(
        'user',
        'updateProfile',
        {
          'name': name,
          'role': role,
        },
      );

  _i2.Future<_i16.DashboardBundle> getDashboardBundle() =>
      caller.callServerEndpoint<_i16.DashboardBundle>(
        'user',
        'getDashboardBundle',
        {},
      );

  /// Helper method to create initial study history for new users
  _i2.Future<_i17.StudyHistory> createStudyHistory(int userId) =>
      caller.callServerEndpoint<_i17.StudyHistory>(
        'user',
        'createStudyHistory',
        {'userId': userId},
      );
}

class Modules {
  Modules(Client client) {
    auth = _i18.Caller(client);
  }

  late final _i18.Caller auth;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    _i1.AuthenticationKeyManager? authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )? onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
          host,
          _i19.Protocol(),
          securityContext: securityContext,
          authenticationKeyManager: authenticationKeyManager,
          streamingConnectionTimeout: streamingConnectionTimeout,
          connectionTimeout: connectionTimeout,
          onFailedCall: onFailedCall,
          onSucceededCall: onSucceededCall,
          disconnectStreamsOnLostInternetConnection:
              disconnectStreamsOnLostInternetConnection,
        ) {
    academicWriting = EndpointAcademicWriting(this);
    ai = EndpointAi(this);
    analytics = EndpointAnalytics(this);
    notification = EndpointNotification(this);
    question = EndpointQuestion(this);
    studyMaterial = EndpointStudyMaterial(this);
    subscription = EndpointSubscription(this);
    summary = EndpointSummary(this);
    user = EndpointUser(this);
    modules = Modules(this);
  }

  late final EndpointAcademicWriting academicWriting;

  late final EndpointAi ai;

  late final EndpointAnalytics analytics;

  late final EndpointNotification notification;

  late final EndpointQuestion question;

  late final EndpointStudyMaterial studyMaterial;

  late final EndpointSubscription subscription;

  late final EndpointSummary summary;

  late final EndpointUser user;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {
        'academicWriting': academicWriting,
        'ai': ai,
        'analytics': analytics,
        'notification': notification,
        'question': question,
        'studyMaterial': studyMaterial,
        'subscription': subscription,
        'summary': summary,
        'user': user,
      };

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup =>
      {'auth': modules.auth};
}
