import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import '../../../theme/neural_bg.dart';
import '../../profile/providers/profile_provider.dart';
import '../providers/quiz_provider.dart';

class StartQuizScreen extends ConsumerStatefulWidget {
  final StudyMaterial material;
  const StartQuizScreen({super.key, required this.material});

  @override
  ConsumerState<StartQuizScreen> createState() => _StartQuizScreenState();
}

class _StartQuizScreenState extends ConsumerState<StartQuizScreen>
    with TickerProviderStateMixin {
  final List<String> _selectedTypes = ['saq', 'true_false'];
  late AnimationController _controller;
  late AnimationController _slideController;
  final double _questionCount = 10.0;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(profileProvider);

    ref.listen<QuizState>(quizProvider, (previous, next) {
      if (next.status == QuizStatus.active) {
        context.goNamed('quizActive');
      }
      if (next.errorMessage != null && next.status == QuizStatus.initial) {
        _showErrorSnackBar(next.errorMessage!);
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Configure Quiz',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: Stack(
        // Neural network background

        children: [
          const NeuralNetworkBackground(),
          profileAsync.when(
            data: (bundle) {
              final isPremium = bundle.profile.role == 'premium';
              return _buildConfigView(context, isPremium);
            },
            loading: () => _buildLoadingView(),
            error: (err, stack) => _buildErrorView(err.toString()),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingView() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading your profile...'),
        ],
      ),
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load profile',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => ref.invalidate(profileProvider),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConfigView(BuildContext context, bool isPremium) {
    final theme = Theme.of(context);
    final quizState = ref.watch(quizProvider);

    return SlideTransition(
      position: _slideAnimation,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header section
            _Header(widget.material),
            const SizedBox(height: 40),

            // Question count section
            _QuestionCountSection(
              isPremium: isPremium,
            ),
            const SizedBox(height: 40),

            // Question types section
            _QuestionTypesSection(isPremium: isPremium),
            const SizedBox(height: 40),

            // Start button
            _buildStartButton(theme, quizState),
          ],
        ),
      ),
    );
  }

  Widget _buildStartButton(ThemeData theme, QuizState quizState) {
    final isLoading = quizState.status == QuizStatus.loading;

    return Container(
      height: 56,
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isLoading ? null : _startQuiz,
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Start Quiz',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _startQuiz() {
    HapticFeedback.mediumImpact();
    ref.read(quizProvider.notifier).startQuiz(
          material: widget.material,
          count: _questionCount.toInt(),
          questionTypes: _selectedTypes,
        );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}

class _Header extends ConsumerStatefulWidget {
  final StudyMaterial material;

  const _Header(this.material);

  @override
  ConsumerState<_Header> createState() => _HeaderState();
}

class _HeaderState extends ConsumerState<_Header>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _pulseController;
  late Animation<double> _glowAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
          color:
              const Color(0xFF00D4FF).withAlpha((_glowAnimation.value).toInt()),
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
        children: [
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _pulseAnimation.value,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.quiz_rounded,
                    size: 48,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Quiz Configuration',
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Text(
              widget.material.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCountSection extends ConsumerStatefulWidget {
  final bool isPremium;

  const _QuestionCountSection({required this.isPremium});

  @override
  ConsumerState<_QuestionCountSection> createState() =>
      _QuestionCountSectionState();
}

class _QuestionCountSectionState extends ConsumerState<_QuestionCountSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _glowAnimation;
  double _questionCount = 10.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
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

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
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
          color:
              const Color(0xFF00D4FF).withAlpha((_glowAnimation.value).toInt()),
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
              Icon(
                Icons.format_list_numbered_rounded,
              ),
              const SizedBox(width: 12),
              Text(
                'Number of Questions',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Question count display
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Text(
                '${_questionCount.toInt()} Questions',
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Slider
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              trackHeight: 6,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
            ),
            child: Slider(
              value: _questionCount,
              min: 5,
              max: widget.isPremium ? 50.0 : 10.0,
              divisions: widget.isPremium ? 9 : 1,
              onChanged: (double value) {
                setState(() => _questionCount = value);
                HapticFeedback.selectionClick();
              },
            ),
          ),

          // Range indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '5',
              ),
              Text(
                widget.isPremium ? '50' : '10',
              ),
            ],
          ),

          if (!widget.isPremium) ...[
            const SizedBox(height: 16),
            _PremiumPrompt(
              text: 'Upgrade to Premium for up to 50 questions per quiz',
              icon: Icons.psychology,
            ),
          ],
        ],
      ),
    );
  }
}

class _PremiumPrompt extends StatefulWidget {
  final String text;
  final IconData icon;
  const _PremiumPrompt({required this.text, required this.icon});

  @override
  State<_PremiumPrompt> createState() => _PremiumPromptState();
}

class _PremiumPromptState extends State<_PremiumPrompt>
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
            child: InkWell(
              onTap: () {
                HapticFeedback.lightImpact();
                _controller.forward().then((_) {
                  _controller.reverse();
                });
                context.pushNamed('subscription');
              },
              child: Container(
                padding: const EdgeInsets.all(16),
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
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(widget.icon, color: Colors.white, size: 20),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.text,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class _QuestionTypesSection extends ConsumerStatefulWidget {
  final bool isPremium;

  const _QuestionTypesSection({required this.isPremium});

  @override
  ConsumerState<_QuestionTypesSection> createState() =>
      _QuestionTypesSectionState();
}

class _QuestionTypesSectionState extends ConsumerState<_QuestionTypesSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final Map<String, QuestionTypeInfo> _allQuestionTypes = {
    'saq': QuestionTypeInfo(
      name: 'Short Answer',
      description: 'Brief written responses',
      icon: Icons.short_text_rounded,
      color: Colors.blue,
    ),
    'true_false': QuestionTypeInfo(
      name: 'True / False',
      description: 'Binary choice questions',
      icon: Icons.check_box_rounded,
      color: Colors.green,
    ),
    'essay': QuestionTypeInfo(
      name: 'Essay',
      description: 'Detailed written responses',
      icon: Icons.article_rounded,
      color: Colors.purple,
    ),
    'fill_in_blank': QuestionTypeInfo(
      name: 'Fill in the Blank',
      description: 'Complete the missing parts',
      icon: Icons.edit_rounded,
      color: Colors.orange,
    ),
  };
  final Set<String> _selectedTypes = {'saq', 'true_false'};

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.category_rounded,
              ),
              const SizedBox(width: 12),
              Text(
                'Question Types',
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Question type cards
          ...(_allQuestionTypes.entries.map((entry) {
            final typeCode = entry.key;
            final typeInfo = entry.value;
            final isSelected = _selectedTypes.contains(typeCode);
            final isDisabled = !widget.isPremium &&
                (typeCode != 'saq' && typeCode != 'true_false');

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _QuestionTypeCard(
                typeInfo: typeInfo,
                isSelected: isSelected && !isDisabled,
                isDisabled: isDisabled,
                onTap: isDisabled
                    ? null
                    : () {
                        setState(() {
                          if (isSelected) {
                            if (_selectedTypes.length > 1) {
                              _selectedTypes.remove(typeCode);
                            }
                          } else {
                            _selectedTypes.add(typeCode);
                          }
                        });
                        HapticFeedback.lightImpact();
                      },
              ),
            );
          }).toList()),

          if (!widget.isPremium) ...[
            const SizedBox(height: 16),
            _PremiumPrompt(
                text:
                    'Unlock Essay and Fill in the Blank questions with Premium',
                icon: Icons.psychology),
          ],
        ],
      ),
    );
  }
}

class QuestionTypeInfo {
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  QuestionTypeInfo({
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}

class _QuestionTypeCard extends StatelessWidget {
  final QuestionTypeInfo typeInfo;
  final bool isSelected;
  final bool isDisabled;
  final VoidCallback? onTap;

  const _QuestionTypeCard({
    required this.typeInfo,
    required this.isSelected,
    required this.isDisabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(
        color: isSelected
            ? typeInfo.color.withAlpha(26)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected
              ? typeInfo.color
              : isDisabled
                  ? theme.colorScheme.outline.withAlpha(77)
                  : theme.colorScheme.outline.withAlpha(128),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isDisabled
                        ? theme.colorScheme.outline.withAlpha(26)
                        : typeInfo.color.withAlpha(26),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    typeInfo.icon,
                    color:
                        isDisabled ? theme.colorScheme.outline : typeInfo.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        typeInfo.name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isDisabled
                              ? theme.colorScheme.onSurfaceVariant
                              : null,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        typeInfo.description,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDisabled
                              ? theme.colorScheme.onSurfaceVariant
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                if (isDisabled)
                  Icon(
                    Icons.lock_rounded,
                    color: theme.colorScheme.outline,
                    size: 20,
                  )
                else if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: typeInfo.color,
                    size: 24,
                  )
                else
                  Icon(
                    Icons.radio_button_unchecked_rounded,
                    color: theme.colorScheme.outline,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
