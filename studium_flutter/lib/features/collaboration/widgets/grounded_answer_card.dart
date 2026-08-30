import 'package:flutter/material.dart';

import '../../../core/widgets/neural_widgets.dart';

class GroundedAnswerCard extends StatelessWidget {
  const GroundedAnswerCard({
    required this.answer,
    required this.confidence,
    required this.citations,
    this.onReport,
    this.onCitationTap,
    super.key,
  });

  final String answer;
  final String confidence;
  final List<String> citations;
  final VoidCallback? onReport;
  final Future<void> Function(String citation)? onCitationTap;

  @override
  Widget build(BuildContext context) => NeuralCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.auto_awesome, color: Color(0xFF00D4FF)),
                const SizedBox(width: 8),
                Text('AI-assisted answer • $confidence',
                    style: const TextStyle(color: Colors.white70)),
                const Spacer(),
                if (onReport != null)
                  IconButton(
                    tooltip: 'Report answer',
                    onPressed: onReport,
                    icon: const Icon(Icons.flag_outlined),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            SelectableText(answer,
                style: const TextStyle(color: Colors.white, height: 1.4)),
            if (citations.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Text('Sources used',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              ...citations.asMap().entries.map(
                    (entry) => Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: InkWell(
                        onTap: onCitationTap == null
                            ? null
                            : () => onCitationTap!(entry.value),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 3),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '[${entry.key + 1}] ${entry.value}',
                                  style: const TextStyle(
                                      color: Colors.lightBlueAccent),
                                ),
                              ),
                              if (onCitationTap != null)
                                const Icon(Icons.open_in_new,
                                    size: 15, color: Colors.lightBlueAccent),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
            ],
          ],
        ),
      );
}
