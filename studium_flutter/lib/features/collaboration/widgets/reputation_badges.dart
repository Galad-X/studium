import 'package:flutter/material.dart';

class ReputationSummary extends StatelessWidget {
  const ReputationSummary({
    required this.score,
    this.acceptedSolutions = 0,
    this.verifiedContributions = 0,
    super.key,
  });

  final int score;
  final int acceptedSolutions;
  final int verifiedContributions;

  @override
  Widget build(BuildContext context) => Wrap(
        spacing: 8,
        runSpacing: 6,
        children: [
          Chip(
              avatar: const Icon(Icons.star, size: 16),
              label: Text('$score reputation')),
          if (acceptedSolutions > 0)
            Chip(
                avatar: const Icon(Icons.check, size: 16),
                label: Text('$acceptedSolutions accepted')),
          if (verifiedContributions > 0)
            Chip(
                avatar: const Icon(Icons.verified, size: 16),
                label: Text('$verifiedContributions verified')),
        ],
      );
}

class VerifiedContributionBadge extends StatelessWidget {
  const VerifiedContributionBadge({super.key});
  @override
  Widget build(BuildContext context) => const Tooltip(
        message: 'Verified academic contribution',
        child: Icon(Icons.verified, color: Colors.lightBlueAccent, size: 18),
      );
}
