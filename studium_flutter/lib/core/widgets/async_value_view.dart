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
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => NeuralErrorState(
          message: error.toString(),
          onRetry: onRetry,
        ),
        data: (data) => builder(data),
      );
}

class EmptyListMessage extends StatelessWidget {
  const EmptyListMessage(this.message, {super.key});

  final String message;

  @override
  Widget build(BuildContext context) => Center(child: Text(message));
}
