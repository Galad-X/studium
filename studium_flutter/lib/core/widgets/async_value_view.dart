import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'neural_widgets.dart';

/// Shared rendering for Riverpod-backed lists and detail sections.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    required this.value,
    required this.onRetry,
    required this.emptyMessage,
    required this.builder,
    super.key,
  });

  final AsyncValue<T> value;
  final VoidCallback onRetry;
  final String emptyMessage;
  final Widget Function(T data) builder;

  @override
  Widget build(BuildContext context) => value.when(
        loading: () => Center(
          child: Semantics(
            label: 'Loading content',
            liveRegion: true,
            child: const CircularProgressIndicator(),
          ),
        ),
        error: (error, _) => NeuralErrorState(
          message: error.toString(),
          onRetry: onRetry,
        ),
        data: (data) => data is Iterable && data.isEmpty
            ? EmptyListMessage(emptyMessage)
            : builder(data),
      );
}

class EmptyListMessage extends StatelessWidget {
  const EmptyListMessage(this.message, {this.icon, super.key});

  final String message;
  final IconData? icon;

  @override
  Widget build(BuildContext context) => Semantics(
        label: message,
        liveRegion: true,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon ?? Icons.inbox_outlined, size: 40),
                const SizedBox(height: 12),
                Text(message, textAlign: TextAlign.center),
              ],
            ),
          ),
        ),
      );
}
