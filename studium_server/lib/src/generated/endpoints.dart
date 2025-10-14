/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/academic_writer_endpoint.dart' as _i2;
import '../endpoints/ai_endpoint.dart' as _i3;
import '../endpoints/analytics_endpoint.dart' as _i4;
import '../endpoints/notification_endpoint.dart' as _i5;
import '../endpoints/question_endpoint.dart' as _i6;
import '../endpoints/study_material_endpoint.dart' as _i7;
import '../endpoints/subscription_endpoint.dart' as _i8;
import '../endpoints/summary_endpoint.dart' as _i9;
import '../endpoints/user_endpoint.dart' as _i10;
import 'dart:typed_data' as _i11;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i12;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'academicWriting': _i2.AcademicWritingEndpoint()
        ..initialize(
          server,
          'academicWriting',
          null,
        ),
      'ai': _i3.AiEndpoint()
        ..initialize(
          server,
          'ai',
          null,
        ),
      'analytics': _i4.AnalyticsEndpoint()
        ..initialize(
          server,
          'analytics',
          null,
        ),
      'notification': _i5.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'question': _i6.QuestionEndpoint()
        ..initialize(
          server,
          'question',
          null,
        ),
      'studyMaterial': _i7.StudyMaterialEndpoint()
        ..initialize(
          server,
          'studyMaterial',
          null,
        ),
      'subscription': _i8.SubscriptionEndpoint()
        ..initialize(
          server,
          'subscription',
          null,
        ),
      'summary': _i9.SummaryEndpoint()
        ..initialize(
          server,
          'summary',
          null,
        ),
      'user': _i10.UserEndpoint()
        ..initialize(
          server,
          'user',
          null,
        ),
    };
    connectors['academicWriting'] = _i1.EndpointConnector(
      name: 'academicWriting',
      endpoint: endpoints['academicWriting']!,
      methodConnectors: {
        'generateWriting': _i1.MethodConnector(
          name: 'generateWriting',
          params: {
            'studyMaterialId': _i1.ParameterDescription(
              name: 'studyMaterialId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'format': _i1.ParameterDescription(
              name: 'format',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetWordCount': _i1.ParameterDescription(
              name: 'targetWordCount',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['academicWriting'] as _i2.AcademicWritingEndpoint)
                  .generateWriting(
            session,
            params['studyMaterialId'],
            params['type'],
            params['title'],
            params['format'],
            params['targetWordCount'],
          ),
        ),
        'getWritings': _i1.MethodConnector(
          name: 'getWritings',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['academicWriting'] as _i2.AcademicWritingEndpoint)
                  .getWritings(session),
        ),
        'deleteWriting': _i1.MethodConnector(
          name: 'deleteWriting',
          params: {
            'writingId': _i1.ParameterDescription(
              name: 'writingId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['academicWriting'] as _i2.AcademicWritingEndpoint)
                  .deleteWriting(
            session,
            params['writingId'],
          ),
        ),
      },
    );
    connectors['ai'] = _i1.EndpointConnector(
      name: 'ai',
      endpoint: endpoints['ai']!,
      methodConnectors: {
        'generateQuestions': _i1.MethodConnector(
          name: 'generateQuestions',
          params: {
            'studyMaterialId': _i1.ParameterDescription(
              name: 'studyMaterialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'questionTypes': _i1.ParameterDescription(
              name: 'questionTypes',
              type: _i1.getType<List<String>?>(),
              nullable: true,
            ),
            'count': _i1.ParameterDescription(
              name: 'count',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ai'] as _i3.AiEndpoint).generateQuestions(
            session,
            params['studyMaterialId'],
            params['questionTypes'],
            params['count'],
          ),
        ),
        'submitAnswer': _i1.MethodConnector(
          name: 'submitAnswer',
          params: {
            'questionId': _i1.ParameterDescription(
              name: 'questionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'answerText': _i1.ParameterDescription(
              name: 'answerText',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ai'] as _i3.AiEndpoint).submitAnswer(
            session,
            params['questionId'],
            params['answerText'],
          ),
        ),
        'generateSummary': _i1.MethodConnector(
          name: 'generateSummary',
          params: {
            'studyMaterialId': _i1.ParameterDescription(
              name: 'studyMaterialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'maxWords': _i1.ParameterDescription(
              name: 'maxWords',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ai'] as _i3.AiEndpoint).generateSummary(
            session,
            params['studyMaterialId'],
            params['maxWords'],
          ),
        ),
        'generateSampleSummary': _i1.MethodConnector(
          name: 'generateSampleSummary',
          params: {
            'maxWords': _i1.ParameterDescription(
              name: 'maxWords',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ai'] as _i3.AiEndpoint).generateSampleSummary(
            session,
            params['maxWords'],
          ),
        ),
        'generateAcademicWriting': _i1.MethodConnector(
          name: 'generateAcademicWriting',
          params: {
            'studyMaterialId': _i1.ParameterDescription(
              name: 'studyMaterialId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'type': _i1.ParameterDescription(
              name: 'type',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'format': _i1.ParameterDescription(
              name: 'format',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'targetWordCount': _i1.ParameterDescription(
              name: 'targetWordCount',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ai'] as _i3.AiEndpoint).generateAcademicWriting(
            session,
            params['studyMaterialId'],
            params['type'],
            params['title'],
            params['format'],
            params['targetWordCount'],
          ),
        ),
        'generateResearchComparison': _i1.MethodConnector(
          name: 'generateResearchComparison',
          params: {
            'studyMaterialId': _i1.ParameterDescription(
              name: 'studyMaterialId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['ai'] as _i3.AiEndpoint).generateResearchComparison(
            session,
            params['studyMaterialId'],
          ),
        ),
      },
    );
    connectors['analytics'] = _i1.EndpointConnector(
      name: 'analytics',
      endpoint: endpoints['analytics']!,
      methodConnectors: {
        'logAction': _i1.MethodConnector(
          name: 'logAction',
          params: {
            'action': _i1.ParameterDescription(
              name: 'action',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'metadata': _i1.ParameterDescription(
              name: 'metadata',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['analytics'] as _i4.AnalyticsEndpoint).logAction(
            session,
            params['action'],
            params['metadata'],
          ),
        ),
        'getAnalytics': _i1.MethodConnector(
          name: 'getAnalytics',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['analytics'] as _i4.AnalyticsEndpoint)
                  .getAnalytics(session),
        ),
      },
    );
    connectors['notification'] = _i1.EndpointConnector(
      name: 'notification',
      endpoint: endpoints['notification']!,
      methodConnectors: {
        'getNotifications': _i1.MethodConnector(
          name: 'getNotifications',
          params: {
            'isRead': _i1.ParameterDescription(
              name: 'isRead',
              type: _i1.getType<bool>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i5.NotificationEndpoint)
                  .getNotifications(
            session,
            isRead: params['isRead'],
          ),
        ),
        'markNotificationRead': _i1.MethodConnector(
          name: 'markNotificationRead',
          params: {
            'notificationId': _i1.ParameterDescription(
              name: 'notificationId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i5.NotificationEndpoint)
                  .markNotificationRead(
            session,
            params['notificationId'],
          ),
        ),
      },
    );
    connectors['question'] = _i1.EndpointConnector(
      name: 'question',
      endpoint: endpoints['question']!,
      methodConnectors: {
        'getSampleQuestions': _i1.MethodConnector(
          name: 'getSampleQuestions',
          params: {
            'count': _i1.ParameterDescription(
              name: 'count',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['question'] as _i6.QuestionEndpoint)
                  .getSampleQuestions(
            session,
            params['count'],
          ),
        )
      },
    );
    connectors['studyMaterial'] = _i1.EndpointConnector(
      name: 'studyMaterial',
      endpoint: endpoints['studyMaterial']!,
      methodConnectors: {
        'uploadMaterial': _i1.MethodConnector(
          name: 'uploadMaterial',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fileType': _i1.ParameterDescription(
              name: 'fileType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'fileData': _i1.ParameterDescription(
              name: 'fileData',
              type: _i1.getType<_i11.ByteData?>(),
              nullable: true,
            ),
            'fileUrl': _i1.ParameterDescription(
              name: 'fileUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i7.StudyMaterialEndpoint)
                  .uploadMaterial(
            session,
            params['title'],
            params['fileType'],
            params['fileData'],
            params['fileUrl'],
          ),
        ),
        'getMaterials': _i1.MethodConnector(
          name: 'getMaterials',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i7.StudyMaterialEndpoint)
                  .getMaterials(session),
        ),
        'getSampleMaterial': _i1.MethodConnector(
          name: 'getSampleMaterial',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i7.StudyMaterialEndpoint)
                  .getSampleMaterial(session),
        ),
        'deleteMaterial': _i1.MethodConnector(
          name: 'deleteMaterial',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i7.StudyMaterialEndpoint)
                  .deleteMaterial(
            session,
            params['materialId'],
          ),
        ),
        'updateMaterial': _i1.MethodConnector(
          name: 'updateMaterial',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'metadata': _i1.ParameterDescription(
              name: 'metadata',
              type: _i1.getType<Map<String, dynamic>?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i7.StudyMaterialEndpoint)
                  .updateMaterial(
            session,
            params['materialId'],
            params['title'],
            params['metadata'],
          ),
        ),
        'getProcessingStatus': _i1.MethodConnector(
          name: 'getProcessingStatus',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i7.StudyMaterialEndpoint)
                  .getProcessingStatus(
            session,
            params['materialId'],
          ),
        ),
        'getMaterialsByType': _i1.MethodConnector(
          name: 'getMaterialsByType',
          params: {
            'fileType': _i1.ParameterDescription(
              name: 'fileType',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i7.StudyMaterialEndpoint)
                  .getMaterialsByType(
            session,
            params['fileType'],
          ),
        ),
        'searchMaterials': _i1.MethodConnector(
          name: 'searchMaterials',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i7.StudyMaterialEndpoint)
                  .searchMaterials(
            session,
            params['query'],
          ),
        ),
        'getMaterialStats': _i1.MethodConnector(
          name: 'getMaterialStats',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i7.StudyMaterialEndpoint)
                  .getMaterialStats(session),
        ),
      },
    );
    connectors['subscription'] = _i1.EndpointConnector(
      name: 'subscription',
      endpoint: endpoints['subscription']!,
      methodConnectors: {
        'createSubscription': _i1.MethodConnector(
          name: 'createSubscription',
          params: {
            'gateway': _i1.ParameterDescription(
              name: 'gateway',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'paymentToken': _i1.ParameterDescription(
              name: 'paymentToken',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subscription'] as _i8.SubscriptionEndpoint)
                  .createSubscription(
            session,
            params['gateway'],
            params['paymentToken'],
          ),
        ),
        'cancelSubscription': _i1.MethodConnector(
          name: 'cancelSubscription',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subscription'] as _i8.SubscriptionEndpoint)
                  .cancelSubscription(session),
        ),
        'getSubscriptionStatus': _i1.MethodConnector(
          name: 'getSubscriptionStatus',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subscription'] as _i8.SubscriptionEndpoint)
                  .getSubscriptionStatus(session),
        ),
      },
    );
    connectors['summary'] = _i1.EndpointConnector(
      name: 'summary',
      endpoint: endpoints['summary']!,
      methodConnectors: {
        'getSummaries': _i1.MethodConnector(
          name: 'getSummaries',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['summary'] as _i9.SummaryEndpoint)
                  .getSummaries(session),
        )
      },
    );
    connectors['user'] = _i1.EndpointConnector(
      name: 'user',
      endpoint: endpoints['user']!,
      methodConnectors: {
        'getProfileBundle': _i1.MethodConnector(
          name: 'getProfileBundle',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i10.UserEndpoint)
                  .getProfileBundle(session),
        ),
        'updateProfile': _i1.MethodConnector(
          name: 'updateProfile',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i10.UserEndpoint).updateProfile(
            session,
            name: params['name'],
            role: params['role'],
          ),
        ),
        'getDashboardBundle': _i1.MethodConnector(
          name: 'getDashboardBundle',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i10.UserEndpoint)
                  .getDashboardBundle(session),
        ),
        'createStudyHistory': _i1.MethodConnector(
          name: 'createStudyHistory',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            )
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i10.UserEndpoint).createStudyHistory(
            session,
            params['userId'],
          ),
        ),
      },
    );
    modules['serverpod_auth'] = _i12.Endpoints()..initializeEndpoints(server);
  }
}
