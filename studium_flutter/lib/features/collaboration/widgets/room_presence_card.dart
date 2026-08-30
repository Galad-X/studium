import 'package:flutter/material.dart';
import 'package:studium_client/studium_client.dart';

import '../../../core/widgets/neural_widgets.dart';

class RoomPresenceCard extends StatelessWidget {
  const RoomPresenceCard({required this.presence, super.key});

  final List<CollaborationPresence> presence;

  @override
  Widget build(BuildContext context) {
    final active = presence.where((item) => item.state == 'online').length;
    return NeuralCard(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Row(
        children: [
          const Icon(Icons.circle, size: 10, color: Colors.greenAccent),
          const SizedBox(width: 8),
          Text('$active active now',
              style: const TextStyle(color: Colors.white70)),
          const Spacer(),
          Text('${presence.length} present',
              style: TextStyle(color: Colors.white.withAlpha(150))),
        ],
      ),
    );
  }
}
