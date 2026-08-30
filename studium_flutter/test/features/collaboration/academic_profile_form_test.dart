import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:studium_flutter/features/collaboration/widgets/academic_profile_form.dart';

void main() {
  testWidgets('collects and normalizes academic profile fields',
      (tester) async {
    AcademicProfileDraft? saved;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AcademicProfileForm(
            onSave: (draft) async => saved = draft,
          ),
        ),
      ),
    );

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 'Engineering');
    await tester.enterText(fields.at(3), 'Algorithms, Algorithms, Research');
    await tester.enterText(fields.at(5), 'English, French');
    await tester.tap(find.text('Save profile'));
    await tester.pumpAndSettle();

    expect(saved?.department, 'Engineering');
    expect(saved?.subjects, ['Algorithms', 'Research']);
    expect(saved?.languages, ['English', 'French']);
  });
}
