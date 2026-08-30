import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/layout/responsive.dart';
import '../../settings/screens/settings_screen.dart';
import '../../subscription/screens/subscription_management_screen.dart';
import '../../subscription/screens/subscription_screen.dart';
import '../../collaboration/providers/collaboration_provider.dart';
import '../../collaboration/widgets/reputation_badges.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late AnimationController _neuralController;
  late AnimationController _logoController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _neuralAnimation;
  late Animation<double> _logoRotation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _neuralController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 4000),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _neuralAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _neuralController, curve: Curves.easeInOut),
    );

    _logoRotation = Tween<double>(begin: 0.0, end: 6.28).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.linear),
    );

    _slideController.forward();
    _pulseController.repeat(reverse: true);
    _neuralController.repeat(reverse: true);
    _logoController.repeat();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _pulseController.dispose();
    _neuralController.dispose();
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final profileAsync = ref.watch(profileProvider);
    final reputation = ref.watch(myReputationProvider).valueOrNull;
    final theme = Theme.of(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0A0E1A),
            Color(0xFF1A1F2E),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(theme),
        body: Stack(
          children: [
            _buildNeuralBackground(),
            profileAsync.when<Widget>(
              data: (UserProfileBundle bundle) => SlideTransition(
                position: _slideAnimation,
                child: Column(
                  children: [
                    if (reputation != null)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                        child: ReputationSummary(
                          score: reputation.score,
                          acceptedSolutions: reputation.acceptedSolutions,
                          verifiedContributions:
                              reputation.verifiedContributions,
                        ),
                      ),
                    Expanded(
                      child: ResponsiveScaffold(
                        mobile: _ProfileMobileLayout(
                          bundle: bundle,
                          pulseAnimation: _pulseAnimation,
                          logoRotation: _logoRotation,
                        ),
                        tablet: _ProfileTabletLayout(
                          bundle: bundle,
                          pulseAnimation: _pulseAnimation,
                          logoRotation: _logoRotation,
                        ),
                        desktop: _ProfileDesktopLayout(
                          bundle: bundle,
                          pulseAnimation: _pulseAnimation,
                          logoRotation: _logoRotation,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              loading: () => _buildLoadingState(theme),
              error: (err, stack) => _buildErrorState(theme, ref),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNeuralBackground() {
    return AnimatedBuilder(
      animation: _neuralAnimation,
      builder: (context, child) {
        return CustomPaint(
          painter: NeuralNetworkPainter(_neuralAnimation.value),
          size: Size.infinite,
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: ShaderMask(
        shaderCallback: (bounds) => const LinearGradient(
          colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
        ).createShader(bounds),
        child: Text(
          'Neural Profile',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }

  Widget _buildLoadingState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: const AlwaysStoppedAnimation(Color(0xFF4FC3F7)),
                ),
              ),
              const Icon(
                Icons.psychology_rounded,
                color: Color(0xFF4FC3F7),
                size: 24,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Loading neural profile...',
            style: theme.textTheme.titleMedium?.copyWith(
              color: Colors.white.withAlpha(204),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
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
                    Colors.red.withAlpha(206),
                  ],
                ),
                border: Border.all(
                  color: Colors.red.withAlpha(77),
                ),
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: Colors.red,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Neural Profile Error',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Neural network couldn\'t load your profile. Please check connection and try again.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withAlpha(178),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF4FC3F7).withAlpha(77),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    HapticFeedback.lightImpact();
                    ref.invalidate(profileProvider);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.refresh_rounded, color: Colors.white),
                        const SizedBox(width: 8),
                        Text(
                          'Retry Neural Sync',
                          style: theme.textTheme.titleMedium?.copyWith(
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
          ],
        ),
      ),
    );
  }
}

class _ProfileMobileLayout extends StatelessWidget {
  final UserProfileBundle bundle;
  final Animation<double> pulseAnimation;
  final Animation<double> logoRotation;

  const _ProfileMobileLayout({
    required this.bundle,
    required this.pulseAnimation,
    required this.logoRotation,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        _UserInfoCard(
          profile: bundle.profile,
          pulseAnimation: pulseAnimation,
          logoRotation: logoRotation,
        ),
        const SizedBox(height: 24),
        _SubscriptionCard(bundle: bundle),
        const SizedBox(height: 24),
        const _ActionList(),
      ],
    );
  }
}

class _ProfileTabletLayout extends StatelessWidget {
  final UserProfileBundle bundle;
  final Animation<double> pulseAnimation;
  final Animation<double> logoRotation;

  const _ProfileTabletLayout({
    required this.bundle,
    required this.pulseAnimation,
    required this.logoRotation,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 5,
              child: _UserInfoCard(
                profile: bundle.profile,
                pulseAnimation: pulseAnimation,
                logoRotation: logoRotation,
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              flex: 6,
              child: _SubscriptionCard(bundle: bundle),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const _ActionList(),
      ],
    );
  }
}

class _ProfileDesktopLayout extends StatelessWidget {
  final UserProfileBundle bundle;
  final Animation<double> pulseAnimation;
  final Animation<double> logoRotation;

  const _ProfileDesktopLayout({
    required this.bundle,
    required this.pulseAnimation,
    required this.logoRotation,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1000),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    _UserInfoCard(
                      profile: bundle.profile,
                      pulseAnimation: pulseAnimation,
                      logoRotation: logoRotation,
                    ),
                    const SizedBox(height: 24),
                    const _ActionList(),
                  ],
                ),
              ),
              const SizedBox(width: 32),
              Expanded(
                flex: 5,
                child: _SubscriptionCard(bundle: bundle),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _UserInfoCard extends StatelessWidget {
  final UserProfile profile;
  final Animation<double> pulseAnimation;
  final Animation<double> logoRotation;

  const _UserInfoCard({
    required this.profile,
    required this.pulseAnimation,
    required this.logoRotation,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPremium = profile.role == 'premium';

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isPremium
              ? [
                  const Color(0xFF4FC3F7).withAlpha(52),
                  const Color(0xFF7C4DFF).withAlpha(52),
                ]
              : [
                  Colors.white.withAlpha(26),
                  Colors.white.withAlpha(13),
                ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPremium
              ? const Color(0xFF4FC3F7).withAlpha(128)
              : Colors.white.withAlpha(52),
          width: isPremium ? 2 : 1,
        ),
        boxShadow: isPremium
            ? [
                BoxShadow(
                  color: const Color(0xFF4FC3F7).withAlpha(77),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withAlpha(52),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Avatar with neural animation
            AnimatedBuilder(
              animation: Listenable.merge([pulseAnimation, logoRotation]),
              builder: (context, child) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    if (isPremium)
                      Transform.rotate(
                        angle: logoRotation.value,
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFF4FC3F7).withAlpha(128),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    Transform.scale(
                      scale: isPremium ? pulseAnimation.value : 1.0,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: isPremium
                              ? const LinearGradient(
                                  colors: [
                                    Color(0xFF4FC3F7),
                                    Color(0xFF7C4DFF)
                                  ],
                                )
                              : LinearGradient(
                                  colors: [
                                    Colors.white.withAlpha(52),
                                    Colors.white.withAlpha(206),
                                  ],
                                ),
                          boxShadow: isPremium
                              ? [
                                  BoxShadow(
                                    color:
                                        const Color(0xFF4FC3F7).withAlpha(104),
                                    blurRadius: 15,
                                    offset: const Offset(0, 5),
                                  ),
                                ]
                              : null,
                        ),
                        child: Center(
                          child: Text(
                            profile.name?.substring(0, 1).toUpperCase() ?? 'U',
                            style: theme.textTheme.headlineLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 20),

            // Name with gradient for premium
            isPremium
                ? ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                    ).createShader(bounds),
                    child: Text(
                      profile.name ?? 'Neural User',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                : Text(
                    profile.name ?? 'Neural User',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),

            const SizedBox(height: 12),

            // Role badge with neural styling
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: isPremium
                    ? const LinearGradient(
                        colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                      )
                    : LinearGradient(
                        colors: [
                          Colors.white.withAlpha(52),
                          Colors.white.withAlpha(206),
                        ],
                      ),
                borderRadius: BorderRadius.circular(20),
                boxShadow: isPremium
                    ? [
                        BoxShadow(
                          color: const Color(0xFF4FC3F7).withAlpha(77),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ]
                    : null,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    isPremium
                        ? Icons.psychology_rounded
                        : Icons.account_circle_rounded,
                    color: Colors.white,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    isPremium ? 'NEURAL PREMIUM' : 'NEURAL FREE',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SubscriptionCard extends StatelessWidget {
  final UserProfileBundle bundle;

  const _SubscriptionCard({required this.bundle});

  @override
  Widget build(BuildContext context) {
    final isPremium = bundle.profile.role == 'premium';
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withAlpha(26),
            Colors.white.withAlpha(13),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.white.withAlpha(52),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(52),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isPremium
                        ? Icons.workspace_premium_rounded
                        : Icons.account_circle_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Neural Subscription Status',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isPremium && bundle.subscription != null)
              ..._buildPremiumDetails(context, bundle.subscription!)
            else
              ..._buildFreeTierDetails(context),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildPremiumDetails(BuildContext context, Subscription sub) {
    final theme = Theme.of(context);

    return [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              const Color(0xFF4CAF50).withAlpha(52),
              const Color(0xFF4CAF50).withAlpha(206),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF4CAF50).withAlpha(128)),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle_rounded, color: const Color(0xFF4CAF50)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Neural Premium Active! 🧠',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF4CAF50),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Neural sync renews on ${DateFormat.yMMMd().format(sub.endDate!)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white.withAlpha(204),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      SizedBox(
        width: double.infinity,
        height: 48,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(
              colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF4FC3F7).withAlpha(77),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () {
                HapticFeedback.lightImpact();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        SubscriptionManagementScreen(subscription: sub),
                  ),
                );
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.settings_rounded, color: Colors.white),
                    const SizedBox(width: 8),
                    Text(
                      'Manage Neural Subscription',
                      style: theme.textTheme.titleMedium?.copyWith(
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
    ];
  }

  List<Widget> _buildFreeTierDetails(BuildContext context) {
    final theme = Theme.of(context);

    return [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withAlpha(206),
              Colors.white.withAlpha(13),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.white.withAlpha(77),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Neural Free Plan',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Unlock unlimited neural AI features, larger file uploads, and advanced neural question types with Premium.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.white.withAlpha(204),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      Container(
        width: double.infinity,
        height: 48,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xFF4FC3F7), Color(0xFF7C4DFF)],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4FC3F7).withAlpha(104),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              HapticFeedback.mediumImpact();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SubscriptionScreen()),
              );
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.psychology_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Upgrade to Neural Premium',
                    style: theme.textTheme.titleMedium?.copyWith(
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
    ];
  }
}

class _ActionList extends ConsumerWidget {
  const _ActionList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final actions = [
      _ActionItem(
        icon: Icons.settings_rounded,
        title: 'Neural Settings',
        subtitle: 'Customize your neural experience',
        onTap: () {
          HapticFeedback.lightImpact();
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SettingsScreen()),
          );
        },
      ),
      _ActionItem(
        icon: Icons.help_rounded,
        title: 'Neural Help & Support',
        subtitle: 'Get neural assistance and answers',
        onTap: () {
          HapticFeedback.lightImpact();
          _openHelp(context);
        },
      ),
      _ActionItem(
        icon: Icons.feedback_rounded,
        title: 'Neural Feedback',
        subtitle: 'Help us improve the neural network',
        onTap: () {
          HapticFeedback.lightImpact();
          _openFeedback(context);
        },
      ),
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withAlpha(26),
            Colors.white.withAlpha(13),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withAlpha(52),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(52),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          ...actions.map((action) => _ActionTile(action: action)),

          Container(
            height: 1,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.white.withAlpha(52),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Neural sign out action
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              onTap: () async {
                HapticFeedback.lightImpact();
                final confirm = await _showSignOutDialog(context);
                if (confirm == true && context.mounted) {
                  ref.read(signOutProvider)();
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.red.withAlpha(52),
                            Colors.red.withAlpha(206),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.logout_rounded,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Neural Sign Out',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Disconnect from neural network',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: Colors.red.withAlpha(178),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> _openHelp(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Studium Help & Support'),
        content: const Text(
          'For account, study-room, or collaboration help, contact your institution administrator or email support@studium.app.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
          FilledButton(
            onPressed: () async {
              await launchUrl(Uri(scheme: 'mailto', path: 'support@studium.app'));
            },
            child: const Text('Email support'),
          ),
        ],
      ),
    );
  }

  static Future<void> _openFeedback(BuildContext context) async {
    final launched = await launchUrl(
      Uri(
        scheme: 'mailto',
        path: 'feedback@studium.app',
        queryParameters: {'subject': 'Studium feedback'},
      ),
    );
    if (!launched && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the feedback form.')),
      );
    }
  }

  Future<bool?> _showSignOutDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1A1F2E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'Disconnect Neural Network?',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to sign out of your neural account?',
          style: TextStyle(color: Colors.white.withAlpha(204)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.white.withAlpha(178)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                colors: [Colors.red, Colors.redAccent],
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => Navigator.of(context).pop(true),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Text(
                    'Neural Sign Out',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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

class _ActionItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  _ActionItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class _ActionTile extends StatelessWidget {
  final _ActionItem action;

  const _ActionTile({required this.action});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: action.onTap,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF4FC3F7).withAlpha(52),
                      const Color(0xFF7C4DFF).withAlpha(52),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  action.icon,
                  color: const Color(0xFF4FC3F7),
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      action.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      action.subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withAlpha(178),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: Colors.white.withAlpha(128),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NeuralNetworkPainter extends CustomPainter {
  final double animationValue;

  NeuralNetworkPainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF4FC3F7).withAlpha(206)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final nodePaint = Paint()
      ..color = const Color(0xFF4FC3F7).withAlpha(77)
      ..style = PaintingStyle.fill;

    // Draw neural network connections
    for (int i = 0; i < 20; i++) {
      final startX = (i * size.width / 20) + (animationValue * 50);
      final startY = size.height * 0.3 + (animationValue * 20);
      final endX = ((i + 1) * size.width / 20) + (animationValue * 30);
      final endY = size.height * 0.7 - (animationValue * 15);

      canvas.drawLine(
        Offset(startX % size.width, startY),
        Offset(endX % size.width, endY),
        paint,
      );

      // Draw nodes
      canvas.drawCircle(
        Offset(startX % size.width, startY),
        2 + (animationValue * 2),
        nodePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
