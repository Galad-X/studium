import 'package:flutter/material.dart';
import 'package:studium_client/studium_client.dart';

/// Reusable moderation surface for institution membership requests.
class MembershipReviewSheet extends StatelessWidget {
  const MembershipReviewSheet({
    super.key,
    required this.members,
    required this.onDecision,
    this.onUpdate,
  });

  final List<InstitutionMembership> members;
  final Future<void> Function(InstitutionMembership membership, String decision)
      onDecision;
  final Future<void> Function(
      InstitutionMembership membership, String role, String status)? onUpdate;

  @override
  Widget build(BuildContext context) {
    final pending =
        members.where((member) => member.status == 'pending').toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 18, 16, 16),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Institution members',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 4),
              Text(
                  '${pending.length} pending request(s) • ${members.length} total'),
              const SizedBox(height: 12),
              Expanded(
                child: members.isEmpty
                    ? const Center(child: Text('No institution members.'))
                    : ListView.separated(
                        itemCount: members.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          final member = members[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.person_outline),
                            title: Text('User #${member.userId}'),
                            subtitle: Text(
                              '${member.verificationMethod} • submitted '
                              '${member.createdAt.toLocal()}',
                            ),
                            trailing: Wrap(
                              spacing: 4,
                              children: [
                                if (member.status == 'verified' &&
                                    onUpdate != null)
                                  IconButton(
                                    tooltip: 'Remove access',
                                    onPressed: () => onUpdate!(
                                        member, member.role, 'suspended'),
                                    icon: const Icon(
                                        Icons.person_remove_outlined,
                                        color: Colors.orangeAccent),
                                  ),
                                if (member.status == 'suspended' &&
                                    onUpdate != null)
                                  IconButton(
                                    tooltip: 'Restore access',
                                    onPressed: () => onUpdate!(
                                        member, member.role, 'verified'),
                                    icon: const Icon(Icons.person_add_alt_1,
                                        color: Colors.greenAccent),
                                  ),
                                if (member.status == 'pending') ...[
                                  IconButton(
                                    tooltip: 'Reject',
                                    onPressed: () =>
                                        onDecision(member, 'reject'),
                                    icon: const Icon(Icons.close,
                                        color: Colors.redAccent),
                                  ),
                                  IconButton(
                                    tooltip: 'Approve',
                                    onPressed: () =>
                                        onDecision(member, 'approve'),
                                    icon: const Icon(Icons.check,
                                        color: Colors.greenAccent),
                                  ),
                                ],
                              ],
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
