import 'package:flutter/material.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/neural_widgets.dart';

class StudyRoomCard extends StatelessWidget {
  const StudyRoomCard({required this.room, this.onTap, super.key});

  final StudyRoom room;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => NeuralCard(
        margin: const EdgeInsets.only(bottom: 12),
        onTap: onTap,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.groups, color: Color(0xFF00D4FF)),
          title: Text(
            room.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            room.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white.withAlpha(170)),
          ),
        ),
      );
}

class ChallengeCard extends StatelessWidget {
  const ChallengeCard({required this.challenge, this.onTap, super.key});

  final Challenge challenge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => NeuralCard(
        margin: const EdgeInsets.only(bottom: 12),
        onTap: onTap,
        accentColor: const Color(0xFFFFC107),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.lightbulb, color: Color(0xFFFFC107)),
          title: Text(
            challenge.title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            challenge.problemStatement,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white.withAlpha(170)),
          ),
        ),
      );
}

class ChallengeTeamCard extends StatelessWidget {
  const ChallengeTeamCard({
    required this.team,
    required this.onJoin,
    this.onTap,
    super.key,
  });

  final ChallengeTeam team;
  final VoidCallback onJoin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => NeuralCard(
        margin: const EdgeInsets.only(bottom: 10),
        onTap: onTap,
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.groups_outlined, color: Color(0xFF00D4FF)),
          title: Text(team.name, style: const TextStyle(color: Colors.white)),
          subtitle: Text(
            team.description?.isNotEmpty == true
                ? team.description!
                : 'Open team for this challenge',
            style: TextStyle(color: Colors.white.withAlpha(160)),
          ),
          trailing: TextButton(onPressed: onJoin, child: const Text('Join')),
        ),
      );
}
