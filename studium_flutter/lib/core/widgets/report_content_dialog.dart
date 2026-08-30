import 'package:flutter/material.dart';

class ReportContentDialog extends StatefulWidget {
  final Future<void> Function(String reason, String? details) onSubmit;

  const ReportContentDialog({required this.onSubmit, super.key});

  static Future<bool?> show(
    BuildContext context, {
    required Future<void> Function(String reason, String? details) onSubmit,
  }) =>
      showDialog<bool>(
        context: context,
        builder: (_) => ReportContentDialog(onSubmit: onSubmit),
      );

  @override
  State<ReportContentDialog> createState() => _ReportContentDialogState();
}

class _ReportContentDialogState extends State<ReportContentDialog> {
  final _details = TextEditingController();
  String _reason = 'spam';
  bool _submitting = false;

  @override
  void dispose() {
    _details.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: const Text('Report content'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _reason,
              decoration: const InputDecoration(labelText: 'Reason'),
              items: const [
                DropdownMenuItem(value: 'spam', child: Text('Spam')),
                DropdownMenuItem(
                    value: 'harassment', child: Text('Harassment')),
                DropdownMenuItem(
                    value: 'plagiarism', child: Text('Plagiarism')),
                DropdownMenuItem(
                    value: 'unsafe', child: Text('Unsafe content')),
                DropdownMenuItem(
                    value: 'misinformation', child: Text('Misinformation')),
                DropdownMenuItem(value: 'other', child: Text('Other')),
              ],
              onChanged: _submitting
                  ? null
                  : (value) => setState(() => _reason = value ?? 'other'),
            ),
            TextField(
              controller: _details,
              maxLines: 3,
              maxLength: 2000,
              decoration:
                  const InputDecoration(labelText: 'Details (optional)'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: _submitting ? null : () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: _submitting ? null : _submit,
            child: _submitting
                ? const SizedBox.square(
                    dimension: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Submit'),
          ),
        ],
      );

  Future<void> _submit() async {
    setState(() => _submitting = true);
    try {
      final details = _details.text.trim();
      await widget.onSubmit(_reason, details.isEmpty ? null : details);
      if (mounted) Navigator.pop(context, true);
    } catch (error) {
      if (mounted) {
        setState(() => _submitting = false);
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }
}
