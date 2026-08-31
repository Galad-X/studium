import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/collaboration_provider.dart';

final directMessagePrivacyProvider = StateNotifierProvider<
    DirectMessagePrivacyController, DirectMessagePrivacyState>(
  (ref) => DirectMessagePrivacyController(),
);

class DirectMessagePrivacyState {
  const DirectMessagePrivacyState(
      {this.isMinor = false, this.allowUnknownSenders = false});
  final bool isMinor;
  final bool allowUnknownSenders;
  DirectMessagePrivacyState copyWith(
          {bool? isMinor, bool? allowUnknownSenders}) =>
      DirectMessagePrivacyState(
        isMinor: isMinor ?? this.isMinor,
        allowUnknownSenders: allowUnknownSenders ?? this.allowUnknownSenders,
      );
}

class DirectMessagePrivacyController
    extends StateNotifier<DirectMessagePrivacyState> {
  DirectMessagePrivacyController() : super(const DirectMessagePrivacyState());
  void setMinor(bool value) => state =
      state.copyWith(isMinor: value, allowUnknownSenders: value ? false : null);
  void setUnknownSenders(bool value) =>
      state = state.copyWith(allowUnknownSenders: value);
}

class PrivacyControlsScreen extends ConsumerWidget {
  const PrivacyControlsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(directMessagePrivacyProvider);
    final persisted = ref.watch(myPrivacySettingsProvider).valueOrNull;
    final controller = ref.read(directMessagePrivacyProvider.notifier);
    final isMinor = persisted?.isMinor ?? state.isMinor;
    final allowUnknownSenders =
        persisted?.allowUnknownDirectMessages ?? state.allowUnknownSenders;
    return Scaffold(
      appBar: AppBar(title: const Text('Privacy controls')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const ListTile(
            leading: Icon(Icons.shield_outlined),
            title: Text('Your safety comes first'),
            subtitle: Text(
                'Server-side blocks, restrictions, and age safeguards always take precedence.'),
          ),
          SwitchListTile(
            title: const Text('Minor or vulnerable-user mode'),
            subtitle:
                const Text('Restrict direct messages from unknown people.'),
            value: isMinor,
            onChanged: (value) async {
              if (value) {
                final confirmed = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Guardian confirmation'),
                    content: const Text(
                      'Please confirm that a parent or guardian has approved minor safety mode. The server will keep this consent timestamp.',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancel'),
                      ),
                      FilledButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Confirm'),
                      ),
                    ],
                  ),
                );
                if (confirmed != true || !context.mounted) return;
              }
              controller.setMinor(value);
              await _save(ref, isMinor: value, guardianConsent: value);
            },
          ),
          SwitchListTile(
            title: const Text('Allow messages from unknown senders'),
            value: allowUnknownSenders,
            onChanged: isMinor
                ? null
                : (value) async {
                    controller.setUnknownSenders(value);
                    await _save(ref, allowUnknownDirectMessages: value);
                  },
          ),
        ],
      ),
    );
  }

  static Future<void> _save(
    WidgetRef ref, {
    bool? isMinor,
    bool guardianConsent = false,
    bool? allowUnknownDirectMessages,
  }) async {
    try {
      await ref.read(collaborationServiceProvider).updateMyPrivacySettings(
            isMinor: isMinor,
            guardianConsent: guardianConsent,
            allowUnknownDirectMessages: allowUnknownDirectMessages,
          );
      ref.invalidate(myPrivacySettingsProvider);
    } catch (_) {
      ref.invalidate(myPrivacySettingsProvider);
    }
  }
}
