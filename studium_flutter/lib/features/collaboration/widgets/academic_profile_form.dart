import 'package:flutter/material.dart';
import 'package:studium_client/studium_client.dart';

/// Reusable editor for the academic identity fields shared by rooms and
/// collaboration discovery.
class AcademicProfileForm extends StatefulWidget {
  const AcademicProfileForm({
    super.key,
    this.profile,
    required this.onSave,
  });

  final AcademicProfile? profile;
  final Future<void> Function(AcademicProfileDraft draft) onSave;

  @override
  State<AcademicProfileForm> createState() => _AcademicProfileFormState();
}

class AcademicProfileDraft {
  const AcademicProfileDraft({
    this.department,
    this.programme,
    this.level,
    this.subjects = const [],
    this.interests = const [],
    this.languages = const [],
    this.availability,
  });

  final String? department;
  final String? programme;
  final String? level;
  final List<String> subjects;
  final List<String> interests;
  final List<String> languages;
  final String? availability;
}

class _AcademicProfileFormState extends State<AcademicProfileForm> {
  late final TextEditingController _department;
  late final TextEditingController _programme;
  late final TextEditingController _level;
  late final TextEditingController _subjects;
  late final TextEditingController _interests;
  late final TextEditingController _languages;
  late final TextEditingController _availability;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final profile = widget.profile;
    _department = TextEditingController(text: profile?.department ?? '');
    _programme = TextEditingController(text: profile?.programme ?? '');
    _level = TextEditingController(text: profile?.level ?? '');
    _subjects = TextEditingController(text: profile?.subjects.join(', '));
    _interests = TextEditingController(text: profile?.interests.join(', '));
    _languages = TextEditingController(text: profile?.languages.join(', '));
    _availability = TextEditingController(text: profile?.availability ?? '');
  }

  @override
  void dispose() {
    for (final controller in [
      _department,
      _programme,
      _level,
      _subjects,
      _interests,
      _languages,
      _availability,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Academic profile',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 6),
            const Text(
              'This helps you find relevant rooms, peers, and challenges. '
              'Use commas to separate subjects, interests, and languages.',
            ),
            const SizedBox(height: 18),
            TextField(
              controller: _department,
              decoration: const InputDecoration(labelText: 'Department'),
            ),
            TextField(
              controller: _programme,
              decoration: const InputDecoration(labelText: 'Programme'),
            ),
            TextField(
              controller: _level,
              decoration: const InputDecoration(labelText: 'Level or year'),
            ),
            TextField(
              controller: _subjects,
              decoration: const InputDecoration(labelText: 'Subjects'),
            ),
            TextField(
              controller: _interests,
              decoration: const InputDecoration(labelText: 'Interests'),
            ),
            TextField(
              controller: _languages,
              decoration: const InputDecoration(labelText: 'Languages'),
            ),
            TextField(
              controller: _availability,
              decoration: const InputDecoration(labelText: 'Availability'),
            ),
            const SizedBox(height: 20),
            FilledButton.icon(
              onPressed: _saving ? null : _save,
              icon: _saving
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.save_outlined),
              label: Text(_saving ? 'Saving…' : 'Save profile'),
            ),
          ],
        ),
      );

  Future<void> _save() async {
    setState(() => _saving = true);
    try {
      await widget.onSave(
        AcademicProfileDraft(
          department: _optional(_department.text),
          programme: _optional(_programme.text),
          level: _optional(_level.text),
          subjects: _list(_subjects.text),
          interests: _list(_interests.text),
          languages: _list(_languages.text),
          availability: _optional(_availability.text),
        ),
      );
      if (mounted) Navigator.of(context).pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String? _optional(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  List<String> _list(String value) => value
      .split(',')
      .map((item) => item.trim())
      .where((item) => item.isNotEmpty)
      .toSet()
      .take(30)
      .toList();
}
