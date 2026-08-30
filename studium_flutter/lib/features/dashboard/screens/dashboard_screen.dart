import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import 'package:intl/intl.dart';
import '../../../core/layout/responsive.dart';
import '../../notifications/providers/notification_provider.dart';
import '../../notifications/screens/notifications_screen.dart';
import '../providers/dashboard_provider.dart';
import '../../profile/providers/profile_provider.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with TickerProviderStateMixin {
  late AnimationController _particleController;
  late AnimationController _slideController;
  late AnimationController _staggerController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _particleController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _staggerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _slideController.forward();
    _staggerController.forward();
  }

  @override
  void dispose() {
    _particleController.dispose();
    _slideController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardProvider);
    final profileAsync = ref.watch(profileProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E1A),
      body: Stack(
        children: [
          // Neural network background
          _NeuralBackground(controller: _particleController),

          // Main content
          Column(
            children: [
              _buildAppBar(ref),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    HapticFeedback.lightImpact();
                    ref.invalidate(dashboardProvider);
                    ref.invalidate(profileProvider);
                  },
                  backgroundColor: const Color(0xFF1E293B),
                  color: const Color(0xFF3B82F6),
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: dashboardAsync.when(
                      data: (bundle) => ResponsiveScaffold(
                        mobile: _DashboardMobileLayout(
                          bundle: bundle,
                          profileAsync: profileAsync,
                          staggerController: _staggerController,
                        ),
                        tablet: _DashboardTabletLayout(
                          bundle: bundle,
                          profileAsync: profileAsync,
                          staggerController: _staggerController,
                        ),
                        desktop: _DashboardDesktopLayout(
                          bundle: bundle,
                          profileAsync: profileAsync,
                          staggerController: _staggerController,
                        ),
                      ),
                      loading: () => _buildLoadingState(),
                      error: (err, stack) => _buildErrorState(ref, err),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(WidgetRef ref) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 12),
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
            ).createShader(bounds),
            child: const Text(
              'Neural Dashboard',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      actions: [
        Consumer(
          builder: (context, ref, child) {
            final count = ref.watch(unreadNotificationCountProvider).value ?? 0;
            return Container(
              margin: const EdgeInsets.only(right: 8),
              child: Stack(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_rounded,
                      color: Colors.white70,
                    ),
                    onPressed: () {
                      HapticFeedback.lightImpact();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const NotificationsScreen()),
                      );
                    },
                  ),
                  if (count > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          count.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
        IconButton(
          icon: const Icon(
            Icons.refresh_rounded,
            color: Colors.white70,
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            ref.invalidate(dashboardProvider);
            ref.invalidate(profileProvider);
          },
        ),
      ],
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation(Color(0xFF3B82F6)),
          ),
          SizedBox(height: 24),
          Text(
            'Initializing Neural Dashboard...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(WidgetRef ref, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444).withAlpha(26),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: Color(0xFFEF4444),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Neural Connection Failed',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Unable to establish connection with the neural network. Please check your connection and try again.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Container(
              height: 48,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ref.invalidate(dashboardProvider);
                    ref.invalidate(profileProvider);
                  },
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.refresh_rounded, color: Colors.white),
                          SizedBox(width: 8),
                          Text(
                            'Reconnect',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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

class _NeuralBackground extends StatelessWidget {
  final AnimationController controller;

  const _NeuralBackground({required this.controller});

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
      ..color = const Color(0xFF3B82F6).withAlpha(39)
      ..strokeWidth = 0.8;

    final nodePaint = Paint()..color = const Color(0xFF8B5CF6).withAlpha(77);

    // Create subtle neural network pattern
    for (int i = 0; i < 25; i++) {
      final x1 = (i * 47.3 + animationValue * 30) % size.width;
      final y1 = (i * 33.7 + animationValue * 25) % size.height;

      // Draw connections
      for (int j = i + 1; j < 25 && j < i + 3; j++) {
        final x2 = (j * 47.3 + animationValue * 30) % size.width;
        final y2 = (j * 33.7 + animationValue * 25) % size.height;

        final distance = ((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
        if (distance < 20000) {
          canvas.drawLine(Offset(x1, y1), Offset(x2, y2), connectionPaint);
        }
      }

      // Draw nodes
      canvas.drawCircle(
        Offset(x1, y1),
        2.0 + (animationValue * 1.5) % 1.5,
        nodePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _DashboardMobileLayout extends StatelessWidget {
  final DashboardBundle bundle;
  final AsyncValue<UserProfileBundle> profileAsync;
  final AnimationController staggerController;

  const _DashboardMobileLayout({
    required this.bundle,
    required this.profileAsync,
    required this.staggerController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        _NeuralWelcomeHeader(
          profileAsync: profileAsync,
          delay: const Duration(milliseconds: 0),
          staggerController: staggerController,
        ),
        const SizedBox(height: 32),
        _NeuralStatsGrid(
          history: bundle.history,
          crossAxisCount: 2,
          delay: const Duration(milliseconds: 200),
          staggerController: staggerController,
        ),
        const SizedBox(height: 32),
        _NeuralContinueStudying(
          recentMaterials: bundle.recentMaterials,
          recentSummaries: bundle.recentSummaries,
          delay: const Duration(milliseconds: 600),
          staggerController: staggerController,
        ),
      ],
    );
  }
}

class _DashboardTabletLayout extends StatelessWidget {
  final DashboardBundle bundle;
  final AsyncValue<UserProfileBundle> profileAsync;
  final AnimationController staggerController;

  const _DashboardTabletLayout({
    required this.bundle,
    required this.profileAsync,
    required this.staggerController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      children: [
        _NeuralWelcomeHeader(
          profileAsync: profileAsync,
          delay: const Duration(milliseconds: 0),
          staggerController: staggerController,
        ),
        const SizedBox(height: 40),
        _NeuralStatsGrid(
          history: bundle.history,
          crossAxisCount: 4,
          delay: const Duration(milliseconds: 200),
          staggerController: staggerController,
        ),
        const SizedBox(height: 40),
        _NeuralContinueStudying(
          recentMaterials: bundle.recentMaterials,
          recentSummaries: bundle.recentSummaries,
          delay: const Duration(milliseconds: 600),
          staggerController: staggerController,
        ),
      ],
    );
  }
}

class _DashboardDesktopLayout extends StatelessWidget {
  final DashboardBundle bundle;
  final AsyncValue<UserProfileBundle> profileAsync;
  final AnimationController staggerController;

  const _DashboardDesktopLayout({
    required this.bundle,
    required this.profileAsync,
    required this.staggerController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 32.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _NeuralWelcomeHeader(
                  profileAsync: profileAsync,
                  delay: const Duration(milliseconds: 0),
                  staggerController: staggerController,
                ),
                const SizedBox(height: 48),
                _NeuralStatsGrid(
                  history: bundle.history,
                  crossAxisCount: 4,
                  delay: const Duration(milliseconds: 200),
                  staggerController: staggerController,
                ),
                const SizedBox(height: 48),
                _NeuralContinueStudying(
                  recentMaterials: bundle.recentMaterials,
                  recentSummaries: bundle.recentSummaries,
                  delay: const Duration(milliseconds: 600),
                  staggerController: staggerController,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NeuralWelcomeHeader extends StatefulWidget {
  final AsyncValue<UserProfileBundle> profileAsync;
  final Duration delay;
  final AnimationController staggerController;

  const _NeuralWelcomeHeader({
    required this.profileAsync,
    required this.delay,
    required this.staggerController,
  });

  @override
  State<_NeuralWelcomeHeader> createState() => _NeuralWelcomeHeaderState();
}

class _NeuralWelcomeHeaderState extends State<_NeuralWelcomeHeader>
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
      begin: const Offset(0, 0.3),
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
    final name = widget.profileAsync.when(
      data: (bundle) => bundle.profile.name ?? 'Neural User',
      loading: () => '...',
      error: (_, __) => 'Neural User',
    );

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF1E3A8A),
                Color(0xFF7C3AED),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF3B82F6).withAlpha(52),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF3B82F6).withAlpha(77),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(
                    'assets/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Neural Network Active, $name!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Your AI learning companion is ready to process new knowledge.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
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

class _NeuralStatsGrid extends StatefulWidget {
  final StudyHistory history;
  final int crossAxisCount;
  final Duration delay;
  final AnimationController staggerController;

  const _NeuralStatsGrid({
    required this.history,
    required this.crossAxisCount,
    required this.delay,
    required this.staggerController,
  });

  @override
  State<_NeuralStatsGrid> createState() => _NeuralStatsGridState();
}

class _NeuralStatsGridState extends State<_NeuralStatsGrid>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
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
    final stats = [
      _NeuralStatInfo(
        icon: Icons.folder_copy_rounded,
        label: 'Neural Inputs',
        value: widget.history.materialIds.length.toString(),
        gradient: const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
        ),
      ),
      _NeuralStatInfo(
        icon: Icons.summarize_rounded,
        label: 'Processed Data',
        value: widget.history.summaryIds.length.toString(),
        gradient: const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        ),
      ),
      _NeuralStatInfo(
        icon: Icons.quiz_rounded,
        label: 'Neural Queries',
        value: widget.history.questionIds.length.toString(),
        gradient: const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFF97316)],
        ),
      ),
      _NeuralStatInfo(
        icon: Icons.edit_document,
        label: 'AI Outputs',
        value: widget.history.writingIds.length.toString(),
        gradient: const LinearGradient(
          colors: [Color(0xFF8B5CF6), Color(0xFFA855F7)],
        ),
      ),
    ];

    return GridView.count(
      crossAxisCount: widget.crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: widget.crossAxisCount == 2 ? 1.8 : 1.6,
      children: stats.asMap().entries.map((entry) {
        final index = entry.key;
        final stat = entry.value;
        return _NeuralStatCard(
          stat: stat,
          delay: Duration(milliseconds: index * 100),
          controller: _controller,
        );
      }).toList(),
    );
  }
}

class _NeuralStatInfo {
  final IconData icon;
  final String label;
  final String value;
  final Gradient gradient;

  _NeuralStatInfo({
    required this.icon,
    required this.label,
    required this.value,
    required this.gradient,
  });
}

class _NeuralStatCard extends StatefulWidget {
  final _NeuralStatInfo stat;
  final Duration delay;
  final AnimationController controller;

  const _NeuralStatCard({
    required this.stat,
    required this.delay,
    required this.controller,
  });

  @override
  State<_NeuralStatCard> createState() => _NeuralStatCardState();
}

class _NeuralStatCardState extends State<_NeuralStatCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeIn,
    );

    Future.delayed(widget.delay, () {
      if (mounted) _animController.forward();
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: widget.stat.gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.stat.gradient.colors.first.withAlpha(77),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            spacing: 4,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(52),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  widget.stat.icon,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.stat.value,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.stat.label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NeuralContinueStudying extends StatefulWidget {
  final List<StudyMaterial> recentMaterials;
  final List<Summary> recentSummaries;
  final Duration delay;
  final AnimationController staggerController;

  const _NeuralContinueStudying({
    required this.recentMaterials,
    required this.recentSummaries,
    required this.delay,
    required this.staggerController,
  });

  @override
  State<_NeuralContinueStudying> createState() =>
      _NeuralContinueStudyingState();
}

class _NeuralContinueStudyingState extends State<_NeuralContinueStudying>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
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
    // Combine items into a unified list for sorting
    final List<_RecentItem> allRecentItems = [
      ...widget.recentMaterials
          .map((m) => _RecentItem(item: m, date: m.uploadDate)),
      // ...widget.recentSummaries.map((s) => _RecentItem(item: s, date: s.creationDate)),
    ];

    // Sort by date, most recent first
    allRecentItems.sort((a, b) => b.date.compareTo(a.date));

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.psychology_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  "Neural Learning Queue",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              "Continue processing your neural pathways",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 24),
            if (allRecentItems.isEmpty)
              _NeuralEmptyStateCard(
                icon: Icons.psychology_outlined,
                message: "Neural network awaiting input",
                subMessage: "Upload documents to begin neural processing!",
              )
            else
              SizedBox(
                height: 180,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: allRecentItems.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    final record = allRecentItems[index];
                    final item = record.item;

                    if (item is StudyMaterial) {
                      return _NeuralRecentItemCard(
                        icon: Icons.description_rounded,
                        title: item.title,
                        subtitle:
                            "Processed ${DateFormat.yMMMd().format(item.uploadDate)}",
                        gradient: _getNeuralFileGradient(item.fileType),
                        delay: Duration(milliseconds: index * 100),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          HapticFeedback.lightImpact();
                          context.pushNamed(
                            'materialDetails',
                            pathParameters: {'id': item.id!.toString()},
                            extra: item,
                          );
                        },
                      );
                    }
                    if (item is Summary) {
                      return _NeuralRecentItemCard(
                        icon: Icons.summarize_rounded,
                        title: item.topic,
                        subtitle: "Neural summary of ${item.subject}",
                        gradient: const LinearGradient(
                          colors: [Color(0xFF10B981), Color(0xFF059669)],
                        ),
                        delay: Duration(milliseconds: index * 100),
                        onTap: () {
                          HapticFeedback.lightImpact();

                          context.pushNamed(
                            'summaryDetails',
                            pathParameters: {'id': item.id!.toString()},
                            extra: item,
                          );
                        },
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Gradient _getNeuralFileGradient(String fileType) {
    switch (fileType.toLowerCase()) {
      case 'pdf':
        return const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFF97316)],
        );
      case 'docx':
      case 'doc':
        return const LinearGradient(
          colors: [Color(0xFF3B82F6), Color(0xFF1E40AF)],
        );
      case 'pptx':
      case 'ppt':
        return const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFF97316)],
        );
      case 'txt':
        return const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFF6B7280), Color(0xFF4B5563)],
        );
    }
  }
}

class _RecentItem {
  final Object item;
  final DateTime date;

  _RecentItem({required this.item, required this.date});
}

class _NeuralRecentItemCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Gradient gradient;
  final Duration delay;
  final VoidCallback onTap;

  const _NeuralRecentItemCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.delay,
    required this.onTap,
  });

  @override
  State<_NeuralRecentItemCard> createState() => _NeuralRecentItemCardState();
}

class _NeuralRecentItemCardState extends State<_NeuralRecentItemCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Container(
          width: 280,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: widget.gradient.colors.first.withAlpha(77),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: widget.onTap,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(52),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        widget.icon,
                        size: 28,
                        color: Colors.white,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.subtitle,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NeuralEmptyStateCard extends StatelessWidget {
  final String message;
  final String? subMessage;
  final IconData icon;

  const _NeuralEmptyStateCard({
    required this.message,
    this.subMessage,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(13),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withAlpha(26),
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            if (subMessage != null) ...[
              const SizedBox(height: 8),
              Text(
                subMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
