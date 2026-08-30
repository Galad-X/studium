import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/layout/responsive.dart';
import '../providers/quiz_provider.dart';

class QuizScreen extends ConsumerStatefulWidget {
  const QuizScreen({super.key});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late AnimationController _questionController;
  late Animation<double> _progressAnimation;
  late Animation<Offset> _questionSlideAnimation;
  late Animation<double> _questionFadeAnimation;

  // Add key to force widget rebuild for question changes
  Key _answerWidgetKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _questionController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _progressAnimation = CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    );

    _questionSlideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _questionController,
      curve: Curves.easeOutCubic,
    ));

    _questionFadeAnimation = CurvedAnimation(
      parent: _questionController,
      curve: Curves.easeIn,
    );

    _questionController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _questionController.dispose();
    super.dispose();
  }

  void _animateToNextQuestion() {
    _questionController.reverse().then((_) {
      // Generate new key to force answer widget rebuild
      setState(() {
        _answerWidgetKey = UniqueKey();
      });
      _questionController.forward();
    });
  }

  // Get responsive padding based on screen size
  EdgeInsets _getResponsivePadding(double screenWidth) {
    if (screenWidth >= 1200) {
      return const EdgeInsets.symmetric(horizontal: 64, vertical: 32);
    } else if (screenWidth >= 768) {
      return const EdgeInsets.symmetric(horizontal: 32, vertical: 24);
    } else {
      return const EdgeInsets.all(16);
    }
  }

  // Get responsive container constraints
  BoxConstraints _getContentConstraints(double screenWidth) {
    if (screenWidth >= 1200) {
      return const BoxConstraints(maxWidth: 800);
    } else if (screenWidth >= 768) {
      return const BoxConstraints(maxWidth: 600);
    } else {
      return const BoxConstraints();
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    ref.listen<QuizState>(quizProvider, (previous, next) {
      if (next.status == QuizStatus.completed) {
        context.goNamed('quizResults');
      }

      // Animate progress when question changes
      if (previous?.currentQuestionIndex != next.currentQuestionIndex) {
        _progressController.animateTo(
          (next.currentQuestionIndex + 1) / next.questions.length,
        );
        if (previous != null) {
          _animateToNextQuestion();
        }
      }
    });

    if (quizState.status != QuizStatus.active &&
        quizState.status != QuizStatus.submitting) {
      return _buildLoadingScreen(theme);
    }

    final Question currentQuestion =
        quizState.questions[quizState.currentQuestionIndex];
    final int currentNumber = quizState.currentQuestionIndex + 1;
    final int totalQuestions = quizState.questions.length;

    return ResponsiveScaffold(
      mobile: _buildQuizLayout(
        context,
        theme,
        quizState,
        currentQuestion,
        currentNumber,
        totalQuestions,
        screenSize.width,
        false,
      ),
      tablet: _buildQuizLayout(
        context,
        theme,
        quizState,
        currentQuestion,
        currentNumber,
        totalQuestions,
        screenSize.width,
        true,
      ),
      desktop: _buildQuizLayout(
        context,
        theme,
        quizState,
        currentQuestion,
        currentNumber,
        totalQuestions,
        screenSize.width,
        true,
      ),
    );
  }

  Widget _buildQuizLayout(
    BuildContext context,
    ThemeData theme,
    QuizState quizState,
    Question currentQuestion,
    int currentNumber,
    int totalQuestions,
    double screenWidth,
    bool isWideScreen,
  ) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _showExitConfirmation(context);
        }
      },
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        appBar: _buildAppBar(theme, quizState, screenWidth),
        body: Center(
          child: Container(
            constraints: _getContentConstraints(screenWidth),
            child: Column(
              children: [
                // Progress section
                _buildProgressSection(
                    theme, currentNumber, totalQuestions, screenWidth),

                // Question content
                Expanded(
                  child: SlideTransition(
                    position: _questionSlideAnimation,
                    child: FadeTransition(
                      opacity: _questionFadeAnimation,
                      child: SingleChildScrollView(
                        padding: _getResponsivePadding(screenWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildQuestionCard(
                                theme, currentQuestion, screenWidth),
                            SizedBox(height: screenWidth >= 768 ? 40 : 32),
                            _AnswerInputWidget(
                              key: _answerWidgetKey, // Add key here
                              question: currentQuestion,
                              onAnswerSubmitted: () {
                                // Small delay to ensure smooth animation
                                Future.delayed(
                                    const Duration(milliseconds: 100), () {
                                  _animateToNextQuestion();
                                });
                              },
                              screenWidth: screenWidth,
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
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
      ThemeData theme, QuizState quizState, double screenWidth) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: Text(
        quizState.material?.title ?? 'Quiz',
        style: theme.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: screenWidth >= 768 ? 24 : 20,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: screenWidth >= 768 ? 16 : 8),
          child: IconButton(
            onPressed: () => _showExitConfirmation(context),
            icon: const Icon(Icons.close_rounded),
            tooltip: 'Exit Quiz',
            iconSize: screenWidth >= 768 ? 28 : 24,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressSection(
      ThemeData theme, int current, int total, double screenWidth) {
    final padding = screenWidth >= 768 ? 32.0 : 24.0;
    final borderRadius = screenWidth >= 768 ? 32.0 : 24.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Question $current of $total',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: screenWidth >= 768 ? 18 : 16,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth >= 768 ? 16 : 12,
                  vertical: screenWidth >= 768 ? 8 : 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${((current / total) * 100).round()}%',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth >= 768 ? 14 : 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth >= 768 ? 20 : 16),
          AnimatedBuilder(
            animation: _progressAnimation,
            builder: (context, child) {
              return LinearProgressIndicator(
                value: _progressAnimation.value,
                minHeight: screenWidth >= 768 ? 10 : 8,
                borderRadius: BorderRadius.circular(screenWidth >= 768 ? 5 : 4),
                backgroundColor: theme.colorScheme.outline.withAlpha(52),
                valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(
      ThemeData theme, Question question, double screenWidth) {
    final padding = screenWidth >= 768 ? 32.0 : 24.0;
    final borderRadius = screenWidth >= 768 ? 24.0 : 20.0;
    final iconSize = screenWidth >= 768 ? 24.0 : 20.0;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primaryContainer.withAlpha(77),
            theme.colorScheme.surfaceContainerHighest,
          ],
        ),
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: theme.colorScheme.outline.withAlpha(52),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withAlpha(26),
            blurRadius: screenWidth >= 768 ? 12 : 10,
            offset: Offset(0, screenWidth >= 768 ? 6 : 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth >= 768 ? 10 : 8),
                decoration: BoxDecoration(
                  color: _getQuestionTypeColor(question.type).withAlpha(26),
                  borderRadius:
                      BorderRadius.circular(screenWidth >= 768 ? 10 : 8),
                ),
                child: Icon(
                  _getQuestionTypeIcon(question.type),
                  color: _getQuestionTypeColor(question.type),
                  size: iconSize,
                ),
              ),
              SizedBox(width: screenWidth >= 768 ? 16 : 12),
              Expanded(
                child: Text(
                  _getQuestionTypeLabel(question.type),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: _getQuestionTypeColor(question.type),
                    fontWeight: FontWeight.bold,
                    fontSize: screenWidth >= 768 ? 14 : 12,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: screenWidth >= 768 ? 24 : 20),
          Text(
            question.questionText,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              height: 1.4,
              fontSize: screenWidth >= 1200
                  ? 28
                  : screenWidth >= 768
                      ? 24
                      : 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingScreen(ThemeData theme) {
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
            ),
            const SizedBox(height: 24),
            Text(
              'Loading quiz...',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Exit Quiz?'),
        content: const Text(
          'Are you sure you want to exit? Your progress will be lost.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Continue Quiz'),
          ),
          FilledButton(
            onPressed: () {
              context.goNamed('dashboard');
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Exit'),
          ),
        ],
      ),
    );
  }

  IconData _getQuestionTypeIcon(String type) {
    switch (type) {
      case 'true_false':
        return Icons.check_box_rounded;
      case 'saq':
        return Icons.short_text_rounded;
      case 'essay':
        return Icons.article_rounded;
      case 'fill_in_blank':
        return Icons.edit_rounded;
      default:
        return Icons.help_outline_rounded;
    }
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
        return 'TRUE / FALSE';
      case 'saq':
        return 'SHORT ANSWER';
      case 'essay':
        return 'ESSAY';
      case 'fill_in_blank':
        return 'FILL IN THE BLANK';
      default:
        return 'QUESTION';
    }
  }
}

class _AnswerInputWidget extends ConsumerWidget {
  final Question question;
  final VoidCallback? onAnswerSubmitted;
  final double screenWidth;

  const _AnswerInputWidget({
    required this.question,
    this.onAnswerSubmitted,
    required this.screenWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    switch (question.type) {
      case 'true_false':
        return _TrueFalseInput(
          onSubmit: (answer) async {
            await ref.read(quizProvider.notifier).submitAnswer(answer);
            // Check if we're still in the same quiz and not completed
            final currentState = ref.read(quizProvider);
            if (currentState.status == QuizStatus.active) {
              onAnswerSubmitted?.call();
            }
          },
          screenWidth: screenWidth,
        );
      case 'saq':
      case 'essay':
      case 'fill_in_blank':
      default:
        return _TextInput(
          questionType: question.type,
          onAnswerSubmitted: onAnswerSubmitted,
          screenWidth: screenWidth,
        );
    }
  }
}

class _TextInput extends ConsumerStatefulWidget {
  final String questionType;
  final VoidCallback? onAnswerSubmitted;
  final double screenWidth;

  const _TextInput({
    required this.questionType,
    this.onAnswerSubmitted,
    required this.screenWidth,
  });

  @override
  ConsumerState<_TextInput> createState() => _TextInputState();
}

class _TextInputState extends ConsumerState<_TextInput> {
  final _formKey = GlobalKey<FormState>();
  final _answerController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _answerController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _submitAnswer() async {
    if (_formKey.currentState?.validate() ?? false) {
      HapticFeedback.mediumImpact();
      await ref
          .read(quizProvider.notifier)
          .submitAnswer(_answerController.text.trim());
      _answerController.clear();

      // Check if we're still in the same quiz and not completed
      final currentState = ref.read(quizProvider);
      if (currentState.status == QuizStatus.active) {
        widget.onAnswerSubmitted?.call();
      }
    }
  }

  int get _maxLines {
    switch (widget.questionType) {
      case 'essay':
        return widget.screenWidth >= 768 ? 10 : 8;
      case 'saq':
        return widget.screenWidth >= 768 ? 4 : 3;
      case 'fill_in_blank':
        return 1;
      default:
        return widget.screenWidth >= 768 ? 4 : 3;
    }
  }

  String get _hintText {
    switch (widget.questionType) {
      case 'essay':
        return 'Write your detailed response here...';
      case 'saq':
        return 'Enter your short answer...';
      case 'fill_in_blank':
        return 'Complete the blank...';
      default:
        return 'Type your answer here...';
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizProvider);
    final theme = Theme.of(context);
    final buttonHeight = widget.screenWidth >= 768 ? 64.0 : 56.0;
    final borderRadius = widget.screenWidth >= 768 ? 20.0 : 16.0;
    final padding = widget.screenWidth >= 768 ? 24.0 : 20.0;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: theme.colorScheme.outline.withAlpha(52),
              ),
            ),
            child: TextFormField(
              controller: _answerController,
              focusNode: _focusNode,
              maxLines: _maxLines,
              style: TextStyle(
                fontSize: widget.screenWidth >= 768 ? 16 : 14,
              ),
              decoration: InputDecoration(
                hintText: _hintText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.all(padding),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an answer.';
                }
                return null;
              },
              onFieldSubmitted: (_) => _submitAnswer(),
            ),
          ),
          SizedBox(height: widget.screenWidth >= 768 ? 32 : 24),
          Container(
            height: buttonHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.primary.withAlpha(204),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withAlpha(77),
                  blurRadius: widget.screenWidth >= 768 ? 16 : 12,
                  offset: Offset(0, widget.screenWidth >= 768 ? 6 : 4),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(borderRadius),
                onTap: quizState.status == QuizStatus.submitting
                    ? null
                    : _submitAnswer,
                child: Center(
                  child: quizState.status == QuizStatus.submitting
                      ? SizedBox(
                          width: widget.screenWidth >= 768 ? 28 : 24,
                          height: widget.screenWidth >= 768 ? 28 : 24,
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                              size: widget.screenWidth >= 768 ? 28 : 24,
                            ),
                            SizedBox(width: widget.screenWidth >= 768 ? 12 : 8),
                            Text(
                              'Submit Answer',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: widget.screenWidth >= 768 ? 18 : 16,
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
    );
  }
}

class _TrueFalseInput extends ConsumerWidget {
  final ValueChanged<String> onSubmit;
  final double screenWidth;

  const _TrueFalseInput({
    required this.onSubmit,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizState = ref.watch(quizProvider);
    final theme = Theme.of(context);
    final buttonHeight = screenWidth >= 768 ? 72.0 : 64.0;
    final borderRadius = screenWidth >= 768 ? 20.0 : 16.0;
    final iconSize = screenWidth >= 768 ? 32.0 : 28.0;
    final spacing = screenWidth >= 768 ? 20.0 : 16.0;

    if (quizState.status == QuizStatus.submitting) {
      return Center(
        child: Column(
          children: [
            CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
            ),
            SizedBox(height: spacing),
            Text(
              'Submitting answer...',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                fontSize: screenWidth >= 768 ? 16 : 14,
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // True button
        Container(
          height: buttonHeight,
          margin: EdgeInsets.only(bottom: spacing),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              colors: [
                Colors.green.shade600,
                Colors.green.shade500,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.green.withAlpha(77),
                blurRadius: screenWidth >= 768 ? 16 : 12,
                offset: Offset(0, screenWidth >= 768 ? 6 : 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: () {
                HapticFeedback.mediumImpact();
                onSubmit('True');
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.check_circle_rounded,
                      color: Colors.white,
                      size: iconSize,
                    ),
                    SizedBox(width: screenWidth >= 768 ? 16 : 12),
                    Text(
                      'TRUE',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: screenWidth >= 768 ? 20 : 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // False button
        Container(
          height: buttonHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              colors: [
                Colors.red.shade600,
                Colors.red.shade500,
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.red.withAlpha(77),
                blurRadius: screenWidth >= 768 ? 16 : 12,
                offset: Offset(0, screenWidth >= 768 ? 6 : 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(borderRadius),
              onTap: () {
                HapticFeedback.mediumImpact();
                onSubmit('False');
              },
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.cancel_rounded,
                      color: Colors.white,
                      size: iconSize,
                    ),
                    SizedBox(width: screenWidth >= 768 ? 16 : 12),
                    Text(
                      'FALSE',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        fontSize: screenWidth >= 768 ? 20 : 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
