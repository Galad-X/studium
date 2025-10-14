import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import 'dart:math' as math;

import '../../../core/providers/service_providers.dart';
import '../../../theme/neural_bg.dart';
import '../providers/material_providers.dart';

class MaterialsScreen extends ConsumerWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final materialsAsyncValue = ref.watch(materialsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // Neural network background
          const NeuralNetworkBackground(),

          // Main content
          SafeArea(
            child: Column(
              children: [
                _buildNeuralAppBar(context, ref, materialsAsyncValue),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      HapticFeedback.lightImpact();
                      ref.invalidate(materialsProvider);
                    },
                    color: const Color(0xFF00D4FF),
                    backgroundColor: const Color(0xFF1A1A2E),
                    child: materialsAsyncValue.when(
                      data: (materials) {
                        if (materials.isEmpty) {
                          return const _NeuralEmptyState();
                        }
                        return _buildMaterialsList(materials);
                      },
                      loading: () => const _NeuralLoadingState(),
                      error: (err, stack) => _NeuralErrorState(
                        error: err.toString(),
                        onRetry: () => ref.invalidate(materialsProvider),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: const _NeuralFAB(),
    );
  }

  Widget _buildNeuralAppBar(
      BuildContext context, WidgetRef ref, AsyncValue materialsAsyncValue) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A2E).withAlpha(229),
            const Color(0xFF16213E).withAlpha(178),
          ],
        ),
        border: Border(
          bottom: BorderSide(
            color: const Color(0xFF00D4FF).withAlpha(77),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          // Neural logo
          const _RotatingNeuralLogo(size: 32),
          const SizedBox(width: 16),

          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF7B68EE)],
                  ).createShader(bounds),
                  child: const Text(
                    'Neural Materials',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Text(
                  'AI-Enhanced Study Library',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withAlpha(178),
                  ),
                ),
              ],
            ),
          ),

          // Neural refresh button
          _NeuralRefreshButton(
            isLoading: materialsAsyncValue.isLoading,
            onPressed: () {
              HapticFeedback.lightImpact();
              ref.invalidate(materialsProvider);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMaterialsList(List<StudyMaterial> materials) {
    return AnimationLimiter(
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: materials.length,
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 375),
            child: SlideAnimation(
              verticalOffset: 50.0,
              child: FadeInAnimation(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _NeuralMaterialCard(material: materials[index]),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _RotatingNeuralLogo extends StatefulWidget {
  final double size;

  const _RotatingNeuralLogo({required this.size});

  @override
  State<_RotatingNeuralLogo> createState() => _RotatingNeuralLogoState();
}

class _RotatingNeuralLogoState extends State<_RotatingNeuralLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
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
        return Transform.rotate(
          angle: _controller.value * 2 * math.pi,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF00D4FF), Color(0xFF7B68EE)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D4FF).withAlpha(128),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: const Icon(
              Icons.psychology,
              color: Colors.white,
              size: 20,
            ),
          ),
        );
      },
    );
  }
}

class _NeuralRefreshButton extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _NeuralRefreshButton({
    required this.isLoading,
    required this.onPressed,
  });

  @override
  State<_NeuralRefreshButton> createState() => _NeuralRefreshButtonState();
}

class _NeuralRefreshButtonState extends State<_NeuralRefreshButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    if (widget.isLoading) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(_NeuralRefreshButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      _controller.repeat();
    } else if (!widget.isLoading && oldWidget.isLoading) {
      _controller.stop();
    }
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
        return GestureDetector(
          onTap: widget.isLoading ? null : widget.onPressed,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF00D4FF).withAlpha(52),
                  const Color(0xFF7B68EE).withAlpha(52),
                ],
              ),
              border: Border.all(
                color: const Color(0xFF00D4FF).withAlpha(128),
                width: 1,
              ),
            ),
            child: Transform.rotate(
              angle: widget.isLoading ? _controller.value * 2 * math.pi : 0,
              child: Icon(
                Icons.refresh_rounded,
                color: const Color(0xFF00D4FF),
                size: 24,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NeuralEmptyState extends StatefulWidget {
  const _NeuralEmptyState();

  @override
  State<_NeuralEmptyState> createState() => _NeuralEmptyStateState();
}

class _NeuralEmptyStateState extends State<_NeuralEmptyState>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated neural folder icon
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00D4FF), Color(0xFF7B68EE)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00D4FF).withAlpha(77),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.folder_open_rounded,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 32),

              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF00D4FF), Color(0xFF7B68EE)],
                ).createShader(bounds),
                child: const Text(
                  'Neural Library Empty',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              Text(
                'Upload your first study material to begin\nyour neural-enhanced learning journey!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(178),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Neural CTA button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF7B68EE)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D4FF).withAlpha(77),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    HapticFeedback.mediumImpact();
                    context.pushNamed('uploadMaterial');
                  },
                  icon: const Icon(Icons.psychology, color: Colors.white),
                  label: const Text(
                    'Add Neural Material',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NeuralLoadingState extends StatelessWidget {
  const _NeuralLoadingState();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _NeuralSkeletonCard(delay: index * 200),
        );
      },
    );
  }
}

class _NeuralSkeletonCard extends StatefulWidget {
  final int delay;

  const _NeuralSkeletonCard({required this.delay});

  @override
  State<_NeuralSkeletonCard> createState() => _NeuralSkeletonCardState();
}

class _NeuralSkeletonCardState extends State<_NeuralSkeletonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        _controller.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: [
                const Color(0xFF1A1A2E).withAlpha(128),
                const Color(0xFF16213E).withAlpha(77),
              ],
            ),
            border: Border.all(
              color: const Color(0xFF00D4FF)
                  .withAlpha((_animation.value * 0.3).toInt()),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF00D4FF)
                          .withAlpha((_animation.value * 51).toInt()),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white
                                .withAlpha((_animation.value * 0.1).toInt()),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 150,
                          height: 16,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colors.white
                                .withAlpha((_animation.value * 0.1).toInt()),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: const Color(0xFF7B68EE)
                          .withAlpha((_animation.value * 0.2).toInt()),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: 60,
                    height: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white
                          .withAlpha((_animation.value * 0.1).toInt()),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _NeuralErrorState extends StatelessWidget {
  final String error;
  final VoidCallback onRetry;

  const _NeuralErrorState({
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    Colors.red.withAlpha(52),
                    Colors.orange.withAlpha(52),
                  ],
                ),
                border: Border.all(
                  color: Colors.red.withAlpha(128),
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 60,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 24),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [Colors.red, Colors.orange],
              ).createShader(bounds),
              child: const Text(
                'Neural Error Detected',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Neural network connection failed.\nPlease check your connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white.withAlpha(178),
              ),
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: const LinearGradient(
                  colors: [Color(0xFF00D4FF), Color(0xFF7B68EE)],
                ),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onRetry();
                },
                icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                label: const Text(
                  'Reconnect Neural Network',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NeuralMaterialCard extends ConsumerStatefulWidget {
  final StudyMaterial material;

  const _NeuralMaterialCard({required this.material});

  @override
  ConsumerState<_NeuralMaterialCard> createState() =>
      _NeuralMaterialCardState();
}

class _NeuralMaterialCardState extends ConsumerState<_NeuralMaterialCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  IconData _getIconForType(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_rounded;
      case 'docx':
      case 'doc':
        return Icons.description_rounded;
      case 'pptx':
      case 'ppt':
        return Icons.slideshow_rounded;
      default:
        return Icons.insert_drive_file_rounded;
    }
  }

  Color _getColorForType(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return const Color(0xFFFF6B6B);
      case 'docx':
      case 'doc':
        return const Color(0xFF4ECDC4);
      case 'pptx':
      case 'ppt':
        return const Color(0xFFFFE66D);
      default:
        return const Color(0xFF00D4FF);
    }
  }

  @override
  Widget build(BuildContext context) {
    final fileTypeColor = _getColorForType(widget.material.fileType);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) {
              setState(() => isPressed = true);
              _controller.forward();
              HapticFeedback.lightImpact();
            },
            onTapUp: (_) {
              setState(() => isPressed = false);
              _controller.reverse();
            },
            onTapCancel: () {
              setState(() => isPressed = false);
              _controller.reverse();
            },
            onTap: () {
              context.pushNamed(
                'materialDetail',
                pathParameters: {'id': widget.material.id.toString()},
                extra: widget.material,
              );
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1A1A2E).withAlpha(204),
                    const Color(0xFF16213E).withAlpha(152),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFF00D4FF)
                      .withAlpha((_glowAnimation.value).toInt()),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00D4FF)
                        .withAlpha((_glowAnimation.value * 0.3).toInt()),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Neural file icon
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              fileTypeColor.withAlpha(52),
                              fileTypeColor.withAlpha(26),
                            ],
                          ),
                          border: Border.all(
                            color: fileTypeColor.withAlpha(128),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          _getIconForType(widget.material.fileType),
                          color: fileTypeColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),

                      // Title and metadata
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.material.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  size: 14,
                                  color: Colors.white.withAlpha(152),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  _formatDate(widget.material.uploadDate),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withAlpha(152),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Icon(
                                  Icons.psychology,
                                  size: 14,
                                  color: const Color(0xFF00D4FF),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'AI Enhanced',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: const Color(0xFF00D4FF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // More options
                      IconButton(
                        onPressed: () =>
                            _showNeuralOptionsMenu(context, widget.material),
                        icon: Icon(
                          Icons.more_vert_rounded,
                          color: Colors.white.withAlpha(178),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Status and file type row
                  Row(
                    children: [
                      // Neural status badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF00D4FF), Color(0xFF7B68EE)],
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.check_circle_outline,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 4),
                            const Text(
                              'Neural Ready',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),

                      // File type badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: fileTypeColor.withAlpha(52),
                          border: Border.all(
                            color: fileTypeColor.withAlpha(128),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          widget.material.fileType.toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: fileTypeColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date).inDays;

    if (difference == 0) return 'Today';
    if (difference == 1) return 'Yesterday';
    if (difference < 7) return '${difference}d ago';
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showNeuralOptionsMenu(BuildContext context, StudyMaterial material) {
    final FocusNode listFocusNode = FocusNode();
    final ScrollController scrollController = ScrollController();

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          ),
        ),
        child: KeyboardListener(
          focusNode: listFocusNode,
          autofocus: true,
          onKeyEvent: (event) {
            if (event is KeyDownEvent) {
              if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
                scrollController.animateTo(
                  scrollController.offset + 60,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                );
              } else if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
                scrollController.animateTo(
                  scrollController.offset - 60,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut,
                );
              }
            }
          },
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(77),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                _NeuralMenuTile(
                  icon: Icons.quiz_outlined,
                  title: 'Neural Quiz',
                  subtitle: 'AI-generated questions',
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(analyticsServiceProvider).log('start_quiz_tapped',
                        metadata: 'Material ID: ${material.id}');

                    context.pushNamed(
                      'startQuiz',
                      pathParameters: {'id': material.id!.toString()},
                      extra: material,
                    );
                  },
                ),
                _NeuralMenuTile(
                  icon: Icons.summarize_outlined,
                  title: 'Neural Summary',
                  subtitle: 'AI-powered insights',
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(analyticsServiceProvider).log(
                        'generate_summary_tapped',
                        metadata: 'Material ID: ${material.id}');

                    context.pushNamed(
                      'summary',
                      pathParameters: {'id': material.id!.toString()},
                      extra: material,
                    );
                  },
                ),
                _NeuralMenuTile(
                  icon: Icons.science_outlined,
                  title: 'Neural Research',
                  subtitle: 'Compare with latest findings',
                  onTap: () {
                    Navigator.pop(context);
                    ref.read(analyticsServiceProvider).log(
                        'research_comparison_tapped',
                        metadata: 'Material ID: ${material.id}');

                    context.pushNamed(
                      'compare',
                      pathParameters: {'id': material.id!.toString()},
                    );
                  },
                ),
                const Divider(color: Color(0xFF2A2A3E)),
                _NeuralMenuTile(
                  icon: Icons.share_outlined,
                  title: 'Share Neural Data',
                  subtitle: 'Share with neural network',
                  onTap: () => Navigator.pop(context),
                ),
                _NeuralMenuTile(
                  icon: Icons.delete_outline,
                  title: 'Remove from Neural Library',
                  subtitle: 'Delete permanently',
                  isDestructive: true,
                  onTap: () {
                    Navigator.pop(context);
                    _showDeleteConfirmation(context);
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Delete Material'),
        content: Text(
          'Are you sure you want to delete "${widget.material.title}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _NeuralMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool isDestructive;

  const _NeuralMenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red : Colors.white;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: (isDestructive ? Colors.red : const Color(0xFF00D4FF))
              .withAlpha(52),
        ),
        child: Icon(icon, color: color, size: 20),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: color.withAlpha(178),
          fontSize: 12,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
    );
  }
}

class _NeuralFAB extends StatefulWidget {
  const _NeuralFAB();

  @override
  State<_NeuralFAB> createState() => _NeuralFABState();
}

class _NeuralFABState extends State<_NeuralFAB>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
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
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: const LinearGradient(
                colors: [Color(0xFF00D4FF), Color(0xFF7B68EE)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D4FF)
                      .withAlpha((_glowAnimation.value * 0.5).toInt()),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: FloatingActionButton.extended(
              onPressed: () {
                HapticFeedback.mediumImpact();
                _controller.forward().then((_) => _controller.reverse());
                context.pushNamed('uploadMaterial');
              },
              backgroundColor: Colors.transparent,
              elevation: 0,
              icon: const Icon(Icons.psychology, color: Colors.white),
              label: const Text(
                'Add Neural Material',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
