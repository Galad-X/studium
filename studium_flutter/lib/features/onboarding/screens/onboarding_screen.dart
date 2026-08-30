import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/onboarding_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _logoController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _particleController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _logoController = AnimationController(
      duration: const Duration(seconds: 6),
      vsync: this,
    )..repeat();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    // Start animations
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 300), () {
      _slideController.forward();
    });

    // Auto-focus for keyboard navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _particleController.dispose();
    _logoController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _scrollUp() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _scrollDown() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _pageUp() {
    final viewportHeight = _scrollController.position.viewportDimension;
    _scrollController.animateTo(
      _scrollController.offset - viewportHeight,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _pageDown() {
    final viewportHeight = _scrollController.position.viewportDimension;
    _scrollController.animateTo(
      _scrollController.offset + viewportHeight,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent || event is KeyRepeatEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
        _scrollUp();
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
        _scrollDown();
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.pageUp) {
        _pageUp();
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.pageDown) {
        _pageDown();
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.home) {
        _scrollToTop();
        return KeyEventResult.handled;
      } else if (event.logicalKey == LogicalKeyboardKey.end) {
        _scrollToBottom();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0E1A),
        body: Stack(
          children: [
            // Animated neural network background
            _AnimatedNeuralBackground(controller: _particleController),

            // Main content
            SafeArea(
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 550),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Add top spacing to center content vertically
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),

                        // Animated logo with neural network effect
                        FadeTransition(
                          opacity: _fadeAnimation,
                          child: AnimatedBuilder(
                            animation: _logoController,
                            builder: (context, child) {
                              return Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Outer rotating ring
                                  Transform.rotate(
                                    angle: _logoController.value * 2 * 3.14159,
                                    child: Container(
                                      width: 160,
                                      height: 160,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFF3B82F6)
                                              .withAlpha(77),
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Inner counter-rotating ring
                                  Transform.rotate(
                                    angle:
                                        -_logoController.value * 1.5 * 3.14159,
                                    child: Container(
                                      width: 140,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFF8B5CF6)
                                              .withAlpha(77),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                  // Logo container
                                  Container(
                                    width: 120,
                                    height: 120,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF3B82F6),
                                          Color(0xFF8B5CF6)
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: const Color(0xFF3B82F6)
                                              .withAlpha(104),
                                          blurRadius: 30,
                                          spreadRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(24),
                                      child: Image.asset(
                                        'assets/logo.png',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Welcome text with slide animation
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                    colors: [
                                      Color(0xFF3B82F6),
                                      Color(0xFF8B5CF6)
                                    ],
                                  ).createShader(bounds),
                                  child: const Text(
                                    "Welcome to Studium AI",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Container(
                                  padding: const EdgeInsets.all(32),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(13),
                                    borderRadius: BorderRadius.circular(24),
                                    border: Border.all(
                                      color: Colors.white.withAlpha(26),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(52),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      const Text(
                                        "The Neural Future of Learning",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      const Text(
                                        "Transform your study materials into dynamic, interactive learning experiences powered by advanced AI neural networks.",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white70,
                                          height: 1.6,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Features preview with neural theme
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Column(
                              children: [
                                _NeuralFeatureItem(
                                  icon: Icons.quiz_rounded,
                                  title: 'Neural Quiz Generation',
                                  subtitle:
                                      'AI creates personalized tests instantly',
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFEF4444),
                                      Color(0xFFF97316)
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _NeuralFeatureItem(
                                  icon: Icons.summarize_rounded,
                                  title: 'Intelligent Summaries',
                                  subtitle:
                                      'Extract key insights with neural processing',
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF10B981),
                                      Color(0xFF059669)
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                _NeuralFeatureItem(
                                  icon: Icons.auto_awesome_rounded,
                                  title: 'AI Writing Assistant',
                                  subtitle:
                                      'Neural-powered academic writing support',
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF8B5CF6),
                                      Color(0xFFA855F7)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 48),

                        // Get started button with neural glow
                        SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: Container(
                              height: 64,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF3B82F6),
                                    Color(0xFF8B5CF6)
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        const Color(0xFF3B82F6).withAlpha(104),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () async {
                                    HapticFeedback.mediumImpact();
                                    await markOnboardingAsSeen();
                                    ref.invalidate(onboardingProvider);
                                  },
                                  child: const Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.psychology_rounded,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                        SizedBox(width: 16),
                                        Text(
                                          "Activate Neural Learning",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Add bottom spacing to ensure content doesn't get cut off
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnimatedNeuralBackground extends StatelessWidget {
  final AnimationController controller;

  const _AnimatedNeuralBackground({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return CustomPaint(
          painter: _NeuralNetworkPainter(controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _NeuralNetworkPainter extends CustomPainter {
  final double animationValue;

  _NeuralNetworkPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final connectionPaint = Paint()
      ..color = const Color(0xFF3B82F6).withAlpha(52)
      ..strokeWidth = 1.0;

    final nodePaint = Paint()..color = const Color(0xFF8B5CF6).withAlpha(104);

    // Create neural network pattern
    for (int i = 0; i < 30; i++) {
      final x1 = (i * 43.7 + animationValue * 50) % size.width;
      final y1 = (i * 31.3 + animationValue * 40) % size.height;

      // Draw connections to nearby nodes
      for (int j = i + 1; j < 30 && j < i + 4; j++) {
        final x2 = (j * 43.7 + animationValue * 50) % size.width;
        final y2 = (j * 31.3 + animationValue * 40) % size.height;

        final distance = ((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
        if (distance < 15000) {
          // Only connect nearby nodes
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), connectionPaint);
        }
      }

      // Draw neural nodes
      canvas.drawCircle(
        Offset(x1, y1),
        3.0 + (animationValue * 2) % 2,
        nodePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _NeuralFeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Gradient gradient;

  const _NeuralFeatureItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withAlpha(26),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(26),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: gradient,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: gradient.colors.first.withAlpha(77),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
