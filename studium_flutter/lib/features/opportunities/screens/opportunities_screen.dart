import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:studium_client/studium_client.dart';

import '../../collaboration/providers/collaboration_provider.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import 'saved_opportunities_screen.dart';

class OpportunitiesScreen extends ConsumerStatefulWidget {
  const OpportunitiesScreen({super.key});

  @override
  ConsumerState<OpportunitiesScreen> createState() =>
      _OpportunitiesScreenState();
}

class _OpportunitiesScreenState extends ConsumerState<OpportunitiesScreen> {
  final _countryController = TextEditingController();
  final _fieldController = TextEditingController();
  String? _educationLevel;
  String? _opportunityType;
  int? _deadlineDays;
  OpportunityFilters _filters = const OpportunityFilters();

  @override
  void dispose() {
    _countryController.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  void _applyFilters() {
    setState(() {
      _filters = OpportunityFilters(
        country: _countryController.text.trim().ifEmpty,
        field: _fieldController.text.trim().ifEmpty,
        educationLevel: _educationLevel,
        opportunityType: _opportunityType,
        deadlineBefore: _deadlineDays == null
            ? null
            : DateTime.now().add(Duration(days: _deadlineDays!)),
      );
    });
  }

  Widget _filterChip({
    required String label,
    required String? value,
    required List<String> options,
    required ValueChanged<String?> onChanged,
  }) =>
      PopupMenuButton<String>(
        tooltip: label,
        onSelected: (selected) => onChanged(selected.isEmpty ? null : selected),
        itemBuilder: (context) => [
          PopupMenuItem<String>(value: '', child: Text('Any $label')),
          ...options.map(
            (option) => PopupMenuItem<String>(
              value: option,
              child: Text(option),
            ),
          ),
        ],
        child: Chip(
          avatar: const Icon(Icons.tune, size: 16),
          label: Text(value ?? 'Any $label'),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final opportunities = ref.watch(opportunitiesQueryProvider(_filters));
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        title: const Text('Scholarships & opportunities'),
        actions: [
          IconButton(
            tooltip: 'Saved opportunities',
            icon: const Icon(Icons.bookmarks_outlined),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const SavedOpportunitiesScreen(),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _countryController,
                    decoration: const InputDecoration(labelText: 'Country'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _fieldController,
                    decoration: const InputDecoration(labelText: 'Field'),
                  ),
                ),
                IconButton.filled(
                  tooltip: 'Apply filters',
                  onPressed: _applyFilters,
                  icon: const Icon(Icons.filter_alt_outlined),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 8,
              runSpacing: 4,
              children: [
                _filterChip(
                  label: 'level',
                  value: _educationLevel,
                  options: const ['undergraduate', 'postgraduate', 'doctoral'],
                  onChanged: (value) {
                    setState(() => _educationLevel = value);
                    _applyFilters();
                  },
                ),
                _filterChip(
                  label: 'type',
                  value: _opportunityType,
                  options: const [
                    'scholarship',
                    'fellowship',
                    'grant',
                    'internship',
                    'competition',
                  ],
                  onChanged: (value) {
                    setState(() => _opportunityType = value);
                    _applyFilters();
                  },
                ),
                _filterChip(
                  label: 'deadline',
                  value: _deadlineDays == null ? null : '$_deadlineDays days',
                  options: const ['30 days', '90 days', '180 days'],
                  onChanged: (value) {
                    setState(() {
                      _deadlineDays = value == null
                          ? null
                          : int.tryParse(value.split(' ').first);
                    });
                    _applyFilters();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: AsyncValueView<List<Opportunity>>(
              value: opportunities,
              onRetry: () =>
                  ref.invalidate(opportunitiesQueryProvider(_filters)),
              emptyMessage: 'No verified opportunities are available yet.',
              builder: (items) => items.isEmpty
                  ? const EmptyListMessage(
                      'No verified opportunities are available yet.')
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      itemBuilder: (context, index) => _OpportunityCard(
                        opportunity: items[index],
                        onSave: () async {
                          try {
                            await ref
                                .read(collaborationServiceProvider)
                                .saveOpportunity(items[index].id!);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Opportunity saved.')),
                              );
                            }
                          } catch (error) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(error.toString())),
                              );
                            }
                          }
                        },
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on String {
  String? get ifEmpty => isEmpty ? null : this;
}

class _OpportunityCard extends StatelessWidget {
  final Opportunity opportunity;
  final VoidCallback onSave;

  const _OpportunityCard({required this.opportunity, required this.onSave});

  @override
  Widget build(BuildContext context) => NeuralCard(
        margin: const EdgeInsets.only(bottom: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    opportunity.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (opportunity.verificationStatus == 'verified')
                  const Tooltip(
                    message: 'Verified official opportunity',
                    child: Icon(Icons.verified,
                        color: Colors.greenAccent, size: 20),
                  ),
                IconButton(
                  tooltip: 'Save opportunity',
                  onPressed: onSave,
                  icon: const Icon(Icons.bookmark_border),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '${opportunity.provider} • ${opportunity.opportunityType}',
              style: TextStyle(color: Colors.white.withAlpha(170)),
            ),
            const SizedBox(height: 8),
            Text(
              'Deadline: ${opportunity.deadline.toLocal().toString().split(' ').first}',
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 10),
            Text(opportunity.fundingDetails,
                style: const TextStyle(color: Colors.white)),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: () => _openOfficialSource(context),
              icon: const Icon(Icons.open_in_new),
              label: const Text('Official source'),
            ),
          ],
        ),
      );

  Future<void> _openOfficialSource(BuildContext context) async {
    final uri = Uri.tryParse(opportunity.officialUrl);
    if (uri == null || !{'http', 'https'}.contains(uri.scheme)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Official source URL is invalid.')),
      );
      return;
    }
    if (!await launchUrl(uri) && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open official source.')),
      );
    }
  }
}
