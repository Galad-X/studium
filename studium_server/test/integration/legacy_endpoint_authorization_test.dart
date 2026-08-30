import 'package:test/test.dart';

import 'test_tools/serverpod_test_tools.dart';

void main() {
  withServerpod('Legacy endpoint authorization', (sessionBuilder, endpoints) {
    test('requires an authenticated session across legacy user workflows',
        () async {
      await expectLater(
        endpoints.user.getProfileBundle(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.user.getDashboardBundle(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.summary.getSummaries(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.summary.deleteSummary(sessionBuilder, 1),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.analytics.logAction(sessionBuilder, 'open', null),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.analytics.getAnalytics(sessionBuilder),
        throwsA(isA<Exception>()),
      );
    });

    test('requires an authenticated session across material and writing APIs',
        () async {
      await expectLater(
        endpoints.studyMaterial.getMaterials(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.studyMaterial.getSampleMaterial(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.studyMaterial.getMaterialStats(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.studyMaterial.getProcessingStatus(sessionBuilder, 1),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.academicWriting.getWritings(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.academicWriting.deleteWriting(sessionBuilder, 1),
        throwsA(isA<Exception>()),
      );
    });

    test('requires an authenticated session across premium and billing APIs',
        () async {
      await expectLater(
        endpoints.ai.generateSampleSummary(sessionBuilder, 100),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.subscription.getSubscriptionStatus(sessionBuilder),
        throwsA(isA<Exception>()),
      );
      await expectLater(
        endpoints.subscription.cancelSubscription(sessionBuilder),
        throwsA(isA<Exception>()),
      );
    });
  });
}
