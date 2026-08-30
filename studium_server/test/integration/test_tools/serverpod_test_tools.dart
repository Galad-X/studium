/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member
// ignore_for_file: no_leading_underscores_for_library_prefixes
// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:serverpod_test/serverpod_test.dart' as _i1;
import 'package:serverpod/serverpod.dart' as _i2;
import 'dart:async' as _i3;
import 'package:studium_server/src/generated/academic_writings.dart' as _i4;
import 'package:studium_server/src/generated/questions.dart' as _i5;
import 'package:studium_server/src/generated/answers.dart' as _i6;
import 'package:studium_server/src/generated/summaries.dart' as _i7;
import 'package:studium_server/src/generated/research_comparisons.dart' as _i8;
import 'package:studium_server/src/generated/user_analytics.dart' as _i9;
import 'package:studium_server/src/generated/user_reputation.dart' as _i10;
import 'package:studium_server/src/generated/institution.dart' as _i11;
import 'package:studium_server/src/generated/institution_membership.dart'
    as _i12;
import 'package:studium_server/src/generated/verification_request.dart' as _i13;
import 'package:studium_server/src/generated/academic_profile.dart' as _i14;
import 'package:studium_server/src/generated/study_room.dart' as _i15;
import 'package:studium_server/src/generated/room_membership.dart' as _i16;
import 'package:studium_server/src/generated/discussion_post.dart' as _i17;
import 'package:studium_server/src/generated/challenge.dart' as _i18;
import 'package:studium_server/src/generated/room_resource.dart' as _i19;
import 'dart:typed_data' as _i20;
import 'package:studium_server/src/generated/room_resource_chunk.dart' as _i21;
import 'package:studium_server/src/generated/challenge_team.dart' as _i22;
import 'package:studium_server/src/generated/challenge_team_member.dart'
    as _i23;
import 'package:studium_server/src/generated/challenge_milestone.dart' as _i24;
import 'package:studium_server/src/generated/challenge_update.dart' as _i25;
import 'package:studium_server/src/generated/comment.dart' as _i26;
import 'package:studium_server/src/generated/discussion_reaction.dart' as _i27;
import 'package:studium_server/src/generated/room_chat_message.dart' as _i28;
import 'package:studium_server/src/generated/room_ai_answer.dart' as _i29;
import 'package:studium_server/src/generated/collaboration_presence.dart'
    as _i30;
import 'package:studium_server/src/generated/scheduled_study_session.dart'
    as _i31;
import 'package:studium_server/src/generated/study_session_participant.dart'
    as _i32;
import 'package:studium_server/src/generated/content_report.dart' as _i33;
import 'package:studium_server/src/generated/audit_event.dart' as _i34;
import 'package:studium_server/src/generated/moderation_appeal.dart' as _i35;
import 'package:studium_server/src/generated/collaborative_document.dart'
    as _i36;
import 'package:studium_server/src/generated/user_privacy_settings.dart'
    as _i37;
import 'package:studium_server/src/generated/user_safety_relationship.dart'
    as _i38;
import 'package:studium_server/src/generated/conversation.dart' as _i39;
import 'package:studium_server/src/generated/direct_message.dart' as _i40;
import 'package:studium_server/src/generated/conversation_read_receipt.dart'
    as _i41;
import 'package:studium_server/src/generated/notifications.dart' as _i42;
import 'package:studium_server/src/generated/push_device.dart' as _i43;
import 'package:studium_server/src/generated/opportunity_source.dart' as _i44;
import 'package:studium_server/src/generated/opportunity.dart' as _i45;
import 'package:studium_server/src/generated/opportunity_save.dart' as _i46;
import 'package:studium_server/src/generated/opportunity_alert.dart' as _i47;
import 'package:studium_server/src/generated/opportunity_application_tracker.dart'
    as _i48;
import 'package:studium_server/src/generated/study_materials.dart' as _i49;
import 'package:studium_server/src/generated/file_processing.dart' as _i50;
import 'package:studium_server/src/generated/subscriptions.dart' as _i51;
import 'package:studium_server/src/generated/user_profile_bundle.dart' as _i52;
import 'package:studium_server/src/generated/user_profile.dart' as _i53;
import 'package:studium_server/src/generated/dashboard_bundle.dart' as _i54;
import 'package:studium_server/src/generated/study_history.dart' as _i55;
import 'package:studium_server/src/generated/protocol.dart';
import 'package:studium_server/src/generated/endpoints.dart';
export 'package:serverpod_test/serverpod_test_public_exports.dart';

/// Creates a new test group that takes a callback that can be used to write tests.
/// The callback has two parameters: `sessionBuilder` and `endpoints`.
/// `sessionBuilder` is used to build a `Session` object that represents the server state during an endpoint call and is used to set up scenarios.
/// `endpoints` contains all your Serverpod endpoints and lets you call them:
/// ```dart
/// withServerpod('Given Example endpoint', (sessionBuilder, endpoints) {
///   test('when calling `hello` then should return greeting', () async {
///     final greeting = await endpoints.example.hello(sessionBuilder, 'Michael');
///     expect(greeting, 'Hello Michael');
///   });
/// });
/// ```
///
/// **Configuration options**
///
/// [applyMigrations] Whether pending migrations should be applied when starting Serverpod. Defaults to `true`
///
/// [enableSessionLogging] Whether session logging should be enabled. Defaults to `false`
///
/// [rollbackDatabase] Options for when to rollback the database during the test lifecycle.
/// By default `withServerpod` does all database operations inside a transaction that is rolled back after each `test` case.
/// Just like the following enum describes, the behavior of the automatic rollbacks can be configured:
/// ```dart
/// /// Options for when to rollback the database during the test lifecycle.
/// enum RollbackDatabase {
///   /// After each test. This is the default.
///   afterEach,
///
///   /// After all tests.
///   afterAll,
///
///   /// Disable rolling back the database.
///   disabled,
/// }
/// ```
///
/// [runMode] The run mode that Serverpod should be running in. Defaults to `test`.
///
/// [serverpodLoggingMode] The logging mode used when creating Serverpod. Defaults to `ServerpodLoggingMode.normal`
///
/// [serverpodStartTimeout] The timeout to use when starting Serverpod, which connects to the database among other things. Defaults to `Duration(seconds: 30)`.
///
/// [testServerOutputMode] Options for controlling test server output during test execution. Defaults to `TestServerOutputMode.normal`.
/// ```dart
/// /// Options for controlling test server output during test execution.
/// enum TestServerOutputMode {
///   /// Default mode - only stderr is printed (stdout suppressed).
///   /// This hides normal startup/shutdown logs while preserving error messages.
///   normal,
///
///   /// All logging - both stdout and stderr are printed.
///   /// Useful for debugging when you need to see all server output.
///   verbose,
///
///   /// No logging - both stdout and stderr are suppressed.
///   /// Completely silent mode, useful when you don't want any server output.
///   silent,
/// }
/// ```
///
/// [configOverride] A function to override the server configuration. This function is called with
/// the default server configuration after it is loaded from the config/ directory
/// and before it is used to start the server. Use this to override particular
/// settings in the server configuration.
///
/// [testGroupTagsOverride] By default Serverpod test tools tags the `withServerpod` test group with `"integration"`.
/// This is to provide a simple way to only run unit or integration tests.
/// This property allows this tag to be overridden to something else. Defaults to `['integration']`.
///
/// [experimentalFeatures] Optionally specify experimental features. See [Serverpod] for more information.
@_i1.isTestGroup
void withServerpod(
  String testGroupName,
  _i1.TestClosure<TestEndpoints> testClosure, {
  bool? applyMigrations,
  _i2.ServerpodConfig Function(_i2.ServerpodConfig)? configOverride,
  bool? enableSessionLogging,
  _i2.ExperimentalFeatures? experimentalFeatures,
  _i1.RollbackDatabase? rollbackDatabase,
  String? runMode,
  _i2.RuntimeParametersListBuilder? runtimeParametersBuilder,
  _i2.ServerpodLoggingMode? serverpodLoggingMode,
  Duration? serverpodStartTimeout,
  List<String>? testGroupTagsOverride,
  _i1.TestServerOutputMode? testServerOutputMode,
}) {
  _i1.buildWithServerpod<_InternalTestEndpoints>(
    testGroupName,
    _i1.TestServerpod(
      testEndpoints: _InternalTestEndpoints(),
      endpoints: Endpoints(),
      serializationManager: Protocol(),
      runMode: runMode,
      applyMigrations: applyMigrations,
      isDatabaseEnabled: true,
      serverpodLoggingMode: serverpodLoggingMode,
      testServerOutputMode: testServerOutputMode,
      experimentalFeatures: experimentalFeatures,
      configOverride: configOverride,
      runtimeParametersBuilder: runtimeParametersBuilder,
    ),
    maybeRollbackDatabase: rollbackDatabase,
    maybeEnableSessionLogging: enableSessionLogging,
    maybeTestGroupTagsOverride: testGroupTagsOverride,
    maybeServerpodStartTimeout: serverpodStartTimeout,
    maybeTestServerOutputMode: testServerOutputMode,
  )(testClosure);
}

class TestEndpoints {
  late final _AcademicWritingEndpoint academicWriting;

  late final _AiEndpoint ai;

  late final _AnalyticsEndpoint analytics;

  late final _BillingWebhookEndpoint billingWebhook;

  late final _CollaborationEndpoint collaboration;

  late final _MessagingEndpoint messaging;

  late final _NotificationEndpoint notification;

  late final _OperationsEndpoint operations;

  late final _OpportunityEndpoint opportunity;

  late final _QuestionEndpoint question;

  late final _StudyMaterialEndpoint studyMaterial;

  late final _SubscriptionEndpoint subscription;

  late final _SummaryEndpoint summary;

  late final _UserEndpoint user;
}

class _InternalTestEndpoints extends TestEndpoints
    implements _i1.InternalTestEndpoints {
  @override
  void initialize(
    _i2.SerializationManager serializationManager,
    _i2.EndpointDispatch endpoints,
  ) {
    academicWriting = _AcademicWritingEndpoint(
      endpoints,
      serializationManager,
    );
    ai = _AiEndpoint(
      endpoints,
      serializationManager,
    );
    analytics = _AnalyticsEndpoint(
      endpoints,
      serializationManager,
    );
    billingWebhook = _BillingWebhookEndpoint(
      endpoints,
      serializationManager,
    );
    collaboration = _CollaborationEndpoint(
      endpoints,
      serializationManager,
    );
    messaging = _MessagingEndpoint(
      endpoints,
      serializationManager,
    );
    notification = _NotificationEndpoint(
      endpoints,
      serializationManager,
    );
    operations = _OperationsEndpoint(
      endpoints,
      serializationManager,
    );
    opportunity = _OpportunityEndpoint(
      endpoints,
      serializationManager,
    );
    question = _QuestionEndpoint(
      endpoints,
      serializationManager,
    );
    studyMaterial = _StudyMaterialEndpoint(
      endpoints,
      serializationManager,
    );
    subscription = _SubscriptionEndpoint(
      endpoints,
      serializationManager,
    );
    summary = _SummaryEndpoint(
      endpoints,
      serializationManager,
    );
    user = _UserEndpoint(
      endpoints,
      serializationManager,
    );
  }
}

class _AcademicWritingEndpoint {
  _AcademicWritingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i4.AcademicWriting> generateWriting(
    _i1.TestSessionBuilder sessionBuilder,
    int? studyMaterialId,
    String type,
    String title,
    String format,
    int? targetWordCount,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicWriting',
            method: 'generateWriting',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicWriting',
          methodName: 'generateWriting',
          parameters: _i1.testObjectToJson({
            'studyMaterialId': studyMaterialId,
            'type': type,
            'title': title,
            'format': format,
            'targetWordCount': targetWordCount,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AcademicWriting>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i4.AcademicWriting>> getWritings(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicWriting',
            method: 'getWritings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicWriting',
          methodName: 'getWritings',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i4.AcademicWriting>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteWriting(
    _i1.TestSessionBuilder sessionBuilder,
    int writingId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'academicWriting',
            method: 'deleteWriting',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'academicWriting',
          methodName: 'deleteWriting',
          parameters: _i1.testObjectToJson({'writingId': writingId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AiEndpoint {
  _AiEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i5.Question>> generateQuestions(
    _i1.TestSessionBuilder sessionBuilder,
    int studyMaterialId,
    List<String>? questionTypes,
    int count,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'ai',
            method: 'generateQuestions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'ai',
          methodName: 'generateQuestions',
          parameters: _i1.testObjectToJson({
            'studyMaterialId': studyMaterialId,
            'questionTypes': questionTypes,
            'count': count,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i5.Question>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i6.Answer> submitAnswer(
    _i1.TestSessionBuilder sessionBuilder,
    int questionId,
    String answerText,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'ai',
            method: 'submitAnswer',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'ai',
          methodName: 'submitAnswer',
          parameters: _i1.testObjectToJson({
            'questionId': questionId,
            'answerText': answerText,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i6.Answer>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.Summary> generateSummary(
    _i1.TestSessionBuilder sessionBuilder,
    int studyMaterialId,
    int? maxWords,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'ai',
            method: 'generateSummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'ai',
          methodName: 'generateSummary',
          parameters: _i1.testObjectToJson({
            'studyMaterialId': studyMaterialId,
            'maxWords': maxWords,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.Summary>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i7.Summary> generateSampleSummary(
    _i1.TestSessionBuilder sessionBuilder,
    int maxWords,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'ai',
            method: 'generateSampleSummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'ai',
          methodName: 'generateSampleSummary',
          parameters: _i1.testObjectToJson({'maxWords': maxWords}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i7.Summary>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i4.AcademicWriting> generateAcademicWriting(
    _i1.TestSessionBuilder sessionBuilder,
    int? studyMaterialId,
    String type,
    String title,
    String format,
    int? targetWordCount,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'ai',
            method: 'generateAcademicWriting',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'ai',
          methodName: 'generateAcademicWriting',
          parameters: _i1.testObjectToJson({
            'studyMaterialId': studyMaterialId,
            'type': type,
            'title': title,
            'format': format,
            'targetWordCount': targetWordCount,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i4.AcademicWriting>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i8.ResearchComparison> generateResearchComparison(
    _i1.TestSessionBuilder sessionBuilder,
    int studyMaterialId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'ai',
            method: 'generateResearchComparison',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'ai',
          methodName: 'generateResearchComparison',
          parameters: _i1.testObjectToJson({
            'studyMaterialId': studyMaterialId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i8.ResearchComparison>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _AnalyticsEndpoint {
  _AnalyticsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<bool> logAction(
    _i1.TestSessionBuilder sessionBuilder,
    String action,
    String? metadata,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'logAction',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'logAction',
          parameters: _i1.testObjectToJson({
            'action': action,
            'metadata': metadata,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i9.UserAnalytics>> getAnalytics(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'analytics',
            method: 'getAnalytics',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'analytics',
          methodName: 'getAnalytics',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i9.UserAnalytics>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _BillingWebhookEndpoint {
  _BillingWebhookEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<bool> handleWebhook(
    _i1.TestSessionBuilder sessionBuilder,
    String gateway,
    String eventId,
    String eventType,
    String payload,
    String signature,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'billingWebhook',
            method: 'handleWebhook',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'billingWebhook',
          methodName: 'handleWebhook',
          parameters: _i1.testObjectToJson({
            'gateway': gateway,
            'eventId': eventId,
            'eventType': eventType,
            'payload': payload,
            'signature': signature,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _CollaborationEndpoint {
  _CollaborationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i10.UserReputation> getMyReputation(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getMyReputation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getMyReputation',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i10.UserReputation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i11.Institution>> searchInstitutions(
    _i1.TestSessionBuilder sessionBuilder,
    String query,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'searchInstitutions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'searchInstitutions',
          parameters: _i1.testObjectToJson({
            'query': query,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i11.Institution>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.Institution> submitInstitution(
    _i1.TestSessionBuilder sessionBuilder,
    String name,
    String country,
    String? region,
    List<String> domains,
    String? logoUrl,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'submitInstitution',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'submitInstitution',
          parameters: _i1.testObjectToJson({
            'name': name,
            'country': country,
            'region': region,
            'domains': domains,
            'logoUrl': logoUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.Institution>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i11.Institution> reviewInstitution(
    _i1.TestSessionBuilder sessionBuilder,
    int institutionId,
    String decision,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'reviewInstitution',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'reviewInstitution',
          parameters: _i1.testObjectToJson({
            'institutionId': institutionId,
            'decision': decision,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i11.Institution>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i11.Institution>> getPendingInstitutionReviews(
    _i1.TestSessionBuilder sessionBuilder,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getPendingInstitutionReviews',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getPendingInstitutionReviews',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i11.Institution>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i12.InstitutionMembership>> getMyMemberships(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getMyMemberships',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getMyMemberships',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i12.InstitutionMembership>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.VerificationRequest>> getMyVerificationRequests(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getMyVerificationRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getMyVerificationRequests',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.VerificationRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.AcademicProfile?> getAcademicProfile(
    _i1.TestSessionBuilder sessionBuilder,
    int institutionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getAcademicProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getAcademicProfile',
          parameters: _i1.testObjectToJson({'institutionId': institutionId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i14.AcademicProfile?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i14.AcademicProfile> upsertAcademicProfile(
    _i1.TestSessionBuilder sessionBuilder,
    int institutionId,
    String? department,
    String? programme,
    String? level,
    List<String> subjects,
    List<String> interests,
    List<String> languages,
    String? availability,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'upsertAcademicProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'upsertAcademicProfile',
          parameters: _i1.testObjectToJson({
            'institutionId': institutionId,
            'department': department,
            'programme': programme,
            'level': level,
            'subjects': subjects,
            'interests': interests,
            'languages': languages,
            'availability': availability,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i14.AcademicProfile>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> createInstitutionInvite(
    _i1.TestSessionBuilder sessionBuilder,
    int institutionId,
    int expiresInDays,
    int maxUses,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createInstitutionInvite',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createInstitutionInvite',
          parameters: _i1.testObjectToJson({
            'institutionId': institutionId,
            'expiresInDays': expiresInDays,
            'maxUses': maxUses,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.InstitutionMembership> acceptInstitutionInvite(
    _i1.TestSessionBuilder sessionBuilder,
    String token,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'acceptInstitutionInvite',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'acceptInstitutionInvite',
          parameters: _i1.testObjectToJson({'token': token}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.InstitutionMembership>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i12.InstitutionMembership>> getInstitutionMembers(
    _i1.TestSessionBuilder sessionBuilder,
    int institutionId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getInstitutionMembers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getInstitutionMembers',
          parameters: _i1.testObjectToJson({
            'institutionId': institutionId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i12.InstitutionMembership>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i13.VerificationRequest>> getInstitutionVerificationRequests(
    _i1.TestSessionBuilder sessionBuilder,
    int institutionId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getInstitutionVerificationRequests',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getInstitutionVerificationRequests',
          parameters: _i1.testObjectToJson({
            'institutionId': institutionId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i13.VerificationRequest>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.InstitutionMembership> updateInstitutionMember(
    _i1.TestSessionBuilder sessionBuilder,
    int membershipId,
    String role,
    String status,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'updateInstitutionMember',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'updateInstitutionMember',
          parameters: _i1.testObjectToJson({
            'membershipId': membershipId,
            'role': role,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.InstitutionMembership>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.InstitutionMembership> requestMembership(
    _i1.TestSessionBuilder sessionBuilder,
    int institutionId,
    String verificationMethod,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'requestMembership',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'requestMembership',
          parameters: _i1.testObjectToJson({
            'institutionId': institutionId,
            'verificationMethod': verificationMethod,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.InstitutionMembership>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i13.VerificationRequest> submitVerificationEvidence(
    _i1.TestSessionBuilder sessionBuilder,
    int membershipId,
    String evidenceUrl,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'submitVerificationEvidence',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'submitVerificationEvidence',
          parameters: _i1.testObjectToJson({
            'membershipId': membershipId,
            'evidenceUrl': evidenceUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i13.VerificationRequest>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i12.InstitutionMembership> reviewMembership(
    _i1.TestSessionBuilder sessionBuilder,
    int membershipId,
    String decision,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'reviewMembership',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'reviewMembership',
          parameters: _i1.testObjectToJson({
            'membershipId': membershipId,
            'decision': decision,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i12.InstitutionMembership>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i15.StudyRoom>> getRooms(
    _i1.TestSessionBuilder sessionBuilder,
    int page,
    int limit, [
    int? institutionId,
    String? subject,
  ]) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getRooms',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getRooms',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
            'institutionId': institutionId,
            'subject': subject,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i15.StudyRoom>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i15.StudyRoom> createRoom(
    _i1.TestSessionBuilder sessionBuilder,
    int? institutionId,
    String title,
    String description,
    String? subject,
    String visibility,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createRoom',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createRoom',
          parameters: _i1.testObjectToJson({
            'institutionId': institutionId,
            'title': title,
            'description': description,
            'subject': subject,
            'visibility': visibility,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i15.StudyRoom>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i16.RoomMembership> joinRoom(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'joinRoom',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'joinRoom',
          parameters: _i1.testObjectToJson({'roomId': roomId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i16.RoomMembership>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i16.RoomMembership?> getMyRoomMembership(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getMyRoomMembership',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getMyRoomMembership',
          parameters: _i1.testObjectToJson({'roomId': roomId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i16.RoomMembership?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i17.DiscussionPost>> getRoomPosts(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getRoomPosts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getRoomPosts',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i17.DiscussionPost>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.DiscussionPost> createPost(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    String body,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createPost',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createPost',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'body': body,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i17.DiscussionPost>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i18.Challenge>> getChallenges(
    _i1.TestSessionBuilder sessionBuilder,
    int page,
    int limit,
    int? roomId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getChallenges',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getChallenges',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
            'roomId': roomId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i18.Challenge>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i18.Challenge> createChallenge(
    _i1.TestSessionBuilder sessionBuilder,
    int? roomId,
    String title,
    String problemStatement,
    String field,
    List<String> tags,
    String difficulty,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createChallenge',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createChallenge',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'title': title,
            'problemStatement': problemStatement,
            'field': field,
            'tags': tags,
            'difficulty': difficulty,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i18.Challenge>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i19.RoomResource>> getRoomResources(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getRoomResources',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getRoomResources',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i19.RoomResource>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i19.RoomResource> addRoomResource(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    String resourceType,
    String title,
    String? uri,
    String? content,
    String? citation,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'addRoomResource',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'addRoomResource',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'resourceType': resourceType,
            'title': title,
            'uri': uri,
            'content': content,
            'citation': citation,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i19.RoomResource>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i19.RoomResource> uploadRoomResource(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    String resourceType,
    String title,
    String fileType,
    _i20.ByteData fileData,
    String? citation,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'uploadRoomResource',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'uploadRoomResource',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'resourceType': resourceType,
            'title': title,
            'fileType': fileType,
            'fileData': fileData,
            'citation': citation,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i19.RoomResource>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i21.RoomResourceChunk>> getRoomResourceChunks(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    int resourceId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getRoomResourceChunks',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getRoomResourceChunks',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'resourceId': resourceId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i21.RoomResourceChunk>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> indexRoomResourceEmbeddings(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    int resourceId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'indexRoomResourceEmbeddings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'indexRoomResourceEmbeddings',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'resourceId': resourceId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i21.RoomResourceChunk>> searchRoomKnowledge(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    String query,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'searchRoomKnowledge',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'searchRoomKnowledge',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'query': query,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i21.RoomResourceChunk>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i22.ChallengeTeam>> getChallengeTeams(
    _i1.TestSessionBuilder sessionBuilder,
    int challengeId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getChallengeTeams',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getChallengeTeams',
          parameters: _i1.testObjectToJson({'challengeId': challengeId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i22.ChallengeTeam>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i23.ChallengeTeamMember>> getChallengeTeamMembers(
    _i1.TestSessionBuilder sessionBuilder,
    int teamId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getChallengeTeamMembers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getChallengeTeamMembers',
          parameters: _i1.testObjectToJson({
            'teamId': teamId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i23.ChallengeTeamMember>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i22.ChallengeTeam> createChallengeTeam(
    _i1.TestSessionBuilder sessionBuilder,
    int challengeId,
    String name,
    String? description,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createChallengeTeam',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createChallengeTeam',
          parameters: _i1.testObjectToJson({
            'challengeId': challengeId,
            'name': name,
            'description': description,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i22.ChallengeTeam>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i23.ChallengeTeamMember> joinChallengeTeam(
    _i1.TestSessionBuilder sessionBuilder,
    int teamId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'joinChallengeTeam',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'joinChallengeTeam',
          parameters: _i1.testObjectToJson({'teamId': teamId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i23.ChallengeTeamMember>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<String> createChallengeTeamInvite(
    _i1.TestSessionBuilder sessionBuilder,
    int teamId,
    int inviteeId,
    int expiresInDays,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createChallengeTeamInvite',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createChallengeTeamInvite',
          parameters: _i1.testObjectToJson({
            'teamId': teamId,
            'inviteeId': inviteeId,
            'expiresInDays': expiresInDays,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<String>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i23.ChallengeTeamMember> acceptChallengeTeamInvite(
    _i1.TestSessionBuilder sessionBuilder,
    String token,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'acceptChallengeTeamInvite',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'acceptChallengeTeamInvite',
          parameters: _i1.testObjectToJson({'token': token}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i23.ChallengeTeamMember>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i24.ChallengeMilestone>> getTeamMilestones(
    _i1.TestSessionBuilder sessionBuilder,
    int teamId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getTeamMilestones',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getTeamMilestones',
          parameters: _i1.testObjectToJson({
            'teamId': teamId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i24.ChallengeMilestone>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i24.ChallengeMilestone> createMilestone(
    _i1.TestSessionBuilder sessionBuilder,
    int teamId,
    String title,
    String? description,
    DateTime? dueAt,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createMilestone',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createMilestone',
          parameters: _i1.testObjectToJson({
            'teamId': teamId,
            'title': title,
            'description': description,
            'dueAt': dueAt,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i24.ChallengeMilestone>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i24.ChallengeMilestone> updateChallengeMilestone(
    _i1.TestSessionBuilder sessionBuilder,
    int milestoneId,
    String title,
    String? description,
    String status,
    DateTime? dueAt,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'updateChallengeMilestone',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'updateChallengeMilestone',
          parameters: _i1.testObjectToJson({
            'milestoneId': milestoneId,
            'title': title,
            'description': description,
            'status': status,
            'dueAt': dueAt,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i24.ChallengeMilestone>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i23.ChallengeTeamMember> updateChallengeTeamMember(
    _i1.TestSessionBuilder sessionBuilder,
    int membershipId,
    String role,
    String status,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'updateChallengeTeamMember',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'updateChallengeTeamMember',
          parameters: _i1.testObjectToJson({
            'membershipId': membershipId,
            'role': role,
            'status': status,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i23.ChallengeTeamMember>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i25.ChallengeProgressUpdate>> getTeamUpdates(
    _i1.TestSessionBuilder sessionBuilder,
    int teamId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getTeamUpdates',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getTeamUpdates',
          parameters: _i1.testObjectToJson({
            'teamId': teamId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i25.ChallengeProgressUpdate>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i25.ChallengeProgressUpdate> postChallengeUpdate(
    _i1.TestSessionBuilder sessionBuilder,
    int teamId,
    String body,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'postChallengeUpdate',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'postChallengeUpdate',
          parameters: _i1.testObjectToJson({
            'teamId': teamId,
            'body': body,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i25.ChallengeProgressUpdate>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i26.Comment>> getPostComments(
    _i1.TestSessionBuilder sessionBuilder,
    int postId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getPostComments',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getPostComments',
          parameters: _i1.testObjectToJson({
            'postId': postId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i26.Comment>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i26.Comment> createComment(
    _i1.TestSessionBuilder sessionBuilder,
    int postId,
    String body,
    int? parentCommentId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createComment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createComment',
          parameters: _i1.testObjectToJson({
            'postId': postId,
            'body': body,
            'parentCommentId': parentCommentId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i26.Comment>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i17.DiscussionPost> acceptPostComment(
    _i1.TestSessionBuilder sessionBuilder,
    int postId,
    int? commentId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'acceptPostComment',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'acceptPostComment',
          parameters: _i1.testObjectToJson({
            'postId': postId,
            'commentId': commentId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i17.DiscussionPost>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i27.DiscussionReaction?> setPostReaction(
    _i1.TestSessionBuilder sessionBuilder,
    int postId,
    String? reaction,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'setPostReaction',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'setPostReaction',
          parameters: _i1.testObjectToJson({
            'postId': postId,
            'reaction': reaction,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i27.DiscussionReaction?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Stream<_i17.DiscussionPost> roomPostStream(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
  ) {
    var _localTestStreamManager = _i1.TestStreamManager<_i17.DiscussionPost>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'collaboration',
              method: 'roomPostStream',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'collaboration',
              methodName: 'roomPostStream',
              arguments: {'roomId': roomId},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Future<List<_i28.RoomChatMessage>> getRoomChatMessages(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getRoomChatMessages',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getRoomChatMessages',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i28.RoomChatMessage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Stream<_i28.RoomChatMessage> roomChatStream(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
  ) {
    var _localTestStreamManager = _i1.TestStreamManager<_i28.RoomChatMessage>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'collaboration',
              method: 'roomChatStream',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'collaboration',
              methodName: 'roomChatStream',
              arguments: {'roomId': roomId},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Future<_i28.RoomChatMessage> createRoomChatMessage(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    String body,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createRoomChatMessage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createRoomChatMessage',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'body': body,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i28.RoomChatMessage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i29.RoomAiAnswer>> getRoomAiAnswers(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getRoomAiAnswers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getRoomAiAnswers',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i29.RoomAiAnswer>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i29.RoomAiAnswer> askRoom(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    String question,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'askRoom',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'askRoom',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'question': question,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i29.RoomAiAnswer>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i30.CollaborationPresence> updateRoomPresence(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    String state,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'updateRoomPresence',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'updateRoomPresence',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'state': state,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i30.CollaborationPresence>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i30.CollaborationPresence>> getRoomPresence(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getRoomPresence',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getRoomPresence',
          parameters: _i1.testObjectToJson({'roomId': roomId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i30.CollaborationPresence>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i31.ScheduledStudySession>> getRoomStudySessions(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getRoomStudySessions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getRoomStudySessions',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i31.ScheduledStudySession>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i31.ScheduledStudySession> createStudySession(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    String title,
    String? description,
    DateTime startsAt,
    DateTime endsAt,
    String? meetingUrl,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createStudySession',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createStudySession',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'title': title,
            'description': description,
            'startsAt': startsAt,
            'endsAt': endsAt,
            'meetingUrl': meetingUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i31.ScheduledStudySession>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i32.StudySessionParticipant> joinStudySession(
    _i1.TestSessionBuilder sessionBuilder,
    int sessionId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'joinStudySession',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'joinStudySession',
          parameters: _i1.testObjectToJson({'sessionId': sessionId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i32.StudySessionParticipant>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i33.ContentReport> reportContent(
    _i1.TestSessionBuilder sessionBuilder,
    String contentType,
    int contentId,
    String reason,
    String? details,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'reportContent',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'reportContent',
          parameters: _i1.testObjectToJson({
            'contentType': contentType,
            'contentId': contentId,
            'reason': reason,
            'details': details,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i33.ContentReport>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i33.ContentReport>> getOpenReports(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getOpenReports',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getOpenReports',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i33.ContentReport>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i33.ContentReport>> getMyContentReports(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getMyContentReports',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getMyContentReports',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i33.ContentReport>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i34.AuditEvent>> getAuditEvents(
    _i1.TestSessionBuilder sessionBuilder, {
    String? targetType,
    int? targetId,
    required int page,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getAuditEvents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getAuditEvents',
          parameters: _i1.testObjectToJson({
            'targetType': targetType,
            'targetId': targetId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i34.AuditEvent>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i34.AuditEvent>> getInstitutionAuditEvents(
    _i1.TestSessionBuilder sessionBuilder,
    int institutionId, {
    required int page,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getInstitutionAuditEvents',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getInstitutionAuditEvents',
          parameters: _i1.testObjectToJson({
            'institutionId': institutionId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i34.AuditEvent>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i35.ModerationAppeal> submitModerationAppeal(
    _i1.TestSessionBuilder sessionBuilder,
    int reportId,
    String reason,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'submitModerationAppeal',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'submitModerationAppeal',
          parameters: _i1.testObjectToJson({
            'reportId': reportId,
            'reason': reason,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i35.ModerationAppeal>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i35.ModerationAppeal>> getMyModerationAppeals(
    _i1.TestSessionBuilder sessionBuilder,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getMyModerationAppeals',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getMyModerationAppeals',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i35.ModerationAppeal>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i35.ModerationAppeal>> getPendingModerationAppeals(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getPendingModerationAppeals',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getPendingModerationAppeals',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i35.ModerationAppeal>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i35.ModerationAppeal> reviewModerationAppeal(
    _i1.TestSessionBuilder sessionBuilder,
    int appealId,
    String decision,
    String? notes,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'reviewModerationAppeal',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'reviewModerationAppeal',
          parameters: _i1.testObjectToJson({
            'appealId': appealId,
            'decision': decision,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i35.ModerationAppeal>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i33.ContentReport> resolveReport(
    _i1.TestSessionBuilder sessionBuilder,
    int reportId,
    String action,
    String? notes,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'resolveReport',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'resolveReport',
          parameters: _i1.testObjectToJson({
            'reportId': reportId,
            'action': action,
            'notes': notes,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i33.ContentReport>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i36.CollaborativeDocument>> getRoomDocuments(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'getRoomDocuments',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'getRoomDocuments',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i36.CollaborativeDocument>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Stream<_i36.CollaborativeDocument> documentStream(
    _i1.TestSessionBuilder sessionBuilder,
    int documentId,
  ) {
    var _localTestStreamManager =
        _i1.TestStreamManager<_i36.CollaborativeDocument>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'collaboration',
              method: 'documentStream',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'collaboration',
              methodName: 'documentStream',
              arguments: {'documentId': documentId},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Future<_i36.CollaborativeDocument> createDocument(
    _i1.TestSessionBuilder sessionBuilder,
    int roomId,
    String title,
    String body,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'createDocument',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'createDocument',
          parameters: _i1.testObjectToJson({
            'roomId': roomId,
            'title': title,
            'body': body,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i36.CollaborativeDocument>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i36.CollaborativeDocument> updateDocument(
    _i1.TestSessionBuilder sessionBuilder,
    int documentId,
    String title,
    String body,
    int expectedVersion,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'collaboration',
            method: 'updateDocument',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'collaboration',
          methodName: 'updateDocument',
          parameters: _i1.testObjectToJson({
            'documentId': documentId,
            'title': title,
            'body': body,
            'expectedVersion': expectedVersion,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i36.CollaborativeDocument>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _MessagingEndpoint {
  _MessagingEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i37.UserPrivacySettings> getMyPrivacySettings(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getMyPrivacySettings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getMyPrivacySettings',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i37.UserPrivacySettings>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i37.UserPrivacySettings> updateMyPrivacySettings(
    _i1.TestSessionBuilder sessionBuilder, {
    bool? isMinor,
    bool? allowUnknownDirectMessages,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'updateMyPrivacySettings',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'updateMyPrivacySettings',
          parameters: _i1.testObjectToJson({
            'isMinor': isMinor,
            'allowUnknownDirectMessages': allowUnknownDirectMessages,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i37.UserPrivacySettings>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i38.UserSafetyRelationship> setSafetyRelationship(
    _i1.TestSessionBuilder sessionBuilder,
    int targetUserId,
    String relationshipType,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'setSafetyRelationship',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'setSafetyRelationship',
          parameters: _i1.testObjectToJson({
            'targetUserId': targetUserId,
            'relationshipType': relationshipType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i38.UserSafetyRelationship>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> removeSafetyRelationship(
    _i1.TestSessionBuilder sessionBuilder,
    int targetUserId,
    String relationshipType,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'removeSafetyRelationship',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'removeSafetyRelationship',
          parameters: _i1.testObjectToJson({
            'targetUserId': targetUserId,
            'relationshipType': relationshipType,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i38.UserSafetyRelationship>> getMySafetyRelationships(
    _i1.TestSessionBuilder sessionBuilder,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getMySafetyRelationships',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getMySafetyRelationships',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i38.UserSafetyRelationship>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i39.Conversation> createConversation(
    _i1.TestSessionBuilder sessionBuilder,
    List<int> participantIds,
    String? title,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'createConversation',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'createConversation',
          parameters: _i1.testObjectToJson({
            'participantIds': participantIds,
            'title': title,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i39.Conversation>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i39.Conversation>> getMyConversations(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getMyConversations',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getMyConversations',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i39.Conversation>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i40.DirectMessage>> getConversationMessages(
    _i1.TestSessionBuilder sessionBuilder,
    int conversationId,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getConversationMessages',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getConversationMessages',
          parameters: _i1.testObjectToJson({
            'conversationId': conversationId,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i40.DirectMessage>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i41.ConversationReadReceipt> markConversationRead(
    _i1.TestSessionBuilder sessionBuilder,
    int conversationId,
    int messageId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'markConversationRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'markConversationRead',
          parameters: _i1.testObjectToJson({
            'conversationId': conversationId,
            'messageId': messageId,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i41.ConversationReadReceipt>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i41.ConversationReadReceipt>> getConversationReadReceipts(
    _i1.TestSessionBuilder sessionBuilder,
    int conversationId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'getConversationReadReceipts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'getConversationReadReceipts',
          parameters: _i1.testObjectToJson({'conversationId': conversationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i41.ConversationReadReceipt>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Stream<_i40.DirectMessage> conversationStream(
    _i1.TestSessionBuilder sessionBuilder,
    int conversationId,
  ) {
    var _localTestStreamManager = _i1.TestStreamManager<_i40.DirectMessage>();
    _i1.callStreamFunctionAndHandleExceptions(
      () async {
        var _localUniqueSession =
            (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
              endpoint: 'messaging',
              method: 'conversationStream',
            );
        var _localCallContext = await _endpointDispatch
            .getMethodStreamCallContext(
              createSessionCallback: (_) => _localUniqueSession,
              endpointPath: 'messaging',
              methodName: 'conversationStream',
              arguments: {'conversationId': conversationId},
              requestedInputStreams: [],
              serializationManager: _serializationManager,
            );
        await _localTestStreamManager.callStreamMethod(
          _localCallContext,
          _localUniqueSession,
          {},
        );
      },
      _localTestStreamManager.outputStreamController,
    );
    return _localTestStreamManager.outputStreamController.stream;
  }

  _i3.Future<_i40.DirectMessage> sendMessage(
    _i1.TestSessionBuilder sessionBuilder,
    int conversationId,
    String body,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'messaging',
            method: 'sendMessage',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'messaging',
          methodName: 'sendMessage',
          parameters: _i1.testObjectToJson({
            'conversationId': conversationId,
            'body': body,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i40.DirectMessage>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _NotificationEndpoint {
  _NotificationEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i42.Notification>> getNotifications(
    _i1.TestSessionBuilder sessionBuilder, {
    required bool isRead,
    required int page,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'getNotifications',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'getNotifications',
          parameters: _i1.testObjectToJson({
            'isRead': isRead,
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i42.Notification>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> markNotificationRead(
    _i1.TestSessionBuilder sessionBuilder,
    int notificationId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'markNotificationRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'markNotificationRead',
          parameters: _i1.testObjectToJson({'notificationId': notificationId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> markAllNotificationsRead(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'markAllNotificationsRead',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'markAllNotificationsRead',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i43.PushDevice> registerPushDevice(
    _i1.TestSessionBuilder sessionBuilder,
    String token,
    String platform,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'registerPushDevice',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'registerPushDevice',
          parameters: _i1.testObjectToJson({
            'token': token,
            'platform': platform,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i43.PushDevice>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> unregisterPushDevice(
    _i1.TestSessionBuilder sessionBuilder,
    String token,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'notification',
            method: 'unregisterPushDevice',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'notification',
          methodName: 'unregisterPushDevice',
          parameters: _i1.testObjectToJson({'token': token}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _OperationsEndpoint {
  _OperationsEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<Map<String, int>> getQueueHealth(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'operations',
            method: 'getQueueHealth',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'operations',
          methodName: 'getQueueHealth',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, int>> getSchedulerHealth(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'operations',
            method: 'getSchedulerHealth',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'operations',
          methodName: 'getSchedulerHealth',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, int>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _OpportunityEndpoint {
  _OpportunityEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i44.OpportunitySource> registerOpportunitySource(
    _i1.TestSessionBuilder sessionBuilder,
    String name,
    String provider,
    String feedUrl,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'registerOpportunitySource',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'registerOpportunitySource',
          parameters: _i1.testObjectToJson({
            'name': name,
            'provider': provider,
            'feedUrl': feedUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i44.OpportunitySource>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i45.Opportunity> ingestOpportunity(
    _i1.TestSessionBuilder sessionBuilder,
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
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'ingestOpportunity',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'ingestOpportunity',
          parameters: _i1.testObjectToJson({
            'sourceId': sourceId,
            'externalId': externalId,
            'title': title,
            'opportunityType': opportunityType,
            'provider': provider,
            'country': country,
            'eligibilityRegion': eligibilityRegion,
            'field': field,
            'educationLevel': educationLevel,
            'deadline': deadline,
            'fundingDetails': fundingDetails,
            'officialUrl': officialUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i45.Opportunity>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<int> syncOpportunitySource(
    _i1.TestSessionBuilder sessionBuilder,
    int sourceId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'syncOpportunitySource',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'syncOpportunitySource',
          parameters: _i1.testObjectToJson({'sourceId': sourceId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<int>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i45.Opportunity>> getOpportunities(
    _i1.TestSessionBuilder sessionBuilder,
    int page,
    int limit,
    String? country,
    String? field,
    String? educationLevel,
    String? opportunityType,
    DateTime? deadlineBefore,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'getOpportunities',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'getOpportunities',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
            'country': country,
            'field': field,
            'educationLevel': educationLevel,
            'opportunityType': opportunityType,
            'deadlineBefore': deadlineBefore,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i45.Opportunity>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i45.Opportunity> submitOpportunity(
    _i1.TestSessionBuilder sessionBuilder,
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
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'submitOpportunity',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'submitOpportunity',
          parameters: _i1.testObjectToJson({
            'title': title,
            'opportunityType': opportunityType,
            'provider': provider,
            'country': country,
            'eligibilityRegion': eligibilityRegion,
            'field': field,
            'educationLevel': educationLevel,
            'deadline': deadline,
            'fundingDetails': fundingDetails,
            'officialUrl': officialUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i45.Opportunity>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i46.OpportunitySave> saveOpportunity(
    _i1.TestSessionBuilder sessionBuilder,
    int opportunityId,
    bool alertEnabled,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'saveOpportunity',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'saveOpportunity',
          parameters: _i1.testObjectToJson({
            'opportunityId': opportunityId,
            'alertEnabled': alertEnabled,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i46.OpportunitySave>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i46.OpportunitySave>> getSavedOpportunities(
    _i1.TestSessionBuilder sessionBuilder,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'getSavedOpportunities',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'getSavedOpportunities',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i46.OpportunitySave>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i45.Opportunity> reviewOpportunity(
    _i1.TestSessionBuilder sessionBuilder,
    int opportunityId,
    String verificationStatus,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'reviewOpportunity',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'reviewOpportunity',
          parameters: _i1.testObjectToJson({
            'opportunityId': opportunityId,
            'verificationStatus': verificationStatus,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i45.Opportunity>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i45.Opportunity>> getPendingOpportunityReviews(
    _i1.TestSessionBuilder sessionBuilder, {
    required int page,
    required int limit,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'getPendingOpportunityReviews',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'getPendingOpportunityReviews',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i45.Opportunity>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i47.OpportunityAlert> createOpportunityAlert(
    _i1.TestSessionBuilder sessionBuilder,
    String? country,
    String? field,
    String? educationLevel,
    List<String> opportunityTypes,
    int deadlineWithinDays,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'createOpportunityAlert',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'createOpportunityAlert',
          parameters: _i1.testObjectToJson({
            'country': country,
            'field': field,
            'educationLevel': educationLevel,
            'opportunityTypes': opportunityTypes,
            'deadlineWithinDays': deadlineWithinDays,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i47.OpportunityAlert>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i47.OpportunityAlert>> getOpportunityAlerts(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'getOpportunityAlerts',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'getOpportunityAlerts',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i47.OpportunityAlert>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deactivateOpportunityAlert(
    _i1.TestSessionBuilder sessionBuilder,
    int alertId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'deactivateOpportunityAlert',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'deactivateOpportunityAlert',
          parameters: _i1.testObjectToJson({'alertId': alertId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i48.OpportunityApplicationTracker>> getApplicationTrackers(
    _i1.TestSessionBuilder sessionBuilder,
    int page,
    int limit,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'getApplicationTrackers',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'getApplicationTrackers',
          parameters: _i1.testObjectToJson({
            'page': page,
            'limit': limit,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i48.OpportunityApplicationTracker>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i48.OpportunityApplicationTracker> upsertApplicationTracker(
    _i1.TestSessionBuilder sessionBuilder,
    int opportunityId,
    String status,
    String? notes,
    String? applicationUrl,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'opportunity',
            method: 'upsertApplicationTracker',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'opportunity',
          methodName: 'upsertApplicationTracker',
          parameters: _i1.testObjectToJson({
            'opportunityId': opportunityId,
            'status': status,
            'notes': notes,
            'applicationUrl': applicationUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i48.OpportunityApplicationTracker>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _QuestionEndpoint {
  _QuestionEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i5.Question>> getSampleQuestions(
    _i1.TestSessionBuilder sessionBuilder,
    int count,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'question',
            method: 'getSampleQuestions',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'question',
          methodName: 'getSampleQuestions',
          parameters: _i1.testObjectToJson({'count': count}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i5.Question>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _StudyMaterialEndpoint {
  _StudyMaterialEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i49.StudyMaterial> uploadMaterial(
    _i1.TestSessionBuilder sessionBuilder,
    String title,
    String fileType,
    _i20.ByteData? fileData,
    String? fileUrl,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyMaterial',
            method: 'uploadMaterial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyMaterial',
          methodName: 'uploadMaterial',
          parameters: _i1.testObjectToJson({
            'title': title,
            'fileType': fileType,
            'fileData': fileData,
            'fileUrl': fileUrl,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i49.StudyMaterial>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i49.StudyMaterial>> getMaterials(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyMaterial',
            method: 'getMaterials',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyMaterial',
          methodName: 'getMaterials',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i49.StudyMaterial>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i49.StudyMaterial> getSampleMaterial(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyMaterial',
            method: 'getSampleMaterial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyMaterial',
          methodName: 'getSampleMaterial',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i49.StudyMaterial>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<void> deleteMaterial(
    _i1.TestSessionBuilder sessionBuilder,
    int materialId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyMaterial',
            method: 'deleteMaterial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyMaterial',
          methodName: 'deleteMaterial',
          parameters: _i1.testObjectToJson({'materialId': materialId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<void>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i49.StudyMaterial> updateMaterial(
    _i1.TestSessionBuilder sessionBuilder,
    int materialId,
    String? title,
    Map<String, dynamic>? metadata,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyMaterial',
            method: 'updateMaterial',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyMaterial',
          methodName: 'updateMaterial',
          parameters: _i1.testObjectToJson({
            'materialId': materialId,
            'title': title,
            'metadata': metadata,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i49.StudyMaterial>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i50.FileProcessing?> getProcessingStatus(
    _i1.TestSessionBuilder sessionBuilder,
    int materialId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyMaterial',
            method: 'getProcessingStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyMaterial',
          methodName: 'getProcessingStatus',
          parameters: _i1.testObjectToJson({'materialId': materialId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i50.FileProcessing?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i49.StudyMaterial>> getMaterialsByType(
    _i1.TestSessionBuilder sessionBuilder,
    String fileType,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyMaterial',
            method: 'getMaterialsByType',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyMaterial',
          methodName: 'getMaterialsByType',
          parameters: _i1.testObjectToJson({'fileType': fileType}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i49.StudyMaterial>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<List<_i49.StudyMaterial>> searchMaterials(
    _i1.TestSessionBuilder sessionBuilder,
    String query,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyMaterial',
            method: 'searchMaterials',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyMaterial',
          methodName: 'searchMaterials',
          parameters: _i1.testObjectToJson({'query': query}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i49.StudyMaterial>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<Map<String, dynamic>> getMaterialStats(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyMaterial',
            method: 'getMaterialStats',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyMaterial',
          methodName: 'getMaterialStats',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<Map<String, dynamic>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i50.FileProcessing> retryFileProcessing(
    _i1.TestSessionBuilder sessionBuilder,
    int materialId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'studyMaterial',
            method: 'retryFileProcessing',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'studyMaterial',
          methodName: 'retryFileProcessing',
          parameters: _i1.testObjectToJson({'materialId': materialId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i50.FileProcessing>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SubscriptionEndpoint {
  _SubscriptionEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i51.Subscription> createSubscription(
    _i1.TestSessionBuilder sessionBuilder,
    String gateway,
    String paymentToken, [
    String? idempotencyKey,
  ]) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'subscription',
            method: 'createSubscription',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'subscription',
          methodName: 'createSubscription',
          parameters: _i1.testObjectToJson({
            'gateway': gateway,
            'paymentToken': paymentToken,
            'idempotencyKey': idempotencyKey,
          }),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i51.Subscription>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> cancelSubscription(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'subscription',
            method: 'cancelSubscription',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'subscription',
          methodName: 'cancelSubscription',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i51.Subscription?> getSubscriptionStatus(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'subscription',
            method: 'getSubscriptionStatus',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'subscription',
          methodName: 'getSubscriptionStatus',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i51.Subscription?>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _SummaryEndpoint {
  _SummaryEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<List<_i7.Summary>> getSummaries(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'summary',
            method: 'getSummaries',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'summary',
          methodName: 'getSummaries',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<List<_i7.Summary>>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<bool> deleteSummary(
    _i1.TestSessionBuilder sessionBuilder,
    int summaryId,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'summary',
            method: 'deleteSummary',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'summary',
          methodName: 'deleteSummary',
          parameters: _i1.testObjectToJson({'summaryId': summaryId}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<bool>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}

class _UserEndpoint {
  _UserEndpoint(
    this._endpointDispatch,
    this._serializationManager,
  );

  final _i2.EndpointDispatch _endpointDispatch;

  final _i2.SerializationManager _serializationManager;

  _i3.Future<_i52.UserProfileBundle> getProfileBundle(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'getProfileBundle',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'getProfileBundle',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i52.UserProfileBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i53.UserProfile> updateProfile(
    _i1.TestSessionBuilder sessionBuilder, {
    String? name,
  }) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'updateProfile',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'updateProfile',
          parameters: _i1.testObjectToJson({'name': name}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i53.UserProfile>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i54.DashboardBundle> getDashboardBundle(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'getDashboardBundle',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'getDashboardBundle',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i54.DashboardBundle>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }

  _i3.Future<_i55.StudyHistory> createStudyHistory(
    _i1.TestSessionBuilder sessionBuilder,
  ) async {
    return _i1.callAwaitableFunctionAndHandleExceptions(() async {
      var _localUniqueSession =
          (sessionBuilder as _i1.InternalTestSessionBuilder).internalBuild(
            endpoint: 'user',
            method: 'createStudyHistory',
          );
      try {
        var _localCallContext = await _endpointDispatch.getMethodCallContext(
          createSessionCallback: (_) => _localUniqueSession,
          endpointPath: 'user',
          methodName: 'createStudyHistory',
          parameters: _i1.testObjectToJson({}),
          serializationManager: _serializationManager,
        );
        var _localReturnValue =
            await (_localCallContext.method.call(
                  _localUniqueSession,
                  _localCallContext.arguments,
                )
                as _i3.Future<_i55.StudyHistory>);
        return _localReturnValue;
      } finally {
        await _localUniqueSession.close();
      }
    });
  }
}
