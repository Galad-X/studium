import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/neural_widgets.dart';
import '../providers/collaboration_provider.dart';
import '../widgets/academic_profile_form.dart';
import '../widgets/membership_review_sheet.dart';
import '../widgets/reputation_badges.dart';

class InstitutionHubScreen extends ConsumerStatefulWidget {
  const InstitutionHubScreen({super.key});

  @override
  ConsumerState<InstitutionHubScreen> createState() =>
      _InstitutionHubScreenState();
}

class _InstitutionHubScreenState extends ConsumerState<InstitutionHubScreen> {
  final _searchController = TextEditingController();
  final _countryController = TextEditingController();
  final _regionController = TextEditingController();
  final _subjectController = TextEditingController();
  final _languageController = TextEditingController();
  final _inviteController = TextEditingController();
  String _searchQuery = '';

  void _refresh() {
    ref.invalidate(institutionSearchProvider(_searchQuery));
    ref.invalidate(myMembershipsProvider);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _countryController.dispose();
    _regionController.dispose();
    _subjectController.dispose();
    _languageController.dispose();
    _inviteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final institutions = ref.watch(institutionSearchProvider(_searchQuery));
    final memberships = ref.watch(myMembershipsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(title: const Text('Institutions')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const NeuralSectionHeader(
            title: 'Verified academic identity',
            subtitle:
                'Find your institution or redeem an invite to unlock academic spaces.',
            icon: Icons.verified_user_outlined,
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (_) => setState(() {
                    _searchQuery = _searchController.text.trim();
                  }),
                  decoration: const InputDecoration(
                    labelText: 'Search institutions',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton.filled(
                tooltip: 'Search',
                onPressed: () => setState(() {
                  _searchQuery = _searchController.text.trim();
                }),
                icon: const Icon(Icons.search),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 600;
              return Flex(
                direction: wide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (wide)
                    Expanded(child: _countryInput())
                  else
                    _countryInput(),
                  if (wide)
                    const SizedBox(width: 8)
                  else
                    const SizedBox(height: 8),
                  if (wide) Expanded(child: _regionInput()) else _regionInput(),
                ],
              );
            },
          ),
          const SizedBox(height: 8),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 600;
              return Flex(
                direction: wide ? Axis.horizontal : Axis.vertical,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (wide)
                    Expanded(child: _subjectInput())
                  else
                    _subjectInput(),
                  if (wide)
                    const SizedBox(width: 8)
                  else
                    const SizedBox(height: 8),
                  if (wide)
                    Expanded(child: _languageInput())
                  else
                    _languageInput(),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          AsyncValueView<List<InstitutionMembership>>(
            value: memberships,
            onRetry: _refresh,
            emptyMessage: '',
            builder: (memberships) {
              if (memberships.isEmpty) return const SizedBox.shrink();
              return NeuralCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your memberships',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    ...memberships.map((membership) => ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            membership.status == 'verified'
                                ? Icons.verified
                                : Icons.pending_outlined,
                            color: membership.status == 'verified'
                                ? Colors.greenAccent
                                : Colors.orangeAccent,
                          ),
                          title: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Institution #${membership.institutionId}'),
                              if (membership.status == 'verified') ...[
                                const SizedBox(width: 6),
                                const VerifiedContributionBadge(),
                              ],
                            ],
                          ),
                          subtitle: Text(
                            '${membership.role} • ${membership.status}',
                          ),
                          trailing: membership.status == 'pending'
                              ? TextButton(
                                  onPressed: () => _submitEvidence(membership),
                                  child: const Text('Add evidence'),
                                )
                              : membership.status == 'verified'
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          tooltip: 'Edit academic profile',
                                          onPressed: () =>
                                              _editProfile(membership),
                                          icon: const Icon(Icons.edit_outlined),
                                        ),
                                        if ({'institution_admin', 'moderator'}
                                            .contains(membership.role))
                                          IconButton(
                                            tooltip: 'Review requests',
                                            onPressed: () =>
                                                _reviewMemberships(membership),
                                            icon: const Icon(
                                                Icons.manage_accounts_outlined),
                                          ),
                                        if (membership.role ==
                                            'institution_admin')
                                          IconButton(
                                            tooltip: 'Create invite',
                                            onPressed: () => _createInvite(
                                                membership.institutionId),
                                            icon: const Icon(
                                                Icons.person_add_alt),
                                          ),
                                      ],
                                    )
                                  : null,
                        )),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 14),
          AsyncValueView<List<Institution>>(
            value: institutions,
            onRetry: _refresh,
            emptyMessage: 'No institutions found.',
            builder: (institutions) {
              final country = _countryController.text.trim().toLowerCase();
              final region = _regionController.text.trim().toLowerCase();
              final subject = _subjectController.text.trim().toLowerCase();
              final language = _languageController.text.trim().toLowerCase();
              final filtered = institutions.where((institution) {
                final countryMatches = country.isEmpty ||
                    institution.country.toLowerCase().contains(country);
                final regionMatches = region.isEmpty ||
                    institution.region?.toLowerCase().contains(region) == true;
                final subjectMatches = subject.isEmpty ||
                    institution.subjects?.any(
                            (value) => value.toLowerCase().contains(subject)) ==
                        true;
                final languageMatches = language.isEmpty ||
                    institution.languages?.any((value) =>
                            value.toLowerCase().contains(language)) ==
                        true;
                return countryMatches &&
                    regionMatches &&
                    subjectMatches &&
                    languageMatches;
              }).toList();
              if (filtered.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.all(24),
                  child: EmptyListMessage('No institutions found.'),
                );
              }
              return Column(
                children: filtered
                    .map((institution) => NeuralCard(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.account_balance,
                                color: Color(0xFF00D4FF)),
                            title: Text(institution.name,
                                style: const TextStyle(color: Colors.white)),
                            subtitle: Text(
                              '${institution.country}${institution.region == null ? '' : ' • ${institution.region}'}',
                            ),
                            trailing: FilledButton.tonal(
                              onPressed: () => _requestMembership(institution),
                              child: const Text('Join'),
                            ),
                          ),
                        ))
                    .toList(),
              );
            },
          ),
          const SizedBox(height: 14),
          NeuralCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Have an invite?',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _inviteController,
                        decoration:
                            const InputDecoration(labelText: 'Invite token'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    FilledButton(
                      onPressed: _acceptInvite,
                      child: const Text('Redeem'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _countryInput() => TextField(
        controller: _countryController,
        decoration: const InputDecoration(labelText: 'Country'),
        onChanged: (_) => setState(() {}),
      );

  Widget _regionInput() => TextField(
        controller: _regionController,
        decoration: const InputDecoration(labelText: 'Region'),
        onChanged: (_) => setState(() {}),
      );

  Widget _subjectInput() => TextField(
        controller: _subjectController,
        decoration: const InputDecoration(labelText: 'Subject or programme'),
        onChanged: (_) => setState(() {}),
      );

  Widget _languageInput() => TextField(
        controller: _languageController,
        decoration: const InputDecoration(labelText: 'Language'),
        onChanged: (_) => setState(() {}),
      );

  Future<void> _acceptInvite() async {
    final token = _inviteController.text.trim();
    if (token.isEmpty) return;
    try {
      await ref
          .read(collaborationServiceProvider)
          .acceptInstitutionInvite(token);
      if (!mounted) return;
      _inviteController.clear();
      _refresh();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Institution membership verified.')),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  Future<void> _requestMembership(Institution institution) async {
    final method = await showDialog<String>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Verify membership'),
        children: [
          SimpleDialogOption(
            onPressed: () => Navigator.pop(dialogContext, 'institution_email'),
            child: const ListTile(
              leading: Icon(Icons.mail_outline),
              title: Text('Institution email'),
              subtitle: Text('Use your verified academic email domain'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () => Navigator.pop(dialogContext, 'manual'),
            child: const ListTile(
              leading: Icon(Icons.description_outlined),
              title: Text('Manual review'),
              subtitle: Text('Submit a request for an institution moderator'),
            ),
          ),
        ],
      ),
    );
    if (method == null || !mounted) return;
    try {
      final membership = await ref
          .read(collaborationServiceProvider)
          .requestMembership(institution.id!, method);
      if (!mounted) return;
      _refresh();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(membership.status == 'verified'
              ? 'Institution membership verified.'
              : 'Membership request submitted for review.'),
        ),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }

  Future<void> _submitEvidence(InstitutionMembership membership) async {
    final evidence = TextEditingController();
    final submitted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Submit verification evidence'),
        content: TextField(
          controller: evidence,
          autofocus: true,
          keyboardType: TextInputType.url,
          decoration: const InputDecoration(
            labelText: 'Evidence URL',
            hintText: 'https://...',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Submit'),
          ),
        ],
      ),
    );
    if (submitted != true || !mounted) {
      evidence.dispose();
      return;
    }
    try {
      await ref
          .read(collaborationServiceProvider)
          .submitVerificationEvidence(membership.id!, evidence.text);
      if (!mounted) return;
      _refresh();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Evidence submitted for review.')),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    } finally {
      evidence.dispose();
    }
  }

  Future<void> _editProfile(InstitutionMembership membership) async {
    final service = ref.read(collaborationServiceProvider);
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) => FutureBuilder<AcademicProfile?>(
        future: service.getAcademicProfile(membership.institutionId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 220,
              child: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasError) {
            return SizedBox(
              height: 220,
              child: Center(
                  child: Text('Unable to load profile: ${snapshot.error}')),
            );
          }
          return AcademicProfileForm(
            profile: snapshot.data,
            onSave: (draft) async {
              await service.upsertAcademicProfile(
                institutionId: membership.institutionId,
                department: draft.department,
                programme: draft.programme,
                level: draft.level,
                subjects: draft.subjects,
                interests: draft.interests,
                languages: draft.languages,
                availability: draft.availability,
              );
              if (mounted) {
                ScaffoldMessenger.of(this.context).showSnackBar(
                  const SnackBar(content: Text('Academic profile saved.')),
                );
              }
            },
          );
        },
      ),
    );
  }

  Future<void> _reviewMemberships(InstitutionMembership membership) async {
    final service = ref.read(collaborationServiceProvider);
    final members =
        await service.getInstitutionMembers(membership.institutionId);
    if (!mounted) return;
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => MembershipReviewSheet(
        members: members,
        onDecision: (target, decision) async {
          await service.reviewMembership(target.id!, decision);
          if (!mounted) return;
          Navigator.of(context).pop();
          _refresh();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Membership ${decision}d.')),
          );
        },
        onUpdate: (target, role, status) async {
          await service.updateInstitutionMember(target.id!, role, status);
          if (!mounted) return;
          _refresh();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(status == 'suspended'
                  ? 'Member access removed.'
                  : 'Member access restored.'),
            ),
          );
        },
      ),
    );
  }

  Future<void> _createInvite(int institutionId) async {
    try {
      final token = await ref
          .read(collaborationServiceProvider)
          .createInstitutionInvite(institutionId);
      if (!mounted) return;
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Institution invite created'),
          content: SelectableText(token),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.toString())));
      }
    }
  }
}
