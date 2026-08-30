import 'package:flutter/material.dart';

class PremiumFeatureGate extends StatelessWidget {
  const PremiumFeatureGate({
    required this.isPremium,
    required this.child,
    this.onUpgrade,
    super.key,
  });

  final bool isPremium;
  final Widget child;
  final VoidCallback? onUpgrade;

  @override
  Widget build(BuildContext context) {
    if (isPremium) return child;
    return Stack(
      children: [
        IgnorePointer(
            ignoring: true, child: Opacity(opacity: .55, child: child)),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onUpgrade,
              borderRadius: BorderRadius.circular(12),
              child: const Center(
                child: Chip(
                  avatar: Icon(Icons.workspace_premium_outlined, size: 18),
                  label: Text('Premium feature'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
