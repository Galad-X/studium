import 'package:flutter/material.dart';
import 'package:studium_client/studium_client.dart';

class ReputationBadge extends StatelessWidget {
  const ReputationBadge({required this.reputation, super.key});

  final UserReputation reputation;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message:
          '${reputation.score} reputation • ${reputation.acceptedSolutions} accepted solutions • ${reputation.verifiedContributions} verified contributions',
      child: Chip(
        avatar: const Icon(Icons.verified_outlined, size: 16),
        label: Text('${reputation.score} reputation'),
        visualDensity: VisualDensity.compact,
      ),
    );
  }
}
