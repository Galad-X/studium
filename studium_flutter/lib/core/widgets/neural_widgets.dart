import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Shared visual primitives for the Studium neural interface.
class NeuralCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color accentColor;

  const NeuralCard({
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.margin,
    this.onTap,
    this.accentColor = const Color(0xFF00D4FF),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A2E).withAlpha(220),
            const Color(0xFF16213E).withAlpha(170),
          ],
        ),
        border: Border.all(color: accentColor.withAlpha(90)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withAlpha(30),
            blurRadius: 14,
            spreadRadius: 1,
          ),
        ],
      ),
      child: child,
    );
    return onTap == null
        ? card
        : Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(16),
              child: card,
            ),
          );
  }
}

class NeuralSectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Widget? trailing;

  const NeuralSectionHeader({
    required this.title,
    this.subtitle,
    this.icon,
    this.trailing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (icon != null) ...[
          Icon(icon, color: const Color(0xFF00D4FF), size: 22),
          const SizedBox(width: 10),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              if (subtitle != null) ...[
                const SizedBox(height: 4),
                Text(
                  subtitle!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.white.withAlpha(160),
                      ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) trailing!,
      ],
    );
  }
}

class NeuralErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const NeuralErrorState({
    required this.message,
    required this.onRetry,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final compact = constraints.maxHeight < 240;
        return Center(
          child: Padding(
            padding: EdgeInsets.all(compact ? 12 : 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: compact ? 40 : 64,
                  color: Theme.of(context).colorScheme.error,
                ),
                SizedBox(height: compact ? 6 : 16),
                Text(
                  'Something went wrong',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(height: compact ? 4 : 8),
                Text(
                  message,
                  maxLines: compact ? 2 : 5,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white.withAlpha(170)),
                ),
                SizedBox(height: compact ? 8 : 20),
                FilledButton.icon(
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    onRetry();
                  },
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Try again'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class NeuralIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;

  const NeuralIconButton({
    required this.icon,
    this.onPressed,
    this.tooltip,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      tooltip: tooltip,
      icon: Icon(icon, color: const Color(0xFF00D4FF)),
      style: IconButton.styleFrom(
        backgroundColor: const Color(0xFF00D4FF).withAlpha(35),
        side: BorderSide(color: const Color(0xFF00D4FF).withAlpha(100)),
      ),
    );
  }
}
