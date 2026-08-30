import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LandingPage extends StatefulWidget {
  final VoidCallback? onGetStarted;
  final VoidCallback? onSignIn;

  const LandingPage({
    super.key,
    this.onGetStarted,
    this.onSignIn,
  });

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with TickerProviderStateMixin {
  late AnimationController _heroController;
  late AnimationController _particleController;
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  late Animation<double> _heroFadeAnimation;
  late Animation<Offset> _heroSlideAnimation;
  late Animation<double> _particleAnimation;

  bool _showAppBar = false;

  @override
  void initState() {
    super.initState();

    _heroController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _heroFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _heroController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _heroSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _heroController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOutCubic),
      ),
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.linear),
    );

    // Start animations
    _heroController.forward();
    _particleController.repeat();

    // Auto-focus for keyboard navigation
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    final showAppBar = _scrollController.offset > 100;
    if (showAppBar != _showAppBar) {
      setState(() {
        _showAppBar = showAppBar;
      });
    }
  }

  @override
  void dispose() {
    _heroController.dispose();
    _particleController.dispose();
    _scrollController.dispose();
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

    return Focus(
      focusNode: _focusNode,
      onKeyEvent: _handleKeyEvent,
      child: Scaffold(
        backgroundColor: const Color(0xFF0A0E1A),
        body: Stack(
          children: [
            // Animated Background
            AnimatedBuilder(
              animation: _particleAnimation,
              builder: (context, child) {
                return CustomPaint(
                  painter: ParticleBackgroundPainter(_particleAnimation.value),
                  size: Size.infinite,
                );
              },
            ),

            // Main Content
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                // Floating App Bar
                SliverAppBar(
                  expandedHeight: 0,
                  floating: true,
                  pinned: true,
                  backgroundColor: _showAppBar
                      ? const Color(0xFF0A0E1A).withAlpha(242)
                      : Colors.transparent,
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  flexibleSpace: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity: _showAppBar ? 1.0 : 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF0A0E1A).withAlpha(242),
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.white.withAlpha(26),
                            width: 1,
                          ),
                        ),
                      ),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Row(
                            children: [
                              // Logo
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          const Color(0xFF4A90E2).withAlpha(77),
                                      blurRadius: 12,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    'assets/logo.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Studium AI',
                                style: theme.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              const Spacer(),
                              _ModernButton(
                                text: 'Sign In',
                                onPressed: widget.onSignIn,
                                isOutlined: true,
                              ),
                              const SizedBox(width: 12),
                              _ModernButton(
                                text: 'Get Started',
                                onPressed: widget.onGetStarted,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // Hero Section
                SliverToBoxAdapter(
                  child: _ModernHeroSection(
                    fadeAnimation: _heroFadeAnimation,
                    slideAnimation: _heroSlideAnimation,
                    onGetStarted: widget.onGetStarted,
                    onSignIn: widget.onSignIn,
                  ),
                ),

                // Features Section
                const SliverToBoxAdapter(
                  child: _ModernFeaturesSection(),
                ),

                // Benefits Section
                const SliverToBoxAdapter(
                  child: _BenefitsSection(),
                ),

                // Social Proof Section
                const SliverToBoxAdapter(
                  child: _SocialProofSection(),
                ),

                // CTA Section
                SliverToBoxAdapter(
                  child: _ModernCTASection(
                    onGetStarted: widget.onGetStarted,
                  ),
                ),

                // Footer
                const SliverToBoxAdapter(
                  child: _ModernFooter(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ParticleBackgroundPainter extends CustomPainter {
  final double animationValue;

  ParticleBackgroundPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4A90E2).withAlpha(26)
      ..strokeWidth = 1;

    // Draw animated neural network connections
    for (int i = 0; i < 20; i++) {
      final x1 = (size.width * 0.1) + (i * size.width * 0.04);
      final y1 = size.height * 0.2 +
          (50 * (i % 3)) +
          (20 * sin(animationValue * 2 * 3.14159));

      final x2 =
          x1 + 100 + (30 * cos((animationValue + i * 0.1) * 2 * 3.14159));
      final y2 =
          y1 + 80 + (40 * sin((animationValue + i * 0.15) * 2 * 3.14159));

      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);

      // Draw nodes
      canvas.drawCircle(
        Offset(x1, y1),
        3 + (2 * sin((animationValue + i * 0.2) * 2 * 3.14159).abs()),
        paint..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ModernHeroSection extends StatefulWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final VoidCallback? onGetStarted;
  final VoidCallback? onSignIn;

  const _ModernHeroSection({
    required this.fadeAnimation,
    required this.slideAnimation,
    this.onGetStarted,
    this.onSignIn,
  });

  @override
  State<_ModernHeroSection> createState() => _ModernHeroSectionState();
}

class _ModernHeroSectionState extends State<_ModernHeroSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoRotation;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );
    _logoRotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.linear),
    );
    _logoController.repeat();
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    final isTablet = size.width > 768;

    return Container(
      constraints: BoxConstraints(
        minHeight: size.height - (isDesktop ? 80 : 0),
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
            vertical: isDesktop ? 80 : 40,
          ),
          child: isDesktop
              ? _DesktopHeroLayout(
                  fadeAnimation: widget.fadeAnimation,
                  slideAnimation: widget.slideAnimation,
                  logoRotation: _logoRotation,
                  onGetStarted: widget.onGetStarted,
                  onSignIn: widget.onSignIn,
                )
              : _MobileHeroLayout(
                  fadeAnimation: widget.fadeAnimation,
                  slideAnimation: widget.slideAnimation,
                  logoRotation: _logoRotation,
                  onGetStarted: widget.onGetStarted,
                  onSignIn: widget.onSignIn,
                ),
        ),
      ),
    );
  }
}

class _DesktopHeroLayout extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final Animation<double> logoRotation;
  final VoidCallback? onGetStarted;
  final VoidCallback? onSignIn;

  const _DesktopHeroLayout({
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.logoRotation,
    this.onGetStarted,
    this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        // Left Content
        Expanded(
          flex: 5,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: SlideTransition(
              position: slideAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Navigation
                  Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF4A90E2).withAlpha(77),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        'Studium AI',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      _ModernButton(
                        text: 'Sign In',
                        onPressed: onSignIn,
                        isOutlined: true,
                      ),
                      const SizedBox(width: 16),
                      _ModernButton(
                        text: 'Get Started',
                        onPressed: onGetStarted,
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),

                  // Main Headline
                  RichText(
                    text: TextSpan(
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        height: 1.1,
                        color: Colors.white,
                        fontSize: 64,
                      ),
                      children: [
                        const TextSpan(text: 'AI-Powered\n'),
                        TextSpan(
                          text: 'Learning',
                          style: TextStyle(
                            foreground: Paint()
                              ..shader = const LinearGradient(
                                colors: [
                                  Color(0xFF4A90E2),
                                  Color(0xFF7B68EE),
                                  Color(0xFF9B59B6),
                                ],
                              ).createShader(
                                  const Rect.fromLTWH(0, 0, 300, 100)),
                          ),
                        ),
                        const TextSpan(text: '\nRevolution'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Subtitle
                  Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Text(
                      'Transform any document into interactive learning experiences. Generate smart summaries, personalized quizzes, and AI-assisted academic writing in seconds.',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white.withAlpha(204),
                        height: 1.6,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),

                  // CTA Buttons
                  Row(
                    children: [
                      _HeroCTAButton(
                        text: 'Start Free Trial',
                        onPressed: onGetStarted,
                        isPrimary: true,
                      ),
                      const SizedBox(width: 20),
                      _HeroCTAButton(
                        text: 'Watch Demo',
                        onPressed: () {},
                        isPrimary: false,
                        icon: Icons.play_circle_outline_rounded,
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Trust Indicators
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withAlpha(26),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.green.withAlpha(77),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified_rounded,
                              color: Colors.green.shade400,
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Trusted by 50,000+ students',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.green.shade400,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: List.generate(
                          5,
                          (index) => Icon(
                            Icons.star_rounded,
                            color: Colors.amber.shade400,
                            size: 20,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '4.9/5 rating',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withAlpha(182),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: 80),

        // Right Visual
        Expanded(
          flex: 4,
          child: FadeTransition(
            opacity: fadeAnimation,
            child: AnimatedBuilder(
              animation: logoRotation,
              builder: (context, child) {
                return _ModernHeroVisual(logoRotation: logoRotation);
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _MobileHeroLayout extends StatelessWidget {
  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final Animation<double> logoRotation;
  final VoidCallback? onGetStarted;
  final VoidCallback? onSignIn;

  const _MobileHeroLayout({
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.logoRotation,
    this.onGetStarted,
    this.onSignIn,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final isTablet = size.width > 768;

    return Column(
      children: [
        // Navigation
        FadeTransition(
          opacity: fadeAnimation,
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A90E2).withAlpha(77),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Studium AI',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Spacer(),
              if (isTablet) ...[
                _ModernButton(
                  text: 'Sign In',
                  onPressed: onSignIn,
                  isOutlined: true,
                ),
                const SizedBox(width: 12),
                _ModernButton(
                  text: 'Get Started',
                  onPressed: onGetStarted,
                ),
              ] else
                IconButton(
                  onPressed: onSignIn,
                  icon: const Icon(
                    Icons.person_outline_rounded,
                    color: Colors.white,
                  ),
                ),
            ],
          ),
        ),

        SizedBox(height: isTablet ? 80 : 60),

        // Visual (Mobile First)
        FadeTransition(
          opacity: fadeAnimation,
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isTablet ? 400 : 300,
              maxHeight: isTablet ? 300 : 200,
            ),
            child: AnimatedBuilder(
              animation: logoRotation,
              builder: (context, child) {
                return _ModernHeroVisual(logoRotation: logoRotation);
              },
            ),
          ),
        ),

        SizedBox(height: isTablet ? 60 : 40),

        // Content
        FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position: slideAnimation,
            child: Column(
              children: [
                // Main Headline
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                      color: Colors.white,
                    ),
                    children: [
                      const TextSpan(text: 'AI-Powered\n'),
                      TextSpan(
                        text: 'Learning',
                        style: TextStyle(
                          foreground: Paint()
                            ..shader = const LinearGradient(
                              colors: [
                                Color(0xFF4A90E2),
                                Color(0xFF7B68EE),
                                Color(0xFF9B59B6),
                              ],
                            ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                        ),
                      ),
                      const TextSpan(text: '\nRevolution'),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Subtitle
                Text(
                  'Transform any document into interactive learning experiences with AI-powered tools.',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white.withAlpha(204),
                    height: 1.5,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 40),

                // CTA Buttons
                if (isTablet)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _HeroCTAButton(
                        text: 'Start Free Trial',
                        onPressed: onGetStarted,
                        isPrimary: true,
                      ),
                      const SizedBox(width: 16),
                      _HeroCTAButton(
                        text: 'Watch Demo',
                        onPressed: () {},
                        isPrimary: false,
                        icon: Icons.play_circle_outline_rounded,
                      ),
                    ],
                  )
                else
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: _HeroCTAButton(
                          text: 'Start Free Trial',
                          onPressed: onGetStarted,
                          isPrimary: true,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        child: _HeroCTAButton(
                          text: 'Watch Demo',
                          onPressed: () {},
                          isPrimary: false,
                          icon: Icons.play_circle_outline_rounded,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 32),

                // Trust Indicators
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withAlpha(26),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.green.withAlpha(77),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.verified_rounded,
                            color: Colors.green.shade400,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Trusted by 50,000+ students',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.green.shade400,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ...List.generate(
                          5,
                          (index) => Icon(
                            Icons.star_rounded,
                            color: Colors.amber.shade400,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '4.9/5 rating',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withAlpha(182),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ModernHeroVisual extends StatelessWidget {
  final Animation<double> logoRotation;

  const _ModernHeroVisual({required this.logoRotation});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90E2).withAlpha(77),
            blurRadius: 40,
            offset: const Offset(0, 20),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glowing Background
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF4A90E2).withAlpha(52),
                  const Color(0xFF7B68EE).withAlpha(26),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Rotating Rings
          Transform.rotate(
            angle: logoRotation.value * 2 * 3.14159,
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF4A90E2).withAlpha(77),
                  width: 2,
                ),
              ),
            ),
          ),

          Transform.rotate(
            angle: -logoRotation.value * 2 * 3.14159 * 0.7,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF7B68EE).withAlpha(77),
                  width: 2,
                ),
              ),
            ),
          ),

          // Central Logo
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4A90E2).withAlpha(102),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF1A1A2E),
                      Color(0xFF16213E),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Image.asset(
                  'assets/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // Floating Particles
          ...List.generate(8, (index) {
            final angle = (index * 45) * (3.14159 / 180);
            final radius = 150.0;
            final x = radius * cos(angle + logoRotation.value * 2 * 3.14159);
            final y = radius * sin(angle + logoRotation.value * 2 * 3.14159);

            return Transform.translate(
              offset: Offset(x, y),
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF4A90E2).withAlpha(152),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF4A90E2).withAlpha(77),
                      blurRadius: 8,
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}

class _ModernFeaturesSection extends StatelessWidget {
  const _ModernFeaturesSection();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    final isTablet = size.width > 768;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
        vertical: isDesktop ? 120 : 80,
      ),
      child: Column(
        children: [
          // Section Header
          Text(
            'Powerful AI Features',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 48 : (isTablet ? 36 : 32),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Everything you need to transform your study materials into interactive learning experiences',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isDesktop ? 20 : 18,
                color: Colors.white.withAlpha(182),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 80),

          // Features Grid
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _ModernFeatureCard(
                    icon: Icons.auto_awesome_rounded,
                    title: 'Smart Summaries',
                    description:
                        'AI extracts key concepts and creates comprehensive summaries from any document in seconds.',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _ModernFeatureCard(
                    icon: Icons.quiz_rounded,
                    title: 'Adaptive Quizzes',
                    description:
                        'Generate personalized quizzes that adapt to your learning pace and knowledge level.',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF7B68EE), Color(0xFF6A5ACD)],
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                Expanded(
                  child: _ModernFeatureCard(
                    icon: Icons.edit_note_rounded,
                    title: 'AI Writing Assistant',
                    description:
                        'Get intelligent writing suggestions and generate academic papers with proper citations.',
                    gradient: const LinearGradient(
                      colors: [Color(0xFF9B59B6), Color(0xFF8E44AD)],
                    ),
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                _ModernFeatureCard(
                  icon: Icons.auto_awesome_rounded,
                  title: 'Smart Summaries',
                  description:
                      'AI extracts key concepts and creates comprehensive summaries from any document in seconds.',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF4A90E2), Color(0xFF357ABD)],
                  ),
                ),
                const SizedBox(height: 32),
                _ModernFeatureCard(
                  icon: Icons.quiz_rounded,
                  title: 'Adaptive Quizzes',
                  description:
                      'Generate personalized quizzes that adapt to your learning pace and knowledge level.',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF7B68EE), Color(0xFF6A5ACD)],
                  ),
                ),
                const SizedBox(height: 32),
                _ModernFeatureCard(
                  icon: Icons.edit_note_rounded,
                  title: 'AI Writing Assistant',
                  description:
                      'Get intelligent writing suggestions and generate academic papers with proper citations.',
                  gradient: const LinearGradient(
                    colors: [Color(0xFF9B59B6), Color(0xFF8E44AD)],
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _ModernFeatureCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String description;
  final Gradient gradient;

  const _ModernFeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradient,
  });

  @override
  State<_ModernFeatureCard> createState() => _ModernFeatureCardState();
}

class _ModernFeatureCardState extends State<_ModernFeatureCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> glowAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
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
    return MouseRegion(
      onEnter: (_) {
        setState(() => _isHovered = true);
        _controller.forward();
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _controller.reverse();
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1A1A2E).withAlpha(204),
                    const Color(0xFF16213E).withAlpha(229),
                  ],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: Colors.white.withAlpha(26),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(52),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                  if (_isHovered)
                    BoxShadow(
                      color: (widget.gradient.colors.first).withAlpha(77),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: widget.gradient,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: widget.gradient.colors.first.withAlpha(102),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Title
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Description
                  Text(
                    widget.description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withAlpha(182),
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BenefitsSection extends StatelessWidget {
  const _BenefitsSection();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    final isTablet = size.width > 768;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
        vertical: isDesktop ? 120 : 80,
      ),
      child: Column(
        children: [
          Text(
            'Why Choose Studium AI?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 48 : (isTablet ? 36 : 32),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 80),
          if (isDesktop)
            Row(
              children: [
                Expanded(
                  child: _BenefitItem(
                    icon: Icons.speed_rounded,
                    title: '10x Faster Learning',
                    description:
                        'Process information 10 times faster than traditional methods',
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: _BenefitItem(
                    icon: Icons.psychology_rounded,
                    title: 'Personalized Experience',
                    description: 'AI adapts to your learning style and pace',
                  ),
                ),
                const SizedBox(width: 40),
                Expanded(
                  child: _BenefitItem(
                    icon: Icons.trending_up_rounded,
                    title: 'Better Retention',
                    description: 'Improve knowledge retention by up to 85%',
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                _BenefitItem(
                  icon: Icons.speed_rounded,
                  title: '10x Faster Learning',
                  description:
                      'Process information 10 times faster than traditional methods',
                ),
                const SizedBox(height: 40),
                _BenefitItem(
                  icon: Icons.psychology_rounded,
                  title: 'Personalized Experience',
                  description: 'AI adapts to your learning style and pace',
                ),
                const SizedBox(height: 40),
                _BenefitItem(
                  icon: Icons.trending_up_rounded,
                  title: 'Better Retention',
                  description: 'Improve knowledge retention by up to 85%',
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _BenefitItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4A90E2).withAlpha(77),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 50,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withAlpha(182),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _SocialProofSection extends StatelessWidget {
  const _SocialProofSection();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    final isTablet = size.width > 768;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
        vertical: isDesktop ? 120 : 80,
      ),
      child: Column(
        children: [
          Text(
            'Loved by Students Worldwide',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 48 : (isTablet ? 36 : 32),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 80),

          // Stats Row
          if (isDesktop)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _StatItem(value: '50K+', label: 'Active Students'),
                _StatItem(value: '1M+', label: 'Documents Processed'),
                _StatItem(value: '99.2%', label: 'Accuracy Rate'),
                _StatItem(value: '4.9★', label: 'User Rating'),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child:
                            _StatItem(value: '50K+', label: 'Active Students')),
                    const SizedBox(width: 20),
                    Expanded(
                        child: _StatItem(
                            value: '1M+', label: 'Documents Processed')),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                        child:
                            _StatItem(value: '99.2%', label: 'Accuracy Rate')),
                    const SizedBox(width: 20),
                    Expanded(
                        child: _StatItem(value: '4.9★', label: 'User Rating')),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white.withAlpha(182),
          ),
        ),
      ],
    );
  }
}

class _ModernCTASection extends StatelessWidget {
  final VoidCallback? onGetStarted;

  const _ModernCTASection({this.onGetStarted});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    final isTablet = size.width > 768;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
        vertical: isDesktop ? 120 : 80,
      ),
      padding: EdgeInsets.all(isDesktop ? 80 : (isTablet ? 60 : 40)),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4A90E2),
            Color(0xFF7B68EE),
            Color(0xFF9B59B6),
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4A90E2).withAlpha(77),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            'Ready to Transform Your Learning?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 48 : (isTablet ? 36 : 32),
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Text(
              'Join thousands of students who are already learning smarter with AI. Start your free trial today.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: isDesktop ? 20 : 18,
                color: Colors.white.withAlpha(229),
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 40),
          _ModernCTAButton(
            text: 'Start Free Trial',
            onPressed: onGetStarted,
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.security_rounded,
                color: Colors.white.withAlpha(204),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                'No credit card required • Cancel anytime',
                style: TextStyle(
                  color: Colors.white.withAlpha(204),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ModernFooter extends StatelessWidget {
  const _ModernFooter();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width > 1200;
    final isTablet = size.width > 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 80 : (isTablet ? 40 : 24),
        vertical: isDesktop ? 80 : 60,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0F23),
        border: Border(
          top: BorderSide(
            color: Colors.white.withAlpha(26),
          ),
        ),
      ),
      child: Column(
        children: [
          if (isDesktop)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo and Description
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                'assets/logo.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text(
                            'Studium AI',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Transform your study materials into interactive learning experiences with AI-powered tools.',
                        style: TextStyle(
                          color: Colors.white.withAlpha(182),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Links
                Expanded(
                  child: _FooterColumn(
                    title: 'Product',
                    links: ['Features', 'Pricing', 'API', 'Integrations'],
                  ),
                ),
                Expanded(
                  child: _FooterColumn(
                    title: 'Company',
                    links: ['About', 'Blog', 'Careers', 'Contact'],
                  ),
                ),
                Expanded(
                  child: _FooterColumn(
                    title: 'Support',
                    links: [
                      'Help Center',
                      'Documentation',
                      'Community',
                      'Status'
                    ],
                  ),
                ),
              ],
            )
          else
            Column(
              children: [
                // Logo
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset(
                          'assets/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Studium AI',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Links
                if (isTablet)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: _FooterColumn(
                          title: 'Product',
                          links: ['Features', 'Pricing', 'API'],
                        ),
                      ),
                      Expanded(
                        child: _FooterColumn(
                          title: 'Company',
                          links: ['About', 'Blog', 'Contact'],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _FooterLink(
                        text: 'Features',
                        onPressed: () {},
                      ),
                      _FooterLink(
                        text: 'Pricing',
                        onPressed: () {},
                      ),
                      _FooterLink(
                        text: 'About',
                        onPressed: () {},
                      ),
                      _FooterLink(
                        text: 'Contact',
                        onPressed: () {},
                      ),
                    ],
                  ),
              ],
            ),

          const SizedBox(height: 40),

          // Bottom Section
          Container(
            padding: const EdgeInsets.only(top: 24),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.white.withAlpha(26),
                ),
              ),
            ),
            child: isDesktop
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '© 2024 Studium AI. All rights reserved.',
                        style: TextStyle(
                          color: Colors.white.withAlpha(182),
                        ),
                      ),
                      Row(
                        children: [
                          _FooterLink(
                            text: 'Privacy Policy',
                            onPressed: () {},
                          ),
                          const SizedBox(width: 24),
                          _FooterLink(
                            text: 'Terms of Service',
                            onPressed: () {},
                          ),
                          const SizedBox(width: 24),
                          _FooterLink(
                            text: 'Cookie Policy',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  )
                : Column(
                    children: [
                      Text(
                        '© 2024 Studium AI. All rights reserved.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white.withAlpha(182),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _FooterLink(
                            text: 'Privacy',
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16),
                          _FooterLink(
                            text: 'Terms',
                            onPressed: () {},
                          ),
                          const SizedBox(width: 16),
                          _FooterLink(
                            text: 'Cookies',
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}

class _FooterColumn extends StatelessWidget {
  final String title;
  final List<String> links;

  const _FooterColumn({
    required this.title,
    required this.links,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 16),
        ...links.map((link) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _FooterLink(
                text: link,
                onPressed: () {},
              ),
            )),
      ],
    );
  }
}

// HELPER WIDGETS

class _ModernButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutlined;

  const _ModernButton({
    required this.text,
    this.onPressed,
    this.isOutlined = false,
  });

  @override
  State<_ModernButton> createState() => _ModernButtonState();
}

class _ModernButtonState extends State<_ModernButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        height: 44,
        decoration: BoxDecoration(
          gradient: widget.isOutlined
              ? null
              : const LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
                ),
          border: widget.isOutlined
              ? Border.all(color: Colors.white.withAlpha(77))
              : null,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.onPressed,
            onTapDown: (_) => _controller.forward(),
            onTapUp: (_) => _controller.reverse(),
            onTapCancel: () => _controller.reverse(),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Center(
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HeroCTAButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final IconData? icon;

  const _HeroCTAButton({
    required this.text,
    this.onPressed,
    required this.isPrimary,
    this.icon,
  });

  @override
  State<_HeroCTAButton> createState() => _HeroCTAButtonState();
}

class _HeroCTAButtonState extends State<_HeroCTAButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          gradient: widget.isPrimary
              ? const LinearGradient(
                  colors: [Color(0xFF4A90E2), Color(0xFF7B68EE)],
                )
              : null,
          color: widget.isPrimary ? null : Colors.white.withAlpha(26),
          border: widget.isPrimary
              ? null
              : Border.all(color: Colors.white.withAlpha(77)),
          borderRadius: BorderRadius.circular(16),
          boxShadow: widget.isPrimary
              ? [
                  BoxShadow(
                    color: const Color(0xFF4A90E2).withAlpha(102),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              widget.onPressed?.call();
            },
            onTapDown: (_) => _controller.forward(),
            onTapUp: (_) => _controller.reverse(),
            onTapCancel: () => _controller.reverse(),
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                  ],
                  Text(
                    widget.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
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

class _ModernCTAButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;

  const _ModernCTAButton({
    required this.text,
    this.onPressed,
  });

  @override
  State<_ModernCTAButton> createState() => _ModernCTAButtonState();
}

class _ModernCTAButtonState extends State<_ModernCTAButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.98).animate(
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(52),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              HapticFeedback.lightImpact();
              widget.onPressed?.call();
            },
            onTapDown: (_) => _controller.forward(),
            onTapUp: (_) => _controller.reverse(),
            onTapCancel: () => _controller.reverse(),
            borderRadius: BorderRadius.circular(16),
            child: Center(
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Color(0xFF4A90E2),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const _FooterLink({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white.withAlpha(182),
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
