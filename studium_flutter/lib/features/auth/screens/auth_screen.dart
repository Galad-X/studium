import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import '../../../core/layout/responsive.dart';
import '../providers/auth_screen_provider.dart';

class AuthScreen extends ConsumerWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authScreenProvider);

    return ResponsiveScaffold(
      mobile: _MobileAuthLayout(state: state),
      tablet: _TabletAuthLayout(state: state),
      desktop: _DesktopAuthLayout(state: state),
    );
  }
}

// NEURAL NETWORK BACKGROUND PAINTER
class _NeuralNetworkPainter extends CustomPainter {
  final Animation<double> animation;
  final Color nodeColor;
  final Color connectionColor;

  _NeuralNetworkPainter({
    required this.animation,
    required this.nodeColor,
    required this.connectionColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = connectionColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = nodeColor
      ..style = PaintingStyle.fill;

    // Generate neural network nodes
    final nodes = <Offset>[];
    final random = math.Random(42); // Fixed seed for consistent pattern

    for (int i = 0; i < 20; i++) {
      nodes.add(Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      ));
    }

    // Draw connections with animation
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;
        if (distance < 150) {
          final opacity = (1 - distance / 150) * 0.3;
          final baseColor = connectionColor;
          final newAlpha = (opacity *
                  (0.5 + 0.5 * math.sin(animation.value * 2 * math.pi + i)) *
                  255)
              .clamp(0, 255)
              .toInt();
          paint.color = baseColor.withAlpha(newAlpha);
          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }

    // Draw nodes with pulsing animation
    for (int i = 0; i < nodes.length; i++) {
      final pulseScale =
          1 + 0.3 * math.sin(animation.value * 2 * math.pi + i * 0.5);
      final radius = 3.0 * pulseScale;
      nodePaint.color = nodeColor.withAlpha(152);
      canvas.drawCircle(nodes[i], radius, nodePaint);

      // Inner glow
      nodePaint.color = nodeColor.withAlpha(229);
      canvas.drawCircle(nodes[i], radius * 0.5, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// ENHANCED MOBILE LAYOUT
class _MobileAuthLayout extends ConsumerStatefulWidget {
  final dynamic state;

  const _MobileAuthLayout({required this.state});

  @override
  ConsumerState<_MobileAuthLayout> createState() => _MobileAuthLayoutState();
}

class _MobileAuthLayoutState extends ConsumerState<_MobileAuthLayout>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _neuralController;
  late AnimationController _logoController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoRotation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _neuralController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    _logoController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
        CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic));
    _logoRotation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.linear),
    );

    _fadeController.forward();
    _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _neuralController.dispose();
    _logoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    String headerText = 'Neural Access';
    String subHeaderText = 'Connect to your AI learning network';
    Widget currentForm = const _SignInForm();

    switch (widget.state.authMode) {
      case AuthMode.signIn:
        headerText = 'Neural Access';
        subHeaderText = 'Reconnect to your AI learning network';
        currentForm = const _SignInForm();
        break;
      case AuthMode.signUp:
        headerText = 'Neural Registration';
        subHeaderText = 'Initialize your AI learning profile';
        currentForm = const _SignUpForm();
        break;
      case AuthMode.verifyEmail:
        headerText = 'Neural Verification';
        subHeaderText = 'Confirm your neural network connection';
        currentForm = const _VerifyEmailForm();
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0A0E1A),
              Color(0xFF1A1F2E),
              Color(0xFF0A0E1A),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Neural Network Background
            Positioned.fill(
              child: AnimatedBuilder(
                animation: _neuralController,
                builder: (context, child) {
                  return CustomPaint(
                    painter: _NeuralNetworkPainter(
                      animation: _neuralController,
                      nodeColor: const Color(0xFF4FC3F7),
                      connectionColor: const Color(0xFF7C4DFF),
                    ),
                  );
                },
              ),
            ),

            // Main Content
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 16.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Enhanced Neural Logo
                            AnimatedBuilder(
                              animation: _logoRotation,
                              builder: (context, child) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Outer rotating ring
                                    Transform.rotate(
                                      angle: _logoRotation.value,
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF4FC3F7)
                                                .withAlpha(77),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Middle ring
                                    Transform.rotate(
                                      angle: -_logoRotation.value * 0.7,
                                      child: Container(
                                        width: 90,
                                        height: 90,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF7C4DFF)
                                                .withAlpha(104),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Brain Logo Container
                                    Container(
                                      width: 80,
                                      height: 80,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF4FC3F7),
                                            Color(0xFF7C4DFF),
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF4FC3F7)
                                                .withAlpha(104),
                                            blurRadius: 20,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.psychology_rounded,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 40),

                            // Header Text
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                              ).createShader(bounds),
                              child: Text(
                                headerText,
                                textAlign: TextAlign.center,
                                style: textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              subHeaderText,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withAlpha(178),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Form Container
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(13),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF4FC3F7).withAlpha(52),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(77),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.1, 0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    ),
                                  );
                                },
                                child: currentForm,
                              ),
                            ),

                            // Error Message
                            if (widget.state.errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withAlpha(26),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.red.withAlpha(77),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.error_outline_rounded,
                                        color: Colors.red.shade300,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          widget.state.errorMessage!,
                                          style: TextStyle(
                                            color: Colors.red.shade300,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
          ],
        ),
      ),
    );
  }
}

// ENHANCED TABLET LAYOUT
class _TabletAuthLayout extends ConsumerStatefulWidget {
  final dynamic state;

  const _TabletAuthLayout({required this.state});

  @override
  ConsumerState<_TabletAuthLayout> createState() => _TabletAuthLayoutState();
}

class _TabletAuthLayoutState extends ConsumerState<_TabletAuthLayout>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _neuralController;
  late AnimationController _logoController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoRotation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _neuralController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    )..repeat();
    _logoController = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutCubic));
    _logoRotation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.linear),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _neuralController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    String headerText = 'Neural Access';
    String subHeaderText = 'Connect to your AI learning network';
    Widget currentForm = const _SignInForm();

    switch (widget.state.authMode) {
      case AuthMode.signIn:
        headerText = 'Neural Access';
        subHeaderText = 'Reconnect to your AI learning network';
        currentForm = const _SignInForm();
        break;
      case AuthMode.signUp:
        headerText = 'Neural Registration';
        subHeaderText = 'Initialize your AI learning profile';
        currentForm = const _SignUpForm();
        break;
      case AuthMode.verifyEmail:
        headerText = 'Neural Verification';
        subHeaderText = 'Confirm your neural network connection';
        currentForm = const _VerifyEmailForm();
        break;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Row(
        children: [
          // Left side - Neural Network Branding
          Expanded(
            flex: 3,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF0A0E1A),
                    Color(0xFF1A1F2E),
                    Color(0xFF2A1B3D),
                  ],
                ),
              ),
              child: Stack(
                children: [
                  // Neural Network Background
                  Positioned.fill(
                    child: AnimatedBuilder(
                      animation: _neuralController,
                      builder: (context, child) {
                        return CustomPaint(
                          painter: _NeuralNetworkPainter(
                            animation: _neuralController,
                            nodeColor: const Color(0xFF4FC3F7),
                            connectionColor: const Color(0xFF7C4DFF),
                          ),
                        );
                      },
                    ),
                  ),

                  // Content
                  Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Padding(
                        padding: const EdgeInsets.all(48),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Enhanced Neural Logo
                            AnimatedBuilder(
                              animation: _logoRotation,
                              builder: (context, child) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Outer rotating ring
                                    Transform.rotate(
                                      angle: _logoRotation.value,
                                      child: Container(
                                        width: 160,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF4FC3F7)
                                                .withAlpha(77),
                                            width: 2,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Middle ring
                                    Transform.rotate(
                                      angle: -_logoRotation.value * 0.7,
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: const Color(0xFF7C4DFF)
                                                .withAlpha(104),
                                            width: 1.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    // Brain Logo Container
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFF4FC3F7),
                                            Color(0xFF7C4DFF),
                                          ],
                                        ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: const Color(0xFF4FC3F7)
                                                .withAlpha(104),
                                            blurRadius: 30,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: const Icon(
                                        Icons.psychology_rounded,
                                        size: 50,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 40),

                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                              ).createShader(bounds),
                              child: Text(
                                'Studium AI',
                                style: textTheme.displaySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Neural Future of Learning',
                              textAlign: TextAlign.center,
                              style: textTheme.titleLarge?.copyWith(
                                color: Colors.white.withAlpha(204),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 40),

                            // Neural Feature Pills
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              alignment: WrapAlignment.center,
                              children: [
                                _NeuralFeaturePill(
                                  icon: Icons.auto_awesome_rounded,
                                  label: 'Neural Summaries',
                                ),
                                _NeuralFeaturePill(
                                  icon: Icons.psychology_rounded,
                                  label: 'AI Quiz Generation',
                                ),
                                _NeuralFeaturePill(
                                  icon: Icons.edit_note_rounded,
                                  label: 'Neural Writer',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Right side - Auth Form
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xFF0A0E1A),
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(48.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 400),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                              ).createShader(bounds),
                              child: Text(
                                headerText,
                                textAlign: TextAlign.center,
                                style: textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              subHeaderText,
                              textAlign: TextAlign.center,
                              style: textTheme.bodyLarge?.copyWith(
                                color: Colors.white.withAlpha(178),
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 40),
                            Container(
                              padding: const EdgeInsets.all(24),
                              decoration: BoxDecoration(
                                color: Colors.white.withAlpha(13),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFF4FC3F7).withAlpha(52),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withAlpha(77),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: AnimatedSwitcher(
                                duration: const Duration(milliseconds: 400),
                                transitionBuilder: (child, animation) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: SlideTransition(
                                      position: Tween<Offset>(
                                        begin: const Offset(0.1, 0),
                                        end: Offset.zero,
                                      ).animate(animation),
                                      child: child,
                                    ),
                                  );
                                },
                                child: currentForm,
                              ),
                            ),
                            if (widget.state.errorMessage != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 20.0),
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.red.withAlpha(26),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.red.withAlpha(77),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.error_outline_rounded,
                                        color: Colors.red.shade300,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          widget.state.errorMessage!,
                                          style: TextStyle(
                                            color: Colors.red.shade300,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
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
          ),
        ],
      ),
    );
  }
}

// ENHANCED DESKTOP LAYOUT
class _DesktopAuthLayout extends ConsumerStatefulWidget {
  final dynamic state;

  const _DesktopAuthLayout({required this.state});

  @override
  ConsumerState<_DesktopAuthLayout> createState() => _DesktopAuthLayoutState();
}

class _DesktopAuthLayoutState extends ConsumerState<_DesktopAuthLayout>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _neuralController;
  late AnimationController _logoController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _leftSlideAnimation;
  late Animation<Offset> _rightSlideAnimation;
  late Animation<double> _logoRotation;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _neuralController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();
    _logoController = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _leftSlideAnimation = Tween<Offset>(
      begin: const Offset(-0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutCubic));
    _rightSlideAnimation = Tween<Offset>(
      begin: const Offset(0.3, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.easeOutCubic));
    _logoRotation = Tween<double>(begin: 0.0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.linear),
    );

    _animationController.forward();
    // Auto-focus for keyboard navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _neuralController.dispose();
    _logoController.dispose();
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
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    String headerText = 'Neural Access';
    String subHeaderText = 'Connect to your AI learning network';
    Widget currentForm = const _SignInForm();

    switch (widget.state.authMode) {
      case AuthMode.signIn:
        headerText = 'Neural Access';
        subHeaderText = 'Reconnect to your AI learning network';
        currentForm = const _SignInForm();
        break;
      case AuthMode.signUp:
        headerText = 'Neural Registration';
        subHeaderText = 'Initialize your AI learning profile';
        currentForm = const _SignUpForm();
        break;
      case AuthMode.verifyEmail:
        headerText = 'Neural Verification';
        subHeaderText = 'Confirm your neural network connection';
        currentForm = const _VerifyEmailForm();
        break;
    }

    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0E1A),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0A0E1A),
                Color(0xFF1A1F2E),
                Color(0xFF0A0E1A),
              ],
            ),
          ),
          child: Stack(
            children: [
              // Neural Network Background
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _neuralController,
                  builder: (context, child) {
                    return CustomPaint(
                      painter: _NeuralNetworkPainter(
                        animation: _neuralController,
                        nodeColor: const Color(0xFF4FC3F7),
                        connectionColor: const Color(0xFF7C4DFF),
                      ),
                    );
                  },
                ),
              ),

              // Main Content
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(32.0),
                  child: FadeTransition(
                    opacity: _fadeAnimation,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Left card - Enhanced Neural Branding
                        SlideTransition(
                          position: _leftSlideAnimation,
                          child: Container(
                            width: 480,
                            margin: const EdgeInsets.only(right: 32),
                            padding: const EdgeInsets.all(48),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF1A1F2E),
                                  Color(0xFF2A1B3D),
                                  Color(0xFF1A1F2E),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(0xFF4FC3F7).withAlpha(77),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF4FC3F7).withAlpha(52),
                                  blurRadius: 30,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // App Icon and Title
                                Row(
                                  children: [
                                    AnimatedBuilder(
                                      animation: _logoRotation,
                                      builder: (context, child) {
                                        return Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            // Outer rotating ring
                                            Transform.rotate(
                                              angle: _logoRotation.value,
                                              child: Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  border: Border.all(
                                                    color:
                                                        const Color(0xFF4FC3F7)
                                                            .withAlpha(77),
                                                    width: 2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            // Brain Logo Container
                                            Container(
                                              width: 60,
                                              height: 60,
                                              decoration: BoxDecoration(
                                                gradient: const LinearGradient(
                                                  colors: [
                                                    Color(0xFF4FC3F7),
                                                    Color(0xFF7C4DFF),
                                                  ],
                                                ),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color:
                                                        const Color(0xFF4FC3F7)
                                                            .withAlpha(104),
                                                    blurRadius: 20,
                                                    offset: const Offset(0, 8),
                                                  ),
                                                ],
                                              ),
                                              child: const Icon(
                                                Icons.psychology_rounded,
                                                size: 30,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ShaderMask(
                                            shaderCallback: (bounds) =>
                                                const LinearGradient(
                                              colors: [
                                                Color(0xFF4FC3F7),
                                                Color(0xFF7C4DFF)
                                              ],
                                            ).createShader(bounds),
                                            child: Text(
                                              'Studium AI',
                                              style: textTheme.displaySmall
                                                  ?.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Neural Learning Platform',
                                            style:
                                                textTheme.titleMedium?.copyWith(
                                              color:
                                                  Colors.white.withAlpha(178),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 40),

                                Text(
                                  'Neural Future of Learning',
                                  style: textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    height: 1.3,
                                  ),
                                ),
                                const SizedBox(height: 32),

                                // Enhanced Neural Feature Items
                                _NeuralFeatureItem(
                                  icon: Icons.auto_awesome_rounded,
                                  title: 'Neural Summaries',
                                  description:
                                      'AI-powered document analysis with neural network processing for intelligent insights',
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 24),
                                _NeuralFeatureItem(
                                  icon: Icons.psychology_rounded,
                                  title: 'Cognitive Quizzes',
                                  description:
                                      'Adaptive learning assessments generated by advanced neural algorithms',
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 24),
                                _NeuralFeatureItem(
                                  icon: Icons.edit_note_rounded,
                                  title: 'Neural Writer',
                                  description:
                                      'Intelligent writing assistance powered by deep learning models',
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 32),

                                // Neural Stats Row
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(13),
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color:
                                          const Color(0xFF4FC3F7).withAlpha(52),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      _NeuralStatItem(
                                        value: '10K+',
                                        label: 'Neural Inputs',
                                        color: Colors.white,
                                      ),
                                      Container(
                                        width: 1,
                                        height: 40,
                                        color: const Color(0xFF4FC3F7)
                                            .withAlpha(77),
                                      ),
                                      _NeuralStatItem(
                                        value: '50K+',
                                        label: 'Processed Data',
                                        color: Colors.white,
                                      ),
                                      Container(
                                        width: 1,
                                        height: 40,
                                        color: const Color(0xFF4FC3F7)
                                            .withAlpha(77),
                                      ),
                                      _NeuralStatItem(
                                        value: '99%',
                                        label: 'AI Accuracy',
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Right card - Enhanced Auth Form
                        SlideTransition(
                          position: _rightSlideAnimation,
                          child: Container(
                            width: 440,
                            padding: const EdgeInsets.all(48),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(13),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                color: const Color(0xFF4FC3F7).withAlpha(52),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(77),
                                  blurRadius: 30,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                    colors: [
                                      Color(0xFF4FC3F7),
                                      Color(0xFF7C4DFF)
                                    ],
                                  ).createShader(bounds),
                                  child: Text(
                                    headerText,
                                    textAlign: TextAlign.center,
                                    style: textTheme.headlineMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  subHeaderText,
                                  textAlign: TextAlign.center,
                                  style: textTheme.bodyLarge?.copyWith(
                                    color: Colors.white.withAlpha(178),
                                    height: 1.4,
                                  ),
                                ),
                                const SizedBox(height: 40),
                                AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 400),
                                  transitionBuilder: (child, animation) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: SlideTransition(
                                        position: Tween<Offset>(
                                          begin: const Offset(0.1, 0),
                                          end: Offset.zero,
                                        ).animate(animation),
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: currentForm,
                                ),
                                if (widget.state.errorMessage != null)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 20.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withAlpha(26),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Colors.red.withAlpha(77),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.error_outline_rounded,
                                            color: Colors.red.shade300,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              widget.state.errorMessage!,
                                              style: TextStyle(
                                                color: Colors.red.shade300,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ],
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

// ENHANCED FORM WIDGETS WITH NEURAL THEME

class _SignInForm extends ConsumerStatefulWidget {
  const _SignInForm();

  @override
  ConsumerState<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<_SignInForm>
    with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      HapticFeedback.lightImpact();
      ref.read(authScreenProvider.notifier).handleSignIn(
            _emailController.text.trim(),
            _passwordController.text.trim(),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authScreenProvider);

    return Form(
      key: _formKey,
      child: Column(
        key: const ValueKey('signInForm'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email Field
          _NeuralTextField(
            controller: _emailController,
            labelText: 'Neural ID',
            hintText: 'Enter your neural identifier',
            prefixIcon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Neural ID is required';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value!)) {
                return 'Enter a valid neural identifier';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Password Field
          _NeuralTextField(
            controller: _passwordController,
            labelText: 'Neural Key',
            hintText: 'Enter your neural access key',
            prefixIcon: Icons.key_rounded,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white.withAlpha(178),
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Neural key is required';
              if (value!.length < 6) {
                return 'Neural key must be at least 6 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          // Neural Access Button
          _NeuralButton(
            onPressed: state.isLoading ? null : _submit,
            isLoading: state.isLoading,
            text: 'Activate Neural Access',
            icon: Icons.psychology_rounded,
            controller: _buttonController,
          ),
          const SizedBox(height: 16),

          // Switch to Sign Up
          TextButton(
            onPressed: state.isLoading
                ? null
                : () {
                    HapticFeedback.lightImpact();
                    ref
                        .read(authScreenProvider.notifier)
                        .setMode(AuthMode.signUp);
                  },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                    text: "Need neural registration? ",
                    style: TextStyle(color: Colors.white.withAlpha(178)),
                  ),
                  const TextSpan(
                    text: "Initialize Profile",
                    style: TextStyle(
                      color: Color(0xFF4FC3F7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignUpForm extends ConsumerStatefulWidget {
  const _SignUpForm();

  @override
  ConsumerState<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<_SignUpForm>
    with SingleTickerProviderStateMixin {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  late AnimationController _buttonController;

  static String passwordForVerification = '';

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      HapticFeedback.lightImpact();
      passwordForVerification = _passwordController.text.trim();
      ref.read(authScreenProvider.notifier).handleSignUpRequest(
            _usernameController.text.trim(),
            _emailController.text.trim(),
            passwordForVerification,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authScreenProvider);

    return Form(
      key: _formKey,
      child: Column(
        key: const ValueKey('signUpForm'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Username Field
          _NeuralTextField(
            controller: _usernameController,
            labelText: 'Neural Alias',
            hintText: 'Choose your neural alias',
            prefixIcon: Icons.person_outline_rounded,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Neural alias is required';
              if (value!.length < 3) {
                return 'Neural alias must be at least 3 characters';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Email Field
          _NeuralTextField(
            controller: _emailController,
            labelText: 'Neural ID',
            hintText: 'Enter your neural identifier',
            prefixIcon: Icons.alternate_email_rounded,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Neural ID is required';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                  .hasMatch(value!)) {
                return 'Enter a valid neural identifier';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          // Password Field
          _NeuralTextField(
            controller: _passwordController,
            labelText: 'Neural Key',
            hintText: 'Create a secure neural key',
            prefixIcon: Icons.key_rounded,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Colors.white.withAlpha(178),
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) return 'Neural key is required';
              if (value!.length < 8) {
                return 'Neural key must be at least 8 characters';
              }
              if (!RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)').hasMatch(value)) {
                return 'Neural key must contain uppercase, lowercase, and number';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),

          // Initialize Neural Profile Button
          _NeuralButton(
            onPressed: state.isLoading ? null : _submit,
            isLoading: state.isLoading,
            text: 'Initialize Neural Profile',
            icon: Icons.psychology_rounded,
            controller: _buttonController,
          ),
          const SizedBox(height: 16),

          // Switch to Sign In
          TextButton(
            onPressed: state.isLoading
                ? null
                : () {
                    HapticFeedback.lightImpact();
                    ref
                        .read(authScreenProvider.notifier)
                        .setMode(AuthMode.signIn);
                  },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 16),
                children: [
                  TextSpan(
                    text: "Already have neural access? ",
                    style: TextStyle(color: Colors.white.withAlpha(178)),
                  ),
                  const TextSpan(
                    text: "Connect Now",
                    style: TextStyle(
                      color: Color(0xFF4FC3F7),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _VerifyEmailForm extends ConsumerStatefulWidget {
  const _VerifyEmailForm();

  @override
  ConsumerState<_VerifyEmailForm> createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends ConsumerState<_VerifyEmailForm>
    with SingleTickerProviderStateMixin {
  final _codeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late AnimationController _buttonController;

  @override
  void initState() {
    super.initState();
    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _codeController.dispose();
    _buttonController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      HapticFeedback.lightImpact();
      final state = ref.read(authScreenProvider);
      ref.read(authScreenProvider.notifier).handleVerification(
            _codeController.text.trim(),
            state.emailForVerification,
            _SignUpFormState.passwordForVerification,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authScreenProvider);

    return Form(
      key: _formKey,
      child: Column(
        key: const ValueKey('verifyForm'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Neural Verification Info Container
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4FC3F7),
                  Color(0xFF7C4DFF),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4FC3F7).withAlpha(77),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.mark_email_read_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Neural Verification Required',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Neural code sent to ${state.emailForVerification}',
                        style: TextStyle(
                          color: Colors.white.withAlpha(229),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Neural Verification Code Field
          TextFormField(
            controller: _codeController,
            decoration: InputDecoration(
              labelText: 'Neural Verification Code',
              labelStyle: TextStyle(color: Colors.white.withAlpha(178)),
              hintText: '000000',
              hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
              prefixIcon: const Icon(
                Icons.security_rounded,
                color: Color(0xFF4FC3F7),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: const Color(0xFF4FC3F7).withAlpha(77),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: const Color(0xFF4FC3F7).withAlpha(77),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xFF4FC3F7),
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: Colors.white.withAlpha(13),
            ),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              letterSpacing: 8,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 6,
            buildCounter: (context,
                    {required currentLength, required isFocused, maxLength}) =>
                null,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Neural verification code is required';
              }
              if (value!.length != 6) return 'Code must be 6 digits';
              return null;
            },
          ),
          const SizedBox(height: 32),

          // Verify Neural Connection Button
          _NeuralButton(
            onPressed: state.isLoading ? null : _submit,
            isLoading: state.isLoading,
            text: 'Verify Neural Connection',
            icon: Icons.verified_user_rounded,
            controller: _buttonController,
          ),
          const SizedBox(height: 16),

          // Back to Neural Access
          TextButton(
            onPressed: state.isLoading
                ? null
                : () {
                    HapticFeedback.lightImpact();
                    ref
                        .read(authScreenProvider.notifier)
                        .setMode(AuthMode.signIn);
                  },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              "Back to Neural Access",
              style: TextStyle(
                color: Color(0xFF4FC3F7),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// NEURAL HELPER WIDGETS

class _NeuralTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  const _NeuralTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });

  @override
  State<_NeuralTextField> createState() => _NeuralTextFieldState();
}

class _NeuralTextFieldState extends State<_NeuralTextField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _focusAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _focusAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
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
      animation: _focusAnimation,
      builder: (context, child) {
        return TextFormField(
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          validator: widget.validator,
          style: const TextStyle(color: Colors.white),
          onTap: () {
            if (!_isFocused) {
              setState(() => _isFocused = true);
              _controller.forward();
            }
          },
          onTapOutside: (_) {
            if (_isFocused) {
              setState(() => _isFocused = false);
              _controller.reverse();
            }
          },
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: TextStyle(
              color: _isFocused
                  ? const Color(0xFF4FC3F7)
                  : Colors.white.withAlpha(178),
            ),
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.white.withAlpha(128)),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: _isFocused
                  ? const Color(0xFF4FC3F7)
                  : Colors.white.withAlpha(178),
            ),
            suffixIcon: widget.suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: const Color(0xFF4FC3F7).withAlpha(77),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: const Color(0xFF4FC3F7).withAlpha(77),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF4FC3F7),
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.red.shade300,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: Colors.red.shade300,
                width: 2,
              ),
            ),
            filled: true,
            fillColor: Color.lerp(
              Colors.white.withAlpha(13),
              const Color(0xFF4FC3F7).withAlpha(26),
              _focusAnimation.value,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        );
      },
    );
  }
}

class _NeuralButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final String text;
  final IconData icon;
  final AnimationController controller;

  const _NeuralButton({
    required this.onPressed,
    required this.isLoading,
    required this.text,
    required this.icon,
    required this.controller,
  });

  @override
  State<_NeuralButton> createState() => _NeuralButtonState();
}

class _NeuralButtonState extends State<_NeuralButton> {
  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: Tween<double>(begin: 1.0, end: 0.98).animate(
        CurvedAnimation(parent: widget.controller, curve: Curves.easeInOut),
      ),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          gradient: widget.onPressed != null
              ? const LinearGradient(
                  colors: [
                    Color(0xFF4FC3F7),
                    Color(0xFF7C4DFF),
                  ],
                )
              : null,
          color: widget.onPressed == null ? Colors.white.withAlpha(26) : null,
          borderRadius: BorderRadius.circular(16),
          boxShadow: widget.onPressed != null
              ? [
                  BoxShadow(
                    color: const Color(0xFF4FC3F7).withAlpha(104),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            onTapDown: widget.onPressed != null
                ? (_) => widget.controller.forward()
                : null,
            onTapUp: widget.onPressed != null
                ? (_) => widget.controller.reverse()
                : null,
            onTapCancel: widget.onPressed != null
                ? () => widget.controller.reverse()
                : null,
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: widget.isLoading
                  ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          widget.icon,
                          color: widget.onPressed != null
                              ? Colors.white
                              : Colors.white.withAlpha(128),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          widget.text,
                          style: TextStyle(
                            color: widget.onPressed != null
                                ? Colors.white
                                : Colors.white.withAlpha(128),
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NeuralFeaturePill extends StatelessWidget {
  final IconData icon;
  final String label;

  const _NeuralFeaturePill({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF4FC3F7),
            Color(0xFF7C4DFF),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4FC3F7).withAlpha(77),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _NeuralFeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const _NeuralFeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF4FC3F7).withAlpha(52),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF4FC3F7),
                  Color(0xFF7C4DFF),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4FC3F7).withAlpha(77),
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    color: color.withAlpha(204),
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NeuralStatItem extends StatelessWidget {
  final String value;
  final String label;
  final Color color;

  const _NeuralStatItem({
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
          ).createShader(bounds),
          child: Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: color.withAlpha(204),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
