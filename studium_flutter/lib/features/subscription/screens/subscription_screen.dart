import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'dart:math' as math;
import '../../../core/layout/responsive.dart';
import '../../../core/providers/service_providers.dart';
import '../../dashboard/providers/dashboard_provider.dart';
import '../../profile/providers/profile_provider.dart';
import '../providers/subscription_provider.dart';

class SubscriptionScreen extends ConsumerStatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  ConsumerState<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends ConsumerState<SubscriptionScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _neuralController;
  late AnimationController _logoController;
  late AnimationController _pulseController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _neuralAnimation;
  late Animation<double> _logoRotation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _neuralController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _logoController = AnimationController(
      duration: const Duration(seconds: 8),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _neuralAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _neuralController, curve: Curves.easeInOut),
    );

    _logoRotation = Tween<double>(begin: 0, end: 2 * math.pi).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.linear),
    );

    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _slideController.forward();
    _neuralController.repeat();
    _logoController.repeat();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _neuralController.dispose();
    _logoController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SubscriptionState>(subscriptionProvider, (previous, next) {
      if (next.status == SubscriptionStatus.success) {
        ref.invalidate(profileProvider);
        ref.invalidate(dashboardProvider);
        _showNeuralSuccessDialog();
      }
      if (next.status == SubscriptionStatus.error &&
          next.errorMessage != null) {
        _showNeuralErrorSnackBar(next.errorMessage!);
      }
    });

    const neuralBenefits = [
      NeuralBenefitItem(
        icon: Icons.psychology_rounded,
        title: 'Unlimited Neural Quizzes',
        description:
            'Generate up to 50 AI-powered questions per neural quiz session',
        neuralLevel: 'Advanced',
      ),
      NeuralBenefitItem(
        icon: Icons.auto_awesome_rounded,
        title: 'All Neural Question Types',
        description:
            'Access Essay, Fill-in-the-blank, Multiple Choice, and Neural Analysis',
        neuralLevel: 'Premium',
      ),
      NeuralBenefitItem(
        icon: Icons.compare_arrows_rounded,
        title: 'Neural Research Comparisons',
        description:
            'Generate detailed comparative analyses with AI neural processing',
        neuralLevel: 'Elite',
      ),
      NeuralBenefitItem(
        icon: Icons.article_rounded,
        title: 'Full Neural Academic Writing',
        description:
            'Create dissertations, reports, and essays with neural AI assistance',
        neuralLevel: 'Master',
      ),
      NeuralBenefitItem(
        icon: Icons.cloud_upload_rounded,
        title: 'Enhanced Neural Storage',
        description:
            'Upload larger files with priority neural processing power',
        neuralLevel: 'Unlimited',
      ),
      NeuralBenefitItem(
        icon: Icons.flash_on_rounded,
        title: 'Priority Neural Processing',
        description:
            'Lightning-fast response times with dedicated neural bandwidth',
        neuralLevel: 'Instant',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      extendBodyBehindAppBar: true,
      appBar: _buildNeuralAppBar(),
      body: Stack(
        children: [
          // Neural Network Background
          _NeuralNetworkBackground(animation: _neuralAnimation),

          // Main Content
          SlideTransition(
            position: _slideAnimation,
            child: ResponsiveScaffold(
              mobile: _SubscriptionMobileLayout(
                benefits: neuralBenefits,
                pulseAnimation: _pulseAnimation,
              ),
              tablet: _SubscriptionTabletLayout(
                benefits: neuralBenefits,
                pulseAnimation: _pulseAnimation,
              ),
              desktop: _SubscriptionDesktopLayout(
                benefits: neuralBenefits,
                pulseAnimation: _pulseAnimation,
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildNeuralAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A1A2E).withAlpha(229),
              const Color(0xFF16213E).withAlpha(204),
            ],
          ),
        ),
      ),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF00D4FF).withAlpha(52),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF00D4FF).withAlpha(77),
            ),
          ),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF00D4FF),
          ),
        ),
      ),
      title: Row(
        children: [
          AnimatedBuilder(
            animation: _logoRotation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _logoRotation.value,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00D4FF).withAlpha(77),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
            ).createShader(bounds),
            child: const Text(
              'Neural Premium',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showNeuralSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black87,
      builder: (_) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A1A2E).withAlpha(242),
                const Color(0xFF16213E).withAlpha(229),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: const Color(0xFF00D4FF).withAlpha(77),
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D4FF).withAlpha(52),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D4FF).withAlpha(104),
                      blurRadius: 20,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.psychology_rounded,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                ).createShader(bounds),
                child: const Text(
                  'Neural Network Activated! 🧠',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your neural premium subscription is now active. You have full access to all advanced AI neural features and unlimited neural processing power.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withAlpha(204),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D4FF).withAlpha(77),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: TextButton(
                  onPressed: () =>
                      Navigator.popUntil(context, (route) => route.isFirst),
                  child: const Text(
                    "Enter Neural Network",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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

  void _showNeuralErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(52),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.error_outline, color: Colors.red, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Neural Error: $message',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF1A1A2E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: Colors.red.withAlpha(77)),
        ),
      ),
    );
  }
}

class _NeuralNetworkBackground extends StatelessWidget {
  final Animation<double> animation;

  const _NeuralNetworkBackground({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return CustomPaint(
          painter: _NeuralNetworkPainter(animation.value),
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
    final paint = Paint()
      ..color = const Color(0xFF00D4FF).withAlpha(26)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = const Color(0xFF00D4FF).withAlpha(77)
      ..style = PaintingStyle.fill;

    //Neural network nodes
    final nodes = <Offset>[];
    for (int i = 0; i < 20; i++) {
      final x = (i * 0.2 * size.width + animationValue * 50) % size.width;
      final y =
          (i * 0.15 * size.height + math.sin(animationValue * 2 + i) * 30) %
              size.height;
      nodes.add(Offset(x, y));
    }

    // Draw connections
    for (int i = 0; i < nodes.length; i++) {
      for (int j = i + 1; j < nodes.length; j++) {
        final distance = (nodes[i] - nodes[j]).distance;
        if (distance < 150) {
          final opacity = (1 - distance / 150) * 0.3;
          paint.color = const Color(0xFF00D4FF).withOpacity(opacity);
          canvas.drawLine(nodes[i], nodes[j], paint);
        }
      }
    }

    // Draw nodes
    for (final node in nodes) {
      final pulseRadius = 2 + math.sin(animationValue * 4) * 1;
      canvas.drawCircle(node, pulseRadius, nodePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _SubscriptionMobileLayout extends StatelessWidget {
  final List<NeuralBenefitItem> benefits;
  final Animation<double> pulseAnimation;

  const _SubscriptionMobileLayout({
    required this.benefits,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _NeuralHeader(pulseAnimation: pulseAnimation),
            const SizedBox(height: 32),
            _NeuralBenefitsList(benefits: benefits),
            const SizedBox(height: 40),
            const _NeuralPaymentCard(),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionTabletLayout extends StatelessWidget {
  final List<NeuralBenefitItem> benefits;
  final Animation<double> pulseAnimation;

  const _SubscriptionTabletLayout({
    required this.benefits,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Column(
          children: [
            _NeuralHeader(pulseAnimation: pulseAnimation),
            const SizedBox(height: 40),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    flex: 3, child: _NeuralBenefitsList(benefits: benefits)),
                const SizedBox(width: 32),
                const Expanded(flex: 2, child: _NeuralPaymentCard()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionDesktopLayout extends StatelessWidget {
  final List<NeuralBenefitItem> benefits;
  final Animation<double> pulseAnimation;

  const _SubscriptionDesktopLayout({
    required this.benefits,
    required this.pulseAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
            child: Column(
              children: [
                _NeuralHeader(pulseAnimation: pulseAnimation),
                const SizedBox(height: 48),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 6,
                        child: _NeuralBenefitsList(benefits: benefits)),
                    const SizedBox(width: 48),
                    const Expanded(flex: 4, child: _NeuralPaymentCard()),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NeuralHeader extends StatelessWidget {
  final Animation<double> pulseAnimation;

  const _NeuralHeader({required this.pulseAnimation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A2E).withAlpha(204),
            const Color(0xFF16213E).withAlpha(152),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF00D4FF).withAlpha(77),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withAlpha(26),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          AnimatedBuilder(
            animation: pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: pulseAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00D4FF).withAlpha(104),
                        blurRadius: 30,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
            ).createShader(bounds),
            child: const Text(
              'Unlock Neural Intelligence',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Join the Neural Premium network to access our most advanced AI features and accelerate your learning with unlimited neural processing power.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white.withAlpha(204),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _NeuralBenefitsList extends StatelessWidget {
  final List<NeuralBenefitItem> benefits;

  const _NeuralBenefitsList({required this.benefits});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
          ).createShader(bounds),
          child: const Text(
            'Neural Premium Features:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        ...benefits.asMap().entries.map((entry) {
          final index = entry.key;
          final benefit = entry.value;
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: _NeuralBenefitCard(
              benefit: benefit,
              delay: Duration(milliseconds: index * 150),
            ),
          );
        }),
      ],
    );
  }
}

class _NeuralBenefitCard extends StatefulWidget {
  final NeuralBenefitItem benefit;
  final Duration delay;

  const _NeuralBenefitCard({
    required this.benefit,
    required this.delay,
  });

  @override
  State<_NeuralBenefitCard> createState() => _NeuralBenefitCardState();
}

class _NeuralBenefitCardState extends State<_NeuralBenefitCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(-0.5, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                const Color(0xFF1A1A2E).withAlpha(204),
                const Color(0xFF16213E).withAlpha(152),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFF00D4FF).withAlpha(77),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D4FF).withAlpha(77),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  widget.benefit.icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.benefit.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00D4FF).withAlpha(52),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFF00D4FF).withAlpha(77),
                            ),
                          ),
                          child: Text(
                            widget.benefit.neuralLevel,
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF00D4FF),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      widget.benefit.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(178),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NeuralPaymentCard extends ConsumerStatefulWidget {
  const _NeuralPaymentCard();

  @override
  ConsumerState<_NeuralPaymentCard> createState() => _NeuralPaymentCardState();
}

class _NeuralPaymentCardState extends ConsumerState<_NeuralPaymentCard> {
  CardFieldInputDetails? _cardDetails;
  bool _isProcessing = false;
  String? _cardError;

  Future<void> _handleNeuralSubscribe() async {
    if (_cardDetails?.complete != true) {
      setState(
          () => _cardError = 'Please enter complete neural payment details.');
      return;
    }

    setState(() {
      _cardError = null;
      _isProcessing = true;
    });

    try {
      HapticFeedback.mediumImpact();

      final paymentMethod = await Stripe.instance.createPaymentMethod(
        params: const PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );

      await ref.read(subscriptionServiceProvider).createSubscription(
            gateway: 'stripe',
            paymentToken: paymentMethod.id,
          );
    } on StripeException catch (e) {
      setState(() => _cardError =
          'Neural Payment Error: ${e.error.localizedMessage ?? 'Connection failed'}');
    } catch (e) {
      setState(() =>
          _cardError = 'Neural network connection failed. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final subState = ref.watch(subscriptionProvider);
    final isLoading =
        _isProcessing || subState.status == SubscriptionStatus.loading;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF1A1A2E).withAlpha(229),
            const Color(0xFF16213E).withAlpha(178),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF00D4FF).withAlpha(77),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00D4FF).withAlpha(26),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.workspace_premium_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                  ).createShader(bounds),
                  child: const Text(
                    'Neural Premium',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
              ).createShader(bounds),
              child: const Text(
                '\$5.99/month',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Neural Payment Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF0A0A0F).withAlpha(128),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: _cardError != null
                      ? Colors.red.withAlpha(128)
                      : const Color(0xFF00D4FF).withAlpha(77),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF00D4FF).withAlpha(52),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.credit_card_rounded,
                          color: Color(0xFF00D4FF),
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Neural Payment Gateway',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withAlpha(229),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  CardField(
                    onCardChanged: (details) {
                      setState(() => _cardDetails = details);
                    },
                    // style: CardFieldInputDecoration(
                    //   textColor: Colors.white,
                    //   placeholderColor: Colors.white.withAlpha(128),
                    //   backgroundColor: Colors.transparent,
                    //   borderColor: Colors.transparent,
                    // ),
                  ),
                ],
              ),
            ),

            if (_cardError != null)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red.withAlpha(26),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red.withAlpha(77)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.error_outline,
                          color: Colors.red, size: 16),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _cardError!,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            const SizedBox(height: 24),

            Container(
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00D4FF), Color(0xFF0099CC)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00D4FF).withAlpha(77),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: isLoading ? null : _handleNeuralSubscribe,
                  child: Center(
                    child: isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              color: Colors.white,
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.psychology_rounded,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Activate Neural Network',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Neural billing monthly • Cancel anytime • 7-day neural trial',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.white.withAlpha(152),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NeuralBenefitItem {
  final IconData icon;
  final String title;
  final String description;
  final String neuralLevel;

  const NeuralBenefitItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.neuralLevel,
  });
}
