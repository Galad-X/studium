import 'package:flutter/material.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/neural_widgets.dart';

class StudySessionCard extends StatelessWidget {
  const StudySessionCard({
    required this.session,
    required this.onJoin,
    super.key,
  });

  final ScheduledStudySession session;
  final VoidCallback onJoin;

  @override
  Widget build(BuildContext context) => NeuralCard(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.calendar_month_outlined,
              color: Color(0xFF00D4FF)),
          title:
              Text(session.title, style: const TextStyle(color: Colors.white)),
          subtitle: Text(
            '${session.startsAt.toLocal()} – ${session.endsAt.toLocal()}',
            style: const TextStyle(color: Colors.white70),
          ),
          trailing: TextButton(onPressed: onJoin, child: const Text('Join')),
        ),
      );
}
