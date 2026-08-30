import 'dart:math' as math;

import 'package:flutter/material.dart';

class NeuralNetworkBackground extends StatefulWidget {
  const NeuralNetworkBackground({super.key});

  @override
  State<NeuralNetworkBackground> createState() =>
      _NeuralNetworkBackgroundState();
}

class _NeuralNetworkBackgroundState extends State<NeuralNetworkBackground>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late List<_NeuralNode> nodes;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    nodes = List.generate(15, (index) => _NeuralNode());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _NeuralNetworkPainter(
            animation: _controller.value,
            nodes: nodes,
          ),
          size: Size.infinite,
        );
      },
    );
  }
}

class _NeuralNode {
  late double x, y, dx, dy;
  late double size;
  late Color color;

  _NeuralNode() {
    x = math.Random().nextDouble();
    y = math.Random().nextDouble();
    dx = (math.Random().nextDouble() - 0.5) * 0.002;
    dy = (math.Random().nextDouble() - 0.5) * 0.002;
    size = math.Random().nextDouble() * 3 + 1;
    color = [
      const Color(0xFF00D4FF),
      const Color.fromARGB(255, 103, 144, 192),
      const Color(0xFF9D4EDD),
    ][math.Random().nextInt(3)];
  }
}

class _NeuralNetworkPainter extends CustomPainter {
  final double animation;
  final List<_NeuralNode> nodes;

  _NeuralNetworkPainter({required this.animation, required this.nodes});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..strokeWidth = 1;

    // Update node positions
    for (var node in nodes) {
      node.x += node.dx;
      node.y += node.dy;

      if (node.x < 0 || node.x > 1) node.dx *= -1;
      if (node.y < 0 || node.y > 1) node.dy *= -1;
    }

    // Draw connections
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final node1 = nodes[i];
        final node2 = nodes[j];

        final dx = (node1.x - node2.x) * size.width;
        final dy = (node1.y - node2.y) * size.height;
        final distance = math.sqrt(dx * dx + dy * dy);

        if (distance < 150) {
          final opacity = (1 - distance / 150) * 0.3;
          paint.color = const Color(0xFF00D4FF).withValues(alpha: opacity);

          canvas.drawLine(
            Offset(node1.x * size.width, node1.y * size.height),
            Offset(node2.x * size.width, node2.y * size.height),
            paint,
          );
        }
      }
    }

    // Draw nodes
    for (var node in nodes) {
      paint.color = node.color.withAlpha(152);
      canvas.drawCircle(
        Offset(node.x * size.width, node.y * size.height),
        node.size,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
