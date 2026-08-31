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

import 'package:serverpod/serverpod.dart' as _i1;
import '../endpoints/academic_writer_endpoint.dart' as _i2;
import '../endpoints/ai_endpoint.dart' as _i3;
import '../endpoints/analytics_endpoint.dart' as _i4;
import '../endpoints/billing_webhook_endpoint.dart' as _i5;
import '../endpoints/collaboration_endpoint.dart' as _i6;
import '../endpoints/messaging_endpoint.dart' as _i7;
import '../endpoints/notification_endpoint.dart' as _i8;
import '../endpoints/operations_endpoint.dart' as _i9;
import '../endpoints/opportunity_endpoint.dart' as _i10;
import '../endpoints/question_endpoint.dart' as _i11;
import '../endpoints/study_material_endpoint.dart' as _i12;
import '../endpoints/subscription_endpoint.dart' as _i13;
import '../endpoints/summary_endpoint.dart' as _i14;
import '../endpoints/user_endpoint.dart' as _i15;
import 'dart:typed_data' as _i16;
import 'package:serverpod_auth_server/serverpod_auth_server.dart' as _i17;

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
      'billingWebhook': _i5.BillingWebhookEndpoint()
        ..initialize(
          server,
          'billingWebhook',
          null,
        ),
      'collaboration': _i6.CollaborationEndpoint()
        ..initialize(
          server,
          'collaboration',
          null,
        ),
      'messaging': _i7.MessagingEndpoint()
        ..initialize(
          server,
          'messaging',
          null,
        ),
      'notification': _i8.NotificationEndpoint()
        ..initialize(
          server,
          'notification',
          null,
        ),
      'operations': _i9.OperationsEndpoint()
        ..initialize(
          server,
          'operations',
          null,
        ),
      'opportunity': _i10.OpportunityEndpoint()
        ..initialize(
          server,
          'opportunity',
          null,
        ),
      'question': _i11.QuestionEndpoint()
        ..initialize(
          server,
          'question',
          null,
        ),
      'studyMaterial': _i12.StudyMaterialEndpoint()
        ..initialize(
          server,
          'studyMaterial',
          null,
        ),
      'subscription': _i13.SubscriptionEndpoint()
        ..initialize(
          server,
          'subscription',
          null,
        ),
      'summary': _i14.SummaryEndpoint()
        ..initialize(
          server,
          'summary',
          null,
        ),
      'user': _i15.UserEndpoint()
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
            ),
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
            ),
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
            ),
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
    connectors['billingWebhook'] = _i1.EndpointConnector(
      name: 'billingWebhook',
      endpoint: endpoints['billingWebhook']!,
      methodConnectors: {
        'handleWebhook': _i1.MethodConnector(
          name: 'handleWebhook',
          params: {
            'gateway': _i1.ParameterDescription(
              name: 'gateway',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'eventId': _i1.ParameterDescription(
              name: 'eventId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'eventType': _i1.ParameterDescription(
              name: 'eventType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'payload': _i1.ParameterDescription(
              name: 'payload',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'signature': _i1.ParameterDescription(
              name: 'signature',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['billingWebhook'] as _i5.BillingWebhookEndpoint)
                  .handleWebhook(
            session,
            params['gateway'],
            params['eventId'],
            params['eventType'],
            params['payload'],
            params['signature'],
          ),
        ),
      },
    );
    connectors['collaboration'] = _i1.EndpointConnector(
      name: 'collaboration',
      endpoint: endpoints['collaboration']!,
      methodConnectors: {
        'getMyReputation': _i1.MethodConnector(
          name: 'getMyReputation',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getMyReputation(session),
        ),
        'getRoomWhiteboard': _i1.MethodConnector(
          name: 'getRoomWhiteboard',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getRoomWhiteboard(
            session,
            params['roomId'],
          ),
        ),
        'saveRoomWhiteboard': _i1.MethodConnector(
          name: 'saveRoomWhiteboard',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'expectedVersion': _i1.ParameterDescription(
              name: 'expectedVersion',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'strokesJson': _i1.ParameterDescription(
              name: 'strokesJson',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .saveRoomWhiteboard(
            session,
            params['roomId'],
            params['expectedVersion'],
            params['strokesJson'],
          ),
        ),
        'getUserReputation': _i1.MethodConnector(
          name: 'getUserReputation',
          params: {
            'userId': _i1.ParameterDescription(
              name: 'userId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getUserReputation(
            session,
            params['userId'],
          ),
        ),
        'searchInstitutions': _i1.MethodConnector(
          name: 'searchInstitutions',
          params: {
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .searchInstitutions(
            session,
            params['query'],
            params['page'],
            params['limit'],
          ),
        ),
        'submitInstitution': _i1.MethodConnector(
          name: 'submitInstitution',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'country': _i1.ParameterDescription(
              name: 'country',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'region': _i1.ParameterDescription(
              name: 'region',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'domains': _i1.ParameterDescription(
              name: 'domains',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'logoUrl': _i1.ParameterDescription(
              name: 'logoUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .submitInstitution(
            session,
            params['name'],
            params['country'],
            params['region'],
            params['domains'],
            params['logoUrl'],
          ),
        ),
        'reviewInstitution': _i1.MethodConnector(
          name: 'reviewInstitution',
          params: {
            'institutionId': _i1.ParameterDescription(
              name: 'institutionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'decision': _i1.ParameterDescription(
              name: 'decision',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .reviewInstitution(
            session,
            params['institutionId'],
            params['decision'],
          ),
        ),
        'getPendingInstitutionReviews': _i1.MethodConnector(
          name: 'getPendingInstitutionReviews',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getPendingInstitutionReviews(
            session,
            params['page'],
            params['limit'],
          ),
        ),
        'getMyMemberships': _i1.MethodConnector(
          name: 'getMyMemberships',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getMyMemberships(session),
        ),
        'getMyVerificationRequests': _i1.MethodConnector(
          name: 'getMyVerificationRequests',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getMyVerificationRequests(session),
        ),
        'getAcademicProfile': _i1.MethodConnector(
          name: 'getAcademicProfile',
          params: {
            'institutionId': _i1.ParameterDescription(
              name: 'institutionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getAcademicProfile(
            session,
            params['institutionId'],
          ),
        ),
        'upsertAcademicProfile': _i1.MethodConnector(
          name: 'upsertAcademicProfile',
          params: {
            'institutionId': _i1.ParameterDescription(
              name: 'institutionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'department': _i1.ParameterDescription(
              name: 'department',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'programme': _i1.ParameterDescription(
              name: 'programme',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'level': _i1.ParameterDescription(
              name: 'level',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'subjects': _i1.ParameterDescription(
              name: 'subjects',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'interests': _i1.ParameterDescription(
              name: 'interests',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'languages': _i1.ParameterDescription(
              name: 'languages',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'availability': _i1.ParameterDescription(
              name: 'availability',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .upsertAcademicProfile(
            session,
            params['institutionId'],
            params['department'],
            params['programme'],
            params['level'],
            params['subjects'],
            params['interests'],
            params['languages'],
            params['availability'],
          ),
        ),
        'createInstitutionInvite': _i1.MethodConnector(
          name: 'createInstitutionInvite',
          params: {
            'institutionId': _i1.ParameterDescription(
              name: 'institutionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'expiresInDays': _i1.ParameterDescription(
              name: 'expiresInDays',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'maxUses': _i1.ParameterDescription(
              name: 'maxUses',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createInstitutionInvite(
            session,
            params['institutionId'],
            params['expiresInDays'],
            params['maxUses'],
          ),
        ),
        'acceptInstitutionInvite': _i1.MethodConnector(
          name: 'acceptInstitutionInvite',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .acceptInstitutionInvite(
            session,
            params['token'],
          ),
        ),
        'getInstitutionMembers': _i1.MethodConnector(
          name: 'getInstitutionMembers',
          params: {
            'institutionId': _i1.ParameterDescription(
              name: 'institutionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getInstitutionMembers(
            session,
            params['institutionId'],
            params['page'],
            params['limit'],
          ),
        ),
        'getInstitutionVerificationRequests': _i1.MethodConnector(
          name: 'getInstitutionVerificationRequests',
          params: {
            'institutionId': _i1.ParameterDescription(
              name: 'institutionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getInstitutionVerificationRequests(
            session,
            params['institutionId'],
            params['page'],
            params['limit'],
          ),
        ),
        'updateInstitutionMember': _i1.MethodConnector(
          name: 'updateInstitutionMember',
          params: {
            'membershipId': _i1.ParameterDescription(
              name: 'membershipId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .updateInstitutionMember(
            session,
            params['membershipId'],
            params['role'],
            params['status'],
          ),
        ),
        'requestMembership': _i1.MethodConnector(
          name: 'requestMembership',
          params: {
            'institutionId': _i1.ParameterDescription(
              name: 'institutionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'verificationMethod': _i1.ParameterDescription(
              name: 'verificationMethod',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .requestMembership(
            session,
            params['institutionId'],
            params['verificationMethod'],
          ),
        ),
        'submitVerificationEvidence': _i1.MethodConnector(
          name: 'submitVerificationEvidence',
          params: {
            'membershipId': _i1.ParameterDescription(
              name: 'membershipId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'evidenceUrl': _i1.ParameterDescription(
              name: 'evidenceUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .submitVerificationEvidence(
            session,
            params['membershipId'],
            params['evidenceUrl'],
          ),
        ),
        'reviewMembership': _i1.MethodConnector(
          name: 'reviewMembership',
          params: {
            'membershipId': _i1.ParameterDescription(
              name: 'membershipId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'decision': _i1.ParameterDescription(
              name: 'decision',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .reviewMembership(
            session,
            params['membershipId'],
            params['decision'],
          ),
        ),
        'getRooms': _i1.MethodConnector(
          name: 'getRooms',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'institutionId': _i1.ParameterDescription(
              name: 'institutionId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'subject': _i1.ParameterDescription(
              name: 'subject',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getRooms(
            session,
            params['page'],
            params['limit'],
            params['institutionId'],
            params['subject'],
          ),
        ),
        'createRoom': _i1.MethodConnector(
          name: 'createRoom',
          params: {
            'institutionId': _i1.ParameterDescription(
              name: 'institutionId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'subject': _i1.ParameterDescription(
              name: 'subject',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'visibility': _i1.ParameterDescription(
              name: 'visibility',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createRoom(
            session,
            params['institutionId'],
            params['title'],
            params['description'],
            params['subject'],
            params['visibility'],
          ),
        ),
        'joinRoom': _i1.MethodConnector(
          name: 'joinRoom',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .joinRoom(
            session,
            params['roomId'],
          ),
        ),
        'getMyRoomMembership': _i1.MethodConnector(
          name: 'getMyRoomMembership',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getMyRoomMembership(
            session,
            params['roomId'],
          ),
        ),
        'getRoomPosts': _i1.MethodConnector(
          name: 'getRoomPosts',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getRoomPosts(
            session,
            params['roomId'],
            params['page'],
            params['limit'],
          ),
        ),
        'createPost': _i1.MethodConnector(
          name: 'createPost',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createPost(
            session,
            params['roomId'],
            params['body'],
          ),
        ),
        'getChallenges': _i1.MethodConnector(
          name: 'getChallenges',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getChallenges(
            session,
            params['page'],
            params['limit'],
            params['roomId'],
          ),
        ),
        'createChallenge': _i1.MethodConnector(
          name: 'createChallenge',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'problemStatement': _i1.ParameterDescription(
              name: 'problemStatement',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'field': _i1.ParameterDescription(
              name: 'field',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'tags': _i1.ParameterDescription(
              name: 'tags',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'difficulty': _i1.ParameterDescription(
              name: 'difficulty',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createChallenge(
            session,
            params['roomId'],
            params['title'],
            params['problemStatement'],
            params['field'],
            params['tags'],
            params['difficulty'],
          ),
        ),
        'getRoomResources': _i1.MethodConnector(
          name: 'getRoomResources',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getRoomResources(
            session,
            params['roomId'],
            params['page'],
            params['limit'],
          ),
        ),
        'addRoomResource': _i1.MethodConnector(
          name: 'addRoomResource',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'resourceType': _i1.ParameterDescription(
              name: 'resourceType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'uri': _i1.ParameterDescription(
              name: 'uri',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'content': _i1.ParameterDescription(
              name: 'content',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'citation': _i1.ParameterDescription(
              name: 'citation',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .addRoomResource(
            session,
            params['roomId'],
            params['resourceType'],
            params['title'],
            params['uri'],
            params['content'],
            params['citation'],
          ),
        ),
        'uploadRoomResource': _i1.MethodConnector(
          name: 'uploadRoomResource',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'resourceType': _i1.ParameterDescription(
              name: 'resourceType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
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
              type: _i1.getType<_i16.ByteData>(),
              nullable: false,
            ),
            'citation': _i1.ParameterDescription(
              name: 'citation',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .uploadRoomResource(
            session,
            params['roomId'],
            params['resourceType'],
            params['title'],
            params['fileType'],
            params['fileData'],
            params['citation'],
          ),
        ),
        'getRoomResourceChunks': _i1.MethodConnector(
          name: 'getRoomResourceChunks',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'resourceId': _i1.ParameterDescription(
              name: 'resourceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getRoomResourceChunks(
            session,
            params['roomId'],
            params['resourceId'],
            params['page'],
            params['limit'],
          ),
        ),
        'indexRoomResourceEmbeddings': _i1.MethodConnector(
          name: 'indexRoomResourceEmbeddings',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'resourceId': _i1.ParameterDescription(
              name: 'resourceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .indexRoomResourceEmbeddings(
            session,
            params['roomId'],
            params['resourceId'],
          ),
        ),
        'searchRoomKnowledge': _i1.MethodConnector(
          name: 'searchRoomKnowledge',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'query': _i1.ParameterDescription(
              name: 'query',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .searchRoomKnowledge(
            session,
            params['roomId'],
            params['query'],
            params['limit'],
          ),
        ),
        'getChallengeTeams': _i1.MethodConnector(
          name: 'getChallengeTeams',
          params: {
            'challengeId': _i1.ParameterDescription(
              name: 'challengeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getChallengeTeams(
            session,
            params['challengeId'],
          ),
        ),
        'getChallengeTeamMembers': _i1.MethodConnector(
          name: 'getChallengeTeamMembers',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getChallengeTeamMembers(
            session,
            params['teamId'],
            params['page'],
            params['limit'],
          ),
        ),
        'createChallengeTeam': _i1.MethodConnector(
          name: 'createChallengeTeam',
          params: {
            'challengeId': _i1.ParameterDescription(
              name: 'challengeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createChallengeTeam(
            session,
            params['challengeId'],
            params['name'],
            params['description'],
          ),
        ),
        'joinChallengeTeam': _i1.MethodConnector(
          name: 'joinChallengeTeam',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .joinChallengeTeam(
            session,
            params['teamId'],
          ),
        ),
        'createChallengeTeamInvite': _i1.MethodConnector(
          name: 'createChallengeTeamInvite',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'inviteeId': _i1.ParameterDescription(
              name: 'inviteeId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'expiresInDays': _i1.ParameterDescription(
              name: 'expiresInDays',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createChallengeTeamInvite(
            session,
            params['teamId'],
            params['inviteeId'],
            params['expiresInDays'],
          ),
        ),
        'acceptChallengeTeamInvite': _i1.MethodConnector(
          name: 'acceptChallengeTeamInvite',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .acceptChallengeTeamInvite(
            session,
            params['token'],
          ),
        ),
        'getTeamMilestones': _i1.MethodConnector(
          name: 'getTeamMilestones',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getTeamMilestones(
            session,
            params['teamId'],
            params['page'],
            params['limit'],
          ),
        ),
        'createMilestone': _i1.MethodConnector(
          name: 'createMilestone',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'dueAt': _i1.ParameterDescription(
              name: 'dueAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createMilestone(
            session,
            params['teamId'],
            params['title'],
            params['description'],
            params['dueAt'],
          ),
        ),
        'updateChallengeMilestone': _i1.MethodConnector(
          name: 'updateChallengeMilestone',
          params: {
            'milestoneId': _i1.ParameterDescription(
              name: 'milestoneId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'dueAt': _i1.ParameterDescription(
              name: 'dueAt',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .updateChallengeMilestone(
            session,
            params['milestoneId'],
            params['title'],
            params['description'],
            params['status'],
            params['dueAt'],
          ),
        ),
        'updateChallengeTeamMember': _i1.MethodConnector(
          name: 'updateChallengeTeamMember',
          params: {
            'membershipId': _i1.ParameterDescription(
              name: 'membershipId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'role': _i1.ParameterDescription(
              name: 'role',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .updateChallengeTeamMember(
            session,
            params['membershipId'],
            params['role'],
            params['status'],
          ),
        ),
        'getTeamUpdates': _i1.MethodConnector(
          name: 'getTeamUpdates',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getTeamUpdates(
            session,
            params['teamId'],
            params['page'],
            params['limit'],
          ),
        ),
        'postChallengeUpdate': _i1.MethodConnector(
          name: 'postChallengeUpdate',
          params: {
            'teamId': _i1.ParameterDescription(
              name: 'teamId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .postChallengeUpdate(
            session,
            params['teamId'],
            params['body'],
          ),
        ),
        'getPostComments': _i1.MethodConnector(
          name: 'getPostComments',
          params: {
            'postId': _i1.ParameterDescription(
              name: 'postId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getPostComments(
            session,
            params['postId'],
            params['page'],
            params['limit'],
          ),
        ),
        'createComment': _i1.MethodConnector(
          name: 'createComment',
          params: {
            'postId': _i1.ParameterDescription(
              name: 'postId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'parentCommentId': _i1.ParameterDescription(
              name: 'parentCommentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createComment(
            session,
            params['postId'],
            params['body'],
            params['parentCommentId'],
          ),
        ),
        'acceptPostComment': _i1.MethodConnector(
          name: 'acceptPostComment',
          params: {
            'postId': _i1.ParameterDescription(
              name: 'postId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'commentId': _i1.ParameterDescription(
              name: 'commentId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .acceptPostComment(
            session,
            params['postId'],
            params['commentId'],
          ),
        ),
        'setPostReaction': _i1.MethodConnector(
          name: 'setPostReaction',
          params: {
            'postId': _i1.ParameterDescription(
              name: 'postId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reaction': _i1.ParameterDescription(
              name: 'reaction',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .setPostReaction(
            session,
            params['postId'],
            params['reaction'],
          ),
        ),
        'getRoomChatMessages': _i1.MethodConnector(
          name: 'getRoomChatMessages',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getRoomChatMessages(
            session,
            params['roomId'],
            params['page'],
            params['limit'],
          ),
        ),
        'createRoomChatMessage': _i1.MethodConnector(
          name: 'createRoomChatMessage',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createRoomChatMessage(
            session,
            params['roomId'],
            params['body'],
          ),
        ),
        'getRoomAiAnswers': _i1.MethodConnector(
          name: 'getRoomAiAnswers',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getRoomAiAnswers(
            session,
            params['roomId'],
            params['page'],
            params['limit'],
          ),
        ),
        'askRoom': _i1.MethodConnector(
          name: 'askRoom',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'question': _i1.ParameterDescription(
              name: 'question',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint).askRoom(
            session,
            params['roomId'],
            params['question'],
          ),
        ),
        'updateRoomPresence': _i1.MethodConnector(
          name: 'updateRoomPresence',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'state': _i1.ParameterDescription(
              name: 'state',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .updateRoomPresence(
            session,
            params['roomId'],
            params['state'],
          ),
        ),
        'getRoomPresence': _i1.MethodConnector(
          name: 'getRoomPresence',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getRoomPresence(
            session,
            params['roomId'],
          ),
        ),
        'getRoomStudySessions': _i1.MethodConnector(
          name: 'getRoomStudySessions',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getRoomStudySessions(
            session,
            params['roomId'],
            params['page'],
            params['limit'],
          ),
        ),
        'createStudySession': _i1.MethodConnector(
          name: 'createStudySession',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'description': _i1.ParameterDescription(
              name: 'description',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'startsAt': _i1.ParameterDescription(
              name: 'startsAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'endsAt': _i1.ParameterDescription(
              name: 'endsAt',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'meetingUrl': _i1.ParameterDescription(
              name: 'meetingUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createStudySession(
            session,
            params['roomId'],
            params['title'],
            params['description'],
            params['startsAt'],
            params['endsAt'],
            params['meetingUrl'],
          ),
        ),
        'joinStudySession': _i1.MethodConnector(
          name: 'joinStudySession',
          params: {
            'sessionId': _i1.ParameterDescription(
              name: 'sessionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .joinStudySession(
            session,
            params['sessionId'],
          ),
        ),
        'reportContent': _i1.MethodConnector(
          name: 'reportContent',
          params: {
            'contentType': _i1.ParameterDescription(
              name: 'contentType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'contentId': _i1.ParameterDescription(
              name: 'contentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'details': _i1.ParameterDescription(
              name: 'details',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .reportContent(
            session,
            params['contentType'],
            params['contentId'],
            params['reason'],
            params['details'],
          ),
        ),
        'getOpenReports': _i1.MethodConnector(
          name: 'getOpenReports',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getOpenReports(
            session,
            page: params['page'],
            limit: params['limit'],
          ),
        ),
        'getMyContentReports': _i1.MethodConnector(
          name: 'getMyContentReports',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getMyContentReports(
            session,
            page: params['page'],
            limit: params['limit'],
          ),
        ),
        'getAuditEvents': _i1.MethodConnector(
          name: 'getAuditEvents',
          params: {
            'targetType': _i1.ParameterDescription(
              name: 'targetType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'targetId': _i1.ParameterDescription(
              name: 'targetId',
              type: _i1.getType<int?>(),
              nullable: true,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getAuditEvents(
            session,
            targetType: params['targetType'],
            targetId: params['targetId'],
            page: params['page'],
            limit: params['limit'],
          ),
        ),
        'getInstitutionAuditEvents': _i1.MethodConnector(
          name: 'getInstitutionAuditEvents',
          params: {
            'institutionId': _i1.ParameterDescription(
              name: 'institutionId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getInstitutionAuditEvents(
            session,
            params['institutionId'],
            page: params['page'],
            limit: params['limit'],
          ),
        ),
        'submitModerationAppeal': _i1.MethodConnector(
          name: 'submitModerationAppeal',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'reason': _i1.ParameterDescription(
              name: 'reason',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .submitModerationAppeal(
            session,
            params['reportId'],
            params['reason'],
          ),
        ),
        'getMyModerationAppeals': _i1.MethodConnector(
          name: 'getMyModerationAppeals',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getMyModerationAppeals(
            session,
            params['page'],
            params['limit'],
          ),
        ),
        'getPendingModerationAppeals': _i1.MethodConnector(
          name: 'getPendingModerationAppeals',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getPendingModerationAppeals(
            session,
            page: params['page'],
            limit: params['limit'],
          ),
        ),
        'reviewModerationAppeal': _i1.MethodConnector(
          name: 'reviewModerationAppeal',
          params: {
            'appealId': _i1.ParameterDescription(
              name: 'appealId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'decision': _i1.ParameterDescription(
              name: 'decision',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .reviewModerationAppeal(
            session,
            params['appealId'],
            params['decision'],
            params['notes'],
          ),
        ),
        'resolveReport': _i1.MethodConnector(
          name: 'resolveReport',
          params: {
            'reportId': _i1.ParameterDescription(
              name: 'reportId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'action': _i1.ParameterDescription(
              name: 'action',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .resolveReport(
            session,
            params['reportId'],
            params['action'],
            params['notes'],
          ),
        ),
        'getRoomDocuments': _i1.MethodConnector(
          name: 'getRoomDocuments',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .getRoomDocuments(
            session,
            params['roomId'],
            params['page'],
            params['limit'],
          ),
        ),
        'createDocument': _i1.MethodConnector(
          name: 'createDocument',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .createDocument(
            session,
            params['roomId'],
            params['title'],
            params['body'],
          ),
        ),
        'updateDocument': _i1.MethodConnector(
          name: 'updateDocument',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'expectedVersion': _i1.ParameterDescription(
              name: 'expectedVersion',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .updateDocument(
            session,
            params['documentId'],
            params['title'],
            params['body'],
            params['expectedVersion'],
          ),
        ),
        'roomPostStream': _i1.MethodStreamConnector(
          name: 'roomPostStream',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .roomPostStream(
            session,
            params['roomId'],
          ),
        ),
        'roomChatStream': _i1.MethodStreamConnector(
          name: 'roomChatStream',
          params: {
            'roomId': _i1.ParameterDescription(
              name: 'roomId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .roomChatStream(
            session,
            params['roomId'],
          ),
        ),
        'documentStream': _i1.MethodStreamConnector(
          name: 'documentStream',
          params: {
            'documentId': _i1.ParameterDescription(
              name: 'documentId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['collaboration'] as _i6.CollaborationEndpoint)
                  .documentStream(
            session,
            params['documentId'],
          ),
        ),
      },
    );
    connectors['messaging'] = _i1.EndpointConnector(
      name: 'messaging',
      endpoint: endpoints['messaging']!,
      methodConnectors: {
        'getMyPrivacySettings': _i1.MethodConnector(
          name: 'getMyPrivacySettings',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .getMyPrivacySettings(session),
        ),
        'updateMyPrivacySettings': _i1.MethodConnector(
          name: 'updateMyPrivacySettings',
          params: {
            'isMinor': _i1.ParameterDescription(
              name: 'isMinor',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
            'dateOfBirth': _i1.ParameterDescription(
              name: 'dateOfBirth',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
            'guardianConsent': _i1.ParameterDescription(
              name: 'guardianConsent',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
            'allowUnknownDirectMessages': _i1.ParameterDescription(
              name: 'allowUnknownDirectMessages',
              type: _i1.getType<bool?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .updateMyPrivacySettings(
            session,
            isMinor: params['isMinor'],
            dateOfBirth: params['dateOfBirth'],
            guardianConsent: params['guardianConsent'],
            allowUnknownDirectMessages: params['allowUnknownDirectMessages'],
          ),
        ),
        'setSafetyRelationship': _i1.MethodConnector(
          name: 'setSafetyRelationship',
          params: {
            'targetUserId': _i1.ParameterDescription(
              name: 'targetUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'relationshipType': _i1.ParameterDescription(
              name: 'relationshipType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .setSafetyRelationship(
            session,
            params['targetUserId'],
            params['relationshipType'],
          ),
        ),
        'removeSafetyRelationship': _i1.MethodConnector(
          name: 'removeSafetyRelationship',
          params: {
            'targetUserId': _i1.ParameterDescription(
              name: 'targetUserId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'relationshipType': _i1.ParameterDescription(
              name: 'relationshipType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .removeSafetyRelationship(
            session,
            params['targetUserId'],
            params['relationshipType'],
          ),
        ),
        'getMySafetyRelationships': _i1.MethodConnector(
          name: 'getMySafetyRelationships',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .getMySafetyRelationships(
            session,
            params['page'],
            params['limit'],
          ),
        ),
        'createConversation': _i1.MethodConnector(
          name: 'createConversation',
          params: {
            'participantIds': _i1.ParameterDescription(
              name: 'participantIds',
              type: _i1.getType<List<int>>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .createConversation(
            session,
            params['participantIds'],
            params['title'],
          ),
        ),
        'getMyConversations': _i1.MethodConnector(
          name: 'getMyConversations',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .getMyConversations(session),
        ),
        'getConversationMessages': _i1.MethodConnector(
          name: 'getConversationMessages',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .getConversationMessages(
            session,
            params['conversationId'],
            params['page'],
            params['limit'],
          ),
        ),
        'markConversationRead': _i1.MethodConnector(
          name: 'markConversationRead',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'messageId': _i1.ParameterDescription(
              name: 'messageId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .markConversationRead(
            session,
            params['conversationId'],
            params['messageId'],
          ),
        ),
        'getConversationReadReceipts': _i1.MethodConnector(
          name: 'getConversationReadReceipts',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .getConversationReadReceipts(
            session,
            params['conversationId'],
          ),
        ),
        'sendMessage': _i1.MethodConnector(
          name: 'sendMessage',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'body': _i1.ParameterDescription(
              name: 'body',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['messaging'] as _i7.MessagingEndpoint).sendMessage(
            session,
            params['conversationId'],
            params['body'],
          ),
        ),
        'conversationStream': _i1.MethodStreamConnector(
          name: 'conversationStream',
          params: {
            'conversationId': _i1.ParameterDescription(
              name: 'conversationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          streamParams: {},
          returnType: _i1.MethodStreamReturnType.streamType,
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
            Map<String, Stream> streamParams,
          ) =>
              (endpoints['messaging'] as _i7.MessagingEndpoint)
                  .conversationStream(
            session,
            params['conversationId'],
          ),
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
            ),
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i8.NotificationEndpoint)
                  .getNotifications(
            session,
            isRead: params['isRead'],
            page: params['page'],
            limit: params['limit'],
          ),
        ),
        'markNotificationRead': _i1.MethodConnector(
          name: 'markNotificationRead',
          params: {
            'notificationId': _i1.ParameterDescription(
              name: 'notificationId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i8.NotificationEndpoint)
                  .markNotificationRead(
            session,
            params['notificationId'],
          ),
        ),
        'markAllNotificationsRead': _i1.MethodConnector(
          name: 'markAllNotificationsRead',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i8.NotificationEndpoint)
                  .markAllNotificationsRead(session),
        ),
        'registerPushDevice': _i1.MethodConnector(
          name: 'registerPushDevice',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'platform': _i1.ParameterDescription(
              name: 'platform',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i8.NotificationEndpoint)
                  .registerPushDevice(
            session,
            params['token'],
            params['platform'],
          ),
        ),
        'unregisterPushDevice': _i1.MethodConnector(
          name: 'unregisterPushDevice',
          params: {
            'token': _i1.ParameterDescription(
              name: 'token',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['notification'] as _i8.NotificationEndpoint)
                  .unregisterPushDevice(
            session,
            params['token'],
          ),
        ),
      },
    );
    connectors['operations'] = _i1.EndpointConnector(
      name: 'operations',
      endpoint: endpoints['operations']!,
      methodConnectors: {
        'getQueueHealth': _i1.MethodConnector(
          name: 'getQueueHealth',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['operations'] as _i9.OperationsEndpoint)
                  .getQueueHealth(session),
        ),
        'getSchedulerHealth': _i1.MethodConnector(
          name: 'getSchedulerHealth',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['operations'] as _i9.OperationsEndpoint)
                  .getSchedulerHealth(session),
        ),
      },
    );
    connectors['opportunity'] = _i1.EndpointConnector(
      name: 'opportunity',
      endpoint: endpoints['opportunity']!,
      methodConnectors: {
        'registerOpportunitySource': _i1.MethodConnector(
          name: 'registerOpportunitySource',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'provider': _i1.ParameterDescription(
              name: 'provider',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'feedUrl': _i1.ParameterDescription(
              name: 'feedUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .registerOpportunitySource(
            session,
            params['name'],
            params['provider'],
            params['feedUrl'],
          ),
        ),
        'ingestOpportunity': _i1.MethodConnector(
          name: 'ingestOpportunity',
          params: {
            'sourceId': _i1.ParameterDescription(
              name: 'sourceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'externalId': _i1.ParameterDescription(
              name: 'externalId',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'opportunityType': _i1.ParameterDescription(
              name: 'opportunityType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'provider': _i1.ParameterDescription(
              name: 'provider',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'country': _i1.ParameterDescription(
              name: 'country',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'eligibilityRegion': _i1.ParameterDescription(
              name: 'eligibilityRegion',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'field': _i1.ParameterDescription(
              name: 'field',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'educationLevel': _i1.ParameterDescription(
              name: 'educationLevel',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'deadline': _i1.ParameterDescription(
              name: 'deadline',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'fundingDetails': _i1.ParameterDescription(
              name: 'fundingDetails',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'officialUrl': _i1.ParameterDescription(
              name: 'officialUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .ingestOpportunity(
            session,
            params['sourceId'],
            params['externalId'],
            params['title'],
            params['opportunityType'],
            params['provider'],
            params['country'],
            params['eligibilityRegion'],
            params['field'],
            params['educationLevel'],
            params['deadline'],
            params['fundingDetails'],
            params['officialUrl'],
          ),
        ),
        'syncOpportunitySource': _i1.MethodConnector(
          name: 'syncOpportunitySource',
          params: {
            'sourceId': _i1.ParameterDescription(
              name: 'sourceId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .syncOpportunitySource(
            session,
            params['sourceId'],
          ),
        ),
        'getOpportunities': _i1.MethodConnector(
          name: 'getOpportunities',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'country': _i1.ParameterDescription(
              name: 'country',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'field': _i1.ParameterDescription(
              name: 'field',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'educationLevel': _i1.ParameterDescription(
              name: 'educationLevel',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'opportunityType': _i1.ParameterDescription(
              name: 'opportunityType',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'deadlineBefore': _i1.ParameterDescription(
              name: 'deadlineBefore',
              type: _i1.getType<DateTime?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .getOpportunities(
            session,
            params['page'],
            params['limit'],
            params['country'],
            params['field'],
            params['educationLevel'],
            params['opportunityType'],
            params['deadlineBefore'],
          ),
        ),
        'submitOpportunity': _i1.MethodConnector(
          name: 'submitOpportunity',
          params: {
            'title': _i1.ParameterDescription(
              name: 'title',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'opportunityType': _i1.ParameterDescription(
              name: 'opportunityType',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'provider': _i1.ParameterDescription(
              name: 'provider',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'country': _i1.ParameterDescription(
              name: 'country',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'eligibilityRegion': _i1.ParameterDescription(
              name: 'eligibilityRegion',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'field': _i1.ParameterDescription(
              name: 'field',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'educationLevel': _i1.ParameterDescription(
              name: 'educationLevel',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'deadline': _i1.ParameterDescription(
              name: 'deadline',
              type: _i1.getType<DateTime>(),
              nullable: false,
            ),
            'fundingDetails': _i1.ParameterDescription(
              name: 'fundingDetails',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'officialUrl': _i1.ParameterDescription(
              name: 'officialUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .submitOpportunity(
            session,
            params['title'],
            params['opportunityType'],
            params['provider'],
            params['country'],
            params['eligibilityRegion'],
            params['field'],
            params['educationLevel'],
            params['deadline'],
            params['fundingDetails'],
            params['officialUrl'],
          ),
        ),
        'saveOpportunity': _i1.MethodConnector(
          name: 'saveOpportunity',
          params: {
            'opportunityId': _i1.ParameterDescription(
              name: 'opportunityId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'alertEnabled': _i1.ParameterDescription(
              name: 'alertEnabled',
              type: _i1.getType<bool>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .saveOpportunity(
            session,
            params['opportunityId'],
            params['alertEnabled'],
          ),
        ),
        'getSavedOpportunities': _i1.MethodConnector(
          name: 'getSavedOpportunities',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .getSavedOpportunities(
            session,
            params['page'],
            params['limit'],
          ),
        ),
        'reviewOpportunity': _i1.MethodConnector(
          name: 'reviewOpportunity',
          params: {
            'opportunityId': _i1.ParameterDescription(
              name: 'opportunityId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'verificationStatus': _i1.ParameterDescription(
              name: 'verificationStatus',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .reviewOpportunity(
            session,
            params['opportunityId'],
            params['verificationStatus'],
          ),
        ),
        'getPendingOpportunityReviews': _i1.MethodConnector(
          name: 'getPendingOpportunityReviews',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .getPendingOpportunityReviews(
            session,
            page: params['page'],
            limit: params['limit'],
          ),
        ),
        'createOpportunityAlert': _i1.MethodConnector(
          name: 'createOpportunityAlert',
          params: {
            'country': _i1.ParameterDescription(
              name: 'country',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'field': _i1.ParameterDescription(
              name: 'field',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'educationLevel': _i1.ParameterDescription(
              name: 'educationLevel',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'opportunityTypes': _i1.ParameterDescription(
              name: 'opportunityTypes',
              type: _i1.getType<List<String>>(),
              nullable: false,
            ),
            'deadlineWithinDays': _i1.ParameterDescription(
              name: 'deadlineWithinDays',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .createOpportunityAlert(
            session,
            params['country'],
            params['field'],
            params['educationLevel'],
            params['opportunityTypes'],
            params['deadlineWithinDays'],
          ),
        ),
        'getOpportunityAlerts': _i1.MethodConnector(
          name: 'getOpportunityAlerts',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .getOpportunityAlerts(session),
        ),
        'deactivateOpportunityAlert': _i1.MethodConnector(
          name: 'deactivateOpportunityAlert',
          params: {
            'alertId': _i1.ParameterDescription(
              name: 'alertId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .deactivateOpportunityAlert(
            session,
            params['alertId'],
          ),
        ),
        'getApplicationTrackers': _i1.MethodConnector(
          name: 'getApplicationTrackers',
          params: {
            'page': _i1.ParameterDescription(
              name: 'page',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .getApplicationTrackers(
            session,
            params['page'],
            params['limit'],
          ),
        ),
        'upsertApplicationTracker': _i1.MethodConnector(
          name: 'upsertApplicationTracker',
          params: {
            'opportunityId': _i1.ParameterDescription(
              name: 'opportunityId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'status': _i1.ParameterDescription(
              name: 'status',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'notes': _i1.ParameterDescription(
              name: 'notes',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
            'applicationUrl': _i1.ParameterDescription(
              name: 'applicationUrl',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['opportunity'] as _i10.OpportunityEndpoint)
                  .upsertApplicationTracker(
            session,
            params['opportunityId'],
            params['status'],
            params['notes'],
            params['applicationUrl'],
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
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['question'] as _i11.QuestionEndpoint)
                  .getSampleQuestions(
            session,
            params['count'],
          ),
        ),
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
              type: _i1.getType<_i16.ByteData?>(),
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
              (endpoints['studyMaterial'] as _i12.StudyMaterialEndpoint)
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
              (endpoints['studyMaterial'] as _i12.StudyMaterialEndpoint)
                  .getMaterials(session),
        ),
        'getSampleMaterial': _i1.MethodConnector(
          name: 'getSampleMaterial',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i12.StudyMaterialEndpoint)
                  .getSampleMaterial(session),
        ),
        'deleteMaterial': _i1.MethodConnector(
          name: 'deleteMaterial',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i12.StudyMaterialEndpoint)
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
              (endpoints['studyMaterial'] as _i12.StudyMaterialEndpoint)
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
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i12.StudyMaterialEndpoint)
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
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i12.StudyMaterialEndpoint)
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
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i12.StudyMaterialEndpoint)
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
              (endpoints['studyMaterial'] as _i12.StudyMaterialEndpoint)
                  .getMaterialStats(session),
        ),
        'retryFileProcessing': _i1.MethodConnector(
          name: 'retryFileProcessing',
          params: {
            'materialId': _i1.ParameterDescription(
              name: 'materialId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['studyMaterial'] as _i12.StudyMaterialEndpoint)
                  .retryFileProcessing(
            session,
            params['materialId'],
          ),
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
            'idempotencyKey': _i1.ParameterDescription(
              name: 'idempotencyKey',
              type: _i1.getType<String?>(),
              nullable: true,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subscription'] as _i13.SubscriptionEndpoint)
                  .createSubscription(
            session,
            params['gateway'],
            params['paymentToken'],
            params['idempotencyKey'],
          ),
        ),
        'cancelSubscription': _i1.MethodConnector(
          name: 'cancelSubscription',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subscription'] as _i13.SubscriptionEndpoint)
                  .cancelSubscription(session),
        ),
        'getSubscriptionStatus': _i1.MethodConnector(
          name: 'getSubscriptionStatus',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['subscription'] as _i13.SubscriptionEndpoint)
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
              (endpoints['summary'] as _i14.SummaryEndpoint)
                  .getSummaries(session),
        ),
        'deleteSummary': _i1.MethodConnector(
          name: 'deleteSummary',
          params: {
            'summaryId': _i1.ParameterDescription(
              name: 'summaryId',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['summary'] as _i14.SummaryEndpoint).deleteSummary(
            session,
            params['summaryId'],
          ),
        ),
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
              (endpoints['user'] as _i15.UserEndpoint)
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
          },
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i15.UserEndpoint).updateProfile(
            session,
            name: params['name'],
          ),
        ),
        'getDashboardBundle': _i1.MethodConnector(
          name: 'getDashboardBundle',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i15.UserEndpoint)
                  .getDashboardBundle(session),
        ),
        'createStudyHistory': _i1.MethodConnector(
          name: 'createStudyHistory',
          params: {},
          call: (
            _i1.Session session,
            Map<String, dynamic> params,
          ) async =>
              (endpoints['user'] as _i15.UserEndpoint)
                  .createStudyHistory(session),
        ),
      },
    );
    modules['serverpod_auth'] = _i17.Endpoints()..initializeEndpoints(server);
  }
}
