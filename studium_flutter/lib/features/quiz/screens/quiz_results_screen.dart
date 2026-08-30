import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import 'package:studium_flutter/core/layout/responsive.dart';
import '../../dashboard/providers/dashboard_provider.dart';
import '../providers/quiz_provider.dart';

class QuizResultsScreen extends ConsumerStatefulWidget {
  const QuizResultsScreen({super.key});

  @override
  ConsumerState<QuizResultsScreen> createState() => _QuizResultsScreenState();
}

class _QuizResultsScreenState extends ConsumerState<QuizResultsScreen>
    with TickerProviderStateMixin {
  late AnimationController _scoreController;
  late AnimationController _listController;
  late Animation<double> _scoreAnimation;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _scoreController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _listController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scoreAnimation = CurvedAnimation(
      parent: _scoreController,
      curve: Curves.elasticOut,
    );
    _progressAnimation = CurvedAnimation(
      parent: _scoreController,
      curve: Curves.easeInOut,
    );

    // Start animations
    _scoreController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _listController.forward();
    });
  }

  @override
  void dispose() {
    _scoreController.dispose();
    _listController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final theme = Theme.of(context);

    if (quizState.status != QuizStatus.completed) {
      return _buildErrorState(theme);
    }

    return ResponsiveScaffold(
      mobile: _buildMobileLayout(context, quizState, theme),
      tablet: _buildTabletLayout(context, quizState, theme),
      desktop: _buildDesktopLayout(context, quizState, theme),
    );
  }

  Widget _buildMobileLayout(
      BuildContext context, QuizState quizState, ThemeData theme) {
    final double finalScore = quizState.totalScore;
    final int correctAnswers = quizState.userAnswers.values
        .where((answer) => (answer.score ?? 0) > 70)
        .length;
    final int totalQuestions = quizState.questions.length;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: _buildAppBar(theme, ref),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroScoreSection(
                theme, finalScore, correctAnswers, totalQuestions, false),
            _buildPerformanceInsights(theme, finalScore, quizState, false),
            _buildDetailedBreakdown(theme, quizState, false),
            _buildActionButtons(theme, ref, false),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletLayout(
      BuildContext context, QuizState quizState, ThemeData theme) {
    final double finalScore = quizState.totalScore;
    final int correctAnswers = quizState.userAnswers.values
        .where((answer) => (answer.score ?? 0) > 70)
        .length;
    final int totalQuestions = quizState.questions.length;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: _buildAppBar(theme, ref),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        _buildHeroScoreSection(theme, finalScore,
                            correctAnswers, totalQuestions, true),
                        _buildPerformanceInsights(
                            theme, finalScore, quizState, true),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 3,
                    child: _buildDetailedBreakdown(theme, quizState, true),
                  ),
                ],
              ),
              _buildActionButtons(theme, ref, true),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(
      BuildContext context, QuizState quizState, ThemeData theme) {
    final double finalScore = quizState.totalScore;
    final int correctAnswers = quizState.userAnswers.values
        .where((answer) => (answer.score ?? 0) > 70)
        .length;
    final int totalQuestions = quizState.questions.length;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: _buildAppBar(theme, ref),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 48),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildHeroScoreSection(theme, finalScore,
                                correctAnswers, totalQuestions, true),
                            const SizedBox(height: 24),
                            _buildPerformanceInsights(
                                theme, finalScore, quizState, true),
                            const SizedBox(height: 24),
                            _buildActionButtons(theme, ref, true),
                          ],
                        ),
                      ),
                      const SizedBox(width: 48),
                      Expanded(
                        flex: 3,
                        child: _buildDetailedBreakdown(theme, quizState, true),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme, WidgetRef ref) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'Quiz Results',
        style: theme.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.close_rounded),
        onPressed: () {
          HapticFeedback.lightImpact();
          ref.read(quizProvider.notifier).resetQuiz();
          ref.invalidate(dashboardProvider);
          context.goNamed('dashboard');
        },
      ),
    );
  }

  Widget _buildHeroScoreSection(ThemeData theme, double finalScore, int correct,
      int total, bool isWideScreen) {
    final double containerPadding = isWideScreen ? 40 : 32;
    final double circleSize = isWideScreen ? 140 : 120;

    return Container(
      margin: EdgeInsets.all(isWideScreen ? 16 : 24),
      padding: EdgeInsets.all(containerPadding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _getScoreColor(finalScore).withAlpha(26),
            _getScoreColor(finalScore).withAlpha(12),
          ],
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: _getScoreColor(finalScore).withAlpha(77),
          width: 2,
        ),
      ),
      child: Column(
        children: [
          // Animated score circle
          AnimatedBuilder(
            animation: _scoreAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _scoreAnimation.value,
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        _getScoreColor(finalScore),
                        _getScoreColor(finalScore).withAlpha(178),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getScoreColor(finalScore).withAlpha(77),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Progress circle
                      AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return CircularProgressIndicator(
                            value:
                                _progressAnimation.value * (finalScore / 100),
                            strokeWidth: 6,
                            backgroundColor: Colors.white.withAlpha(77),
                            valueColor:
                                const AlwaysStoppedAnimation(Colors.white),
                          );
                        },
                      ),
                      // Score text
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${finalScore.toInt()}%',
                              style: (isWideScreen
                                      ? theme.textTheme.displaySmall
                                      : theme.textTheme.headlineLarge)
                                  ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'SCORE',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white.withAlpha(229),
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.w600,
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
          ),

          const SizedBox(height: 24),

          // Performance message
          Text(
            _getPerformanceMessage(finalScore),
            style: (isWideScreen
                    ? theme.textTheme.headlineMedium
                    : theme.textTheme.headlineSmall)
                ?.copyWith(
              fontWeight: FontWeight.bold,
              color: _getScoreColor(finalScore),
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Stats row
          if (isWideScreen)
            Column(
              children: [
                _StatItem(
                  icon: Icons.check_circle_rounded,
                  label: 'Correct',
                  value: '$correct',
                  color: Colors.green,
                  isVertical: true,
                ),
                const SizedBox(height: 16),
                _StatItem(
                  icon: Icons.cancel_rounded,
                  label: 'Incorrect',
                  value: '${total - correct}',
                  color: Colors.red,
                  isVertical: true,
                ),
                const SizedBox(height: 16),
                _StatItem(
                  icon: Icons.quiz_rounded,
                  label: 'Total',
                  value: '$total',
                  color: theme.colorScheme.primary,
                  isVertical: true,
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatItem(
                  icon: Icons.check_circle_rounded,
                  label: 'Correct',
                  value: '$correct',
                  color: Colors.green,
                  isVertical: false,
                ),
                _StatItem(
                  icon: Icons.cancel_rounded,
                  label: 'Incorrect',
                  value: '${total - correct}',
                  color: Colors.red,
                  isVertical: false,
                ),
                _StatItem(
                  icon: Icons.quiz_rounded,
                  label: 'Total',
                  value: '$total',
                  color: theme.colorScheme.primary,
                  isVertical: false,
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildPerformanceInsights(
      ThemeData theme, double score, QuizState quizState, bool isWideScreen) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: isWideScreen ? 16 : 24, vertical: 8),
      padding: EdgeInsets.all(isWideScreen ? 24 : 20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.insights_rounded,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 12),
              Text(
                'Performance Insights',
                style: (isWideScreen
                        ? theme.textTheme.headlineSmall
                        : theme.textTheme.titleLarge)
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Question type breakdown
          ...(_getQuestionTypeBreakdown(quizState).entries.map((entry) {
            final correctCount = entry.value['correct'] ?? 0;
            final totalCount =
                entry.value['total'] ?? 1; // Prevent division by zero
            final percentage =
                totalCount > 0 ? (correctCount / totalCount * 100).round() : 0;

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _getQuestionTypeColor(entry.key),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '${_getQuestionTypeLabel(entry.key)}: $correctCount/$totalCount correct',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                  Text(
                    '$percentage%',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _getScoreColor(percentage.toDouble()),
                    ),
                  ),
                ],
              ),
            );
          }).toList()),
        ],
      ),
    );
  }

  Widget _buildDetailedBreakdown(
      ThemeData theme, QuizState quizState, bool isWideScreen) {
    return Container(
      margin:
          EdgeInsets.symmetric(horizontal: isWideScreen ? 16 : 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(isWideScreen ? 24 : 20),
            child: Row(
              children: [
                Icon(
                  Icons.list_alt_rounded,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Detailed Breakdown',
                  style: (isWideScreen
                          ? theme.textTheme.headlineSmall
                          : theme.textTheme.titleLarge)
                      ?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: _listController,
            builder: (context, child) {
              return Column(
                children: quizState.questions.asMap().entries.map((entry) {
                  final index = entry.key;
                  final question = entry.value;
                  final answer = quizState.userAnswers[question.id!];

                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _listController,
                      curve: Interval(
                        index * 0.1,
                        (index * 0.1) + 0.3,
                        curve: Curves.easeOutCubic,
                      ),
                    )),
                    child: FadeTransition(
                      opacity: CurvedAnimation(
                        parent: _listController,
                        curve: Interval(
                          index * 0.1,
                          (index * 0.1) + 0.3,
                          curve: Curves.easeIn,
                        ),
                      ),
                      child: _AnswerBreakdownCard(
                        question: question,
                        answer: answer,
                        questionNumber: index + 1,
                        isWideScreen: isWideScreen,
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(
      ThemeData theme, WidgetRef ref, bool isWideScreen) {
    return Padding(
      padding: EdgeInsets.all(isWideScreen ? 16 : 24),
      child: isWideScreen
          ? Row(
              children: [
                Expanded(
                  child: _buildRetakeButton(theme, ref),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildBackButton(theme, ref),
                ),
              ],
            )
          : Column(
              children: [
                _buildRetakeButton(theme, ref),
                const SizedBox(height: 12),
                _buildBackButton(theme, ref),
              ],
            ),
    );
  }

  Widget _buildRetakeButton(ThemeData theme, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);

    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          colors: [
            theme.colorScheme.primary,
            theme.colorScheme.primary.withAlpha(204),
          ],
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            HapticFeedback.mediumImpact();
            ref.read(quizProvider.notifier).resetQuiz();

            if (context.canPop()) {
              context.pop();
            } else {
              // Fallback if it can't pop (e.g., deep link)
              context.goNamed('startQuiz',
                  pathParameters: {'id': quizState.material!.id!.toString()},
                  extra: quizState.material);
            }
          },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.refresh_rounded, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  'Retake Quiz',
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
    );
  }

  Widget _buildBackButton(ThemeData theme, WidgetRef ref) {
    return OutlinedButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        ref.read(quizProvider.notifier).resetQuiz();
        ref.invalidate(dashboardProvider);
        context.goNamed('dashboard');
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text('Back to Materials'),
    );
  }

  Widget _buildErrorState(ThemeData theme) {
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'No Results Available',
              style: theme.textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Complete a quiz to see your results here.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getScoreColor(double score) {
    if (score >= 80) return Colors.green.shade600;
    if (score >= 60) return Colors.orange.shade600;
    return Colors.red.shade600;
  }

  String _getPerformanceMessage(double score) {
    if (score >= 90) return 'Outstanding Performance! 🎉';
    if (score >= 80) return 'Great Job! 👏';
    if (score >= 70) return 'Good Work! 👍';
    if (score >= 60) return 'Keep Practicing! 📚';
    return 'Room for Improvement 💪';
  }

  Map<String, Map<String, int>> _getQuestionTypeBreakdown(QuizState quizState) {
    final breakdown = <String, Map<String, int>>{};

    for (final question in quizState.questions) {
      final type = question.type;
      final answer = quizState.userAnswers[question.id!];
      final isCorrect = (answer?.score ?? 0) > 70;

      breakdown[type] ??= {'correct': 0, 'total': 0};
      breakdown[type]!['total'] = (breakdown[type]!['total'] ?? 0) + 1;
      if (isCorrect) {
        breakdown[type]!['correct'] = (breakdown[type]!['correct'] ?? 0) + 1;
      }
    }

    return breakdown;
  }

  Color _getQuestionTypeColor(String type) {
    switch (type) {
      case 'true_false':
        return Colors.green;
      case 'saq':
        return Colors.blue;
      case 'essay':
        return Colors.purple;
      case 'fill_in_blank':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  String _getQuestionTypeLabel(String type) {
    switch (type) {
      case 'true_false':
        return 'True/False';
      case 'saq':
        return 'Short Answer';
      case 'essay':
        return 'Essay';
      case 'fill_in_blank':
        return 'Fill in Blank';
      default:
        return 'Unknown';
    }
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isVertical;

  const _StatItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isVertical,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (isVertical) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withAlpha(26),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withAlpha(26),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _AnswerBreakdownCard extends StatelessWidget {
  final Question question;
  final Answer? answer;
  final int questionNumber;
  final bool isWideScreen;

  const _AnswerBreakdownCard({
    required this.question,
    this.answer,
    required this.questionNumber,
    required this.isWideScreen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final score = answer?.score ?? 0.0;
    final scoreColor =
        score > 70 ? Colors.green : (score > 40 ? Colors.orange : Colors.red);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(52),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(12),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: theme.copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.all(isWideScreen ? 24 : 20),
          childrenPadding: EdgeInsets.fromLTRB(isWideScreen ? 24 : 20, 0,
              isWideScreen ? 24 : 20, isWideScreen ? 24 : 20),
          leading: Container(
            width: isWideScreen ? 48 : 40,
            height: isWideScreen ? 48 : 40,
            decoration: BoxDecoration(
              color: scoreColor.withAlpha(26),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                '$questionNumber',
                style: (isWideScreen
                        ? theme.textTheme.titleLarge
                        : theme.textTheme.titleMedium)
                    ?.copyWith(
                  color: scoreColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          title: Text(
            question.questionText,
            style: (isWideScreen
                    ? theme.textTheme.titleLarge
                    : theme.textTheme.titleMedium)
                ?.copyWith(
              fontWeight: FontWeight.w600,
            ),
            maxLines: isWideScreen ? 3 : 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                Icon(
                  score > 70 ? Icons.check_circle : Icons.cancel,
                  size: 16,
                  color: scoreColor,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    answer?.answerText ?? 'Not answered',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                    ),
                    maxLines: isWideScreen ? 2 : 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          trailing: Container(
            padding: EdgeInsets.symmetric(
                horizontal: isWideScreen ? 16 : 12,
                vertical: isWideScreen ? 8 : 6),
            decoration: BoxDecoration(
              color: scoreColor.withAlpha(26),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              '${score.toInt()}%',
              style: (isWideScreen
                      ? theme.textTheme.titleSmall
                      : theme.textTheme.labelLarge)
                  ?.copyWith(
                color: scoreColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          children: [
            if (question.correctAnswer != null) ...[
              _InfoSection(
                title: 'Expected Answer',
                content: question.correctAnswer!,
                icon: Icons.lightbulb_outline_rounded,
                color: Colors.blue,
                isWideScreen: isWideScreen,
              ),
              const SizedBox(height: 16),
            ],
            _InfoSection(
              title: 'AI Feedback',
              content: answer?.feedback ?? 'No feedback available.',
              icon: Icons.psychology_rounded,
              color: Colors.purple,
              isWideScreen: isWideScreen,
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoSection extends StatelessWidget {
  final String title;
  final String content;
  final IconData icon;
  final Color color;
  final bool isWideScreen;

  const _InfoSection({
    required this.title,
    required this.content,
    required this.icon,
    required this.color,
    required this.isWideScreen,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(isWideScreen ? 20 : 16),
      decoration: BoxDecoration(
        color: color.withAlpha(12),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withAlpha(52),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: isWideScreen ? 24 : 20, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: (isWideScreen
                        ? theme.textTheme.titleMedium
                        : theme.textTheme.titleSmall)
                    ?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: (isWideScreen
                    ? theme.textTheme.bodyLarge
                    : theme.textTheme.bodyMedium)
                ?.copyWith(
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
