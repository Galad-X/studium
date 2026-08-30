import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import 'package:intl/intl.dart';
import '../../../core/layout/responsive.dart';
import '../../profile/providers/profile_provider.dart';
import '../providers/subscription_management_provider.dart';

class SubscriptionManagementScreen extends ConsumerStatefulWidget {
  final Subscription subscription;

  const SubscriptionManagementScreen({
    super.key,
    required this.subscription,
  });

  @override
  ConsumerState<SubscriptionManagementScreen> createState() =>
      _SubscriptionManagementScreenState();
}

class _SubscriptionManagementScreenState
    extends ConsumerState<SubscriptionManagementScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _neuralController;
  late AnimationController _logoController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _neuralAnimation;
  late Animation<double> _logoRotation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _neuralController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _logoController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _neuralAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _neuralController, curve: Curves.easeInOut),
    );

    _logoRotation = Tween<double>(begin: 0.0, end: 6.28).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.linear),
    );

    _slideController.forward();
    _neuralController.repeat(reverse: true);
    _logoController.repeat();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _neuralController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<SubscriptionManagementState>(subscriptionManagementProvider,
        (previous, next) {
      if (next.status == CancellationStatus.success) {
        ref.invalidate(profileProvider);
        _showSuccessSnackBar('Your neural subscription has been cancelled.');
        if (context.mounted) Navigator.pop(context);
      }
      if (next.status == CancellationStatus.error &&
          next.errorMessage != null) {
        _showErrorSnackBar(next.errorMessage!);
      }
    });

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      body: Stack(
        children: [
          // Neural Network Background
          _NeuralNetworkBackground(animation: _neuralAnimation),

          // Main Content
          Column(
            children: [
              _buildNeuralAppBar(),
              Expanded(
                child: SlideTransition(
                  position: _slideAnimation,
                  child: ResponsiveScaffold(
                    mobile: _ManagementMobileLayout(
                        subscription: widget.subscription),
                    tablet: _ManagementTabletLayout(
                        subscription: widget.subscription),
                    desktop: _ManagementDesktopLayout(
                        subscription: widget.subscription),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNeuralAppBar() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFF0A0A0F),
            const Color(0xFF0A0A0F).withAlpha(204),
          ],
        ),
      ),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF00D4FF).withAlpha(52),
                    const Color(0xFF9D4EDD).withAlpha(52),
                  ],
                ),
                border: Border.all(
                  color: const Color(0xFF00D4FF).withAlpha(77),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.arrow_back_rounded,
                color: Color(0xFF00D4FF),
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Neural Logo
          AnimatedBuilder(
            animation: _logoRotation,
            builder: (context, child) {
              return Transform.rotate(
                angle: _logoRotation.value,
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00D4FF), Color(0xFF9D4EDD)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF00D4FF).withAlpha(77),
                        blurRadius: 10,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 16),

          // Neural Title
          Expanded(
            child: ShaderMask(
              shaderCallback: (bounds) => const LinearGradient(
                colors: [Color(0xFF00D4FF), Color(0xFF9D4EDD)],
              ).createShader(bounds),
              child: const Text(
                'Neural Subscription',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF00D4FF), Color(0xFF9D4EDD)],
                ),
                shape: BoxShape.circle,
              ),
              child:
                  const Icon(Icons.check_circle, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 12),
            Expanded(
                child:
                    Text(message, style: const TextStyle(color: Colors.white))),
          ],
        ),
        backgroundColor: const Color(0xFF1A1A2E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: const Color(0xFF00D4FF).withAlpha(77)),
        ),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red),
            const SizedBox(width: 12),
            Expanded(
                child:
                    Text(message, style: const TextStyle(color: Colors.white))),
          ],
        ),
        backgroundColor: const Color(0xFF1A1A2E),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.red),
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

    // Draw neural network nodes and connections
    for (int i = 0; i < 15; i++) {
      final x = (i % 4) * (size.width / 3) + 50;
      final y = (i ~/ 4) * (size.height / 4) + 100;

      // Animate node position slightly
      final animatedX = x + (animationValue * 8 * (i % 2 == 0 ? 1 : -1));
      final animatedY = y + (animationValue * 8 * (i % 3 == 0 ? 1 : -1));

      // Draw connections
      if (i < 14) {
        canvas.drawLine(
          Offset(animatedX, animatedY),
          Offset(animatedX + 40, animatedY + 25),
          paint,
        );
      }

      // Draw nodes
      canvas.drawCircle(
        Offset(animatedX, animatedY),
        2 + (animationValue * 1.5),
        nodePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _ManagementMobileLayout extends StatelessWidget {
  final Subscription subscription;

  const _ManagementMobileLayout({required this.subscription});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _NeuralSubscriptionDetailsCard(subscription: subscription),
          const SizedBox(height: 32),
          const _NeuralCancellationCard(),
        ],
      ),
    );
  }
}

class _ManagementTabletLayout extends StatelessWidget {
  final Subscription subscription;

  const _ManagementTabletLayout({required this.subscription});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: _NeuralSubscriptionDetailsCard(subscription: subscription),
          ),
          const SizedBox(width: 32),
          const Expanded(flex: 2, child: _NeuralCancellationCard()),
        ],
      ),
    );
  }
}

class _ManagementDesktopLayout extends StatelessWidget {
  final Subscription subscription;

  const _ManagementDesktopLayout({required this.subscription});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child:
                    _NeuralSubscriptionDetailsCard(subscription: subscription),
              ),
              const SizedBox(width: 48),
              const Expanded(flex: 4, child: _NeuralCancellationCard()),
            ],
          ),
        ),
      ),
    );
  }
}

class _NeuralSubscriptionDetailsCard extends StatefulWidget {
  final Subscription subscription;

  const _NeuralSubscriptionDetailsCard({required this.subscription});

  @override
  State<_NeuralSubscriptionDetailsCard> createState() =>
      _NeuralSubscriptionDetailsCardState();
}

class _NeuralSubscriptionDetailsCardState
    extends State<_NeuralSubscriptionDetailsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );
    _glowController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _glowAnimation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1A1A2E),
                Color(0xFF16213E),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF00D4FF)
                  .withValues(alpha: _glowAnimation.value * 0.5),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00D4FF)
                    .withValues(alpha: _glowAnimation.value * 0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00D4FF), Color(0xFF9D4EDD)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00D4FF).withAlpha(77),
                            blurRadius: 10,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.psychology_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => const LinearGradient(
                              colors: [Color(0xFF00D4FF), Color(0xFF9D4EDD)],
                            ).createShader(bounds),
                            child: const Text(
                              'Neural Premium Active',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            'Your neural network is synchronized and active',
                            style: TextStyle(
                              color: const Color(0xFF00D4FF).withAlpha(204),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _NeuralDetailRow(
                  icon: Icons.credit_card_rounded,
                  title: 'Neural Payment Method',
                  value:
                      'Managed via ${widget.subscription.gateway.toUpperCase()}',
                ),
                const SizedBox(height: 16),
                _NeuralDetailRow(
                  icon: Icons.event_repeat_rounded,
                  title: 'Neural Sync Renewal',
                  value: widget.subscription.endDate != null
                      ? 'Neural sync renews on ${DateFormat.yMMMd().format(widget.subscription.endDate!)}'
                      : 'Neural sync date not available',
                ),
                const SizedBox(height: 16),
                _NeuralDetailRow(
                  icon: Icons.info_rounded,
                  title: 'Neural Status',
                  value: 'NEURAL ${widget.subscription.status.toUpperCase()}',
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF00D4FF).withAlpha(26),
                        const Color(0xFF9D4EDD).withAlpha(26),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF00D4FF).withAlpha(77),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF00D4FF), Color(0xFF9D4EDD)],
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'You have access to all neural premium features including unlimited neural quizzes, advanced neural AI writing, and priority neural support.',
                          style: TextStyle(
                            color: Colors.white.withAlpha(229),
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NeuralDetailRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _NeuralDetailRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF00D4FF).withAlpha(52),
                const Color(0xFF9D4EDD).withAlpha(52),
              ],
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: const Color(0xFF00D4FF),
            size: 16,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF00D4FF),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  color: Colors.white.withAlpha(204),
                  fontSize: 13,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _NeuralCancellationCard extends ConsumerStatefulWidget {
  const _NeuralCancellationCard();

  @override
  ConsumerState<_NeuralCancellationCard> createState() =>
      _NeuralCancellationCardState();
}

class _NeuralCancellationCardState
    extends ConsumerState<_NeuralCancellationCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final state = ref.watch(subscriptionManagementProvider);

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF16213E),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF00D4FF).withAlpha(77),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF00D4FF), Color(0xFF9D4EDD)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.settings_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF00D4FF), Color(0xFF9D4EDD)],
                  ).createShader(bounds),
                  child: const Text(
                    'Neural Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.withAlpha(26),
                    Colors.red.withAlpha(26),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.orange.withAlpha(77),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.orange.shade400),
                      const SizedBox(width: 8),
                      Text(
                        'Neural Disconnection Policy',
                        style: TextStyle(
                          color: Colors.orange.shade300,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'If you disconnect from the neural network, you\'ll continue to have premium access until the end of your current billing period. After that, your account will revert to the standard plan.',
                    style: TextStyle(
                      color: Colors.white.withAlpha(204),
                      fontSize: 12,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            if (state.status == CancellationStatus.error) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.red.withAlpha(77)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.error_outline, color: Colors.red),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        state.errorMessage ?? 'Cancellation failed.',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                    TextButton(
                      onPressed: () => ref
                          .read(subscriptionManagementProvider.notifier)
                          .retryCancellation(),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
            if (state.status == CancellationStatus.loading) ...[
              AnimatedBuilder(
                animation: _pulseAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _pulseAnimation.value,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color(0xFF00D4FF).withAlpha(52),
                            const Color(0xFF9D4EDD).withAlpha(52),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF00D4FF).withAlpha(77),
                        ),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFF00D4FF), Color(0xFF9D4EDD)],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.psychology_rounded,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Processing neural disconnection...',
                            style: TextStyle(
                              color: Colors.white.withAlpha(229),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ] else ...[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withAlpha(26),
                      Colors.orange.withAlpha(26),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Colors.red.withAlpha(77),
                  ),
                ),
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.cancel_rounded),
                  label: const Text('Disconnect Neural Network'),
                  onPressed: () =>
                      _showNeuralCancelConfirmationDialog(context, ref),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red.shade400,
                    side: BorderSide.none,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _showNeuralCancelConfirmationDialog(
      BuildContext context, WidgetRef ref) async {
    final didConfirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1A2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: const Color(0xFF00D4FF).withAlpha(77),
          ),
        ),
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.withAlpha(77),
                    Colors.orange.withAlpha(77),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.warning_rounded,
                color: Colors.red,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Disconnect Neural Network?',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'You will lose access to all neural premium features at the end of your current billing period.',
              style: TextStyle(
                color: Colors.white.withAlpha(204),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.withAlpha(26),
                    Colors.orange.withAlpha(26),
                  ],
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.red.withAlpha(77),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'You\'ll lose neural access to:',
                    style: TextStyle(
                      color: Colors.red.shade300,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...[
                    'Unlimited neural quizzes',
                    'Advanced neural AI writing',
                    'Priority neural support',
                    'Large neural file uploads'
                  ].map(
                    (feature) => Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.close,
                            size: 16,
                            color: Colors.red.shade400,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            feature,
                            style: TextStyle(
                              color: Colors.white.withAlpha(182),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Are you sure you want to disconnect from the neural network?',
              style: TextStyle(
                color: Colors.white.withAlpha(204),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Keep Neural Premium',
              style: TextStyle(color: const Color(0xFF00D4FF)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.red.withAlpha(204),
                  Colors.orange.withAlpha(204),
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: FilledButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: FilledButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              child: const Text(
                'Yes, Disconnect',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );

    if (didConfirm == true && context.mounted) {
      HapticFeedback.mediumImpact();
      ref.read(subscriptionManagementProvider.notifier).cancelSubscription();
    }
  }
}
