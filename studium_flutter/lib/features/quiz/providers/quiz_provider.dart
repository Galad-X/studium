import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/providers/service_providers.dart';

enum QuizStatus { initial, loading, active, submitting, completed }

// The state class for our quiz
class QuizState {
  final QuizStatus status;
  final StudyMaterial? material; // The material the quiz is for
  final List<Question> questions;
  final Map<int, Answer> userAnswers; // Map<questionId, Answer>
  final int currentQuestionIndex;
  final String? errorMessage;

  QuizState({
    this.status = QuizStatus.initial,
    this.material,
    this.questions = const [],
    this.userAnswers = const {},
    this.currentQuestionIndex = 0,
    this.errorMessage,
  });

  // Helper to calculate score
  double get totalScore {
    if (userAnswers.isEmpty) return 0.0;
    double total = 0;
    for (var answer in userAnswers.values) {
      total += answer.score ?? 0;
    }
    return total / userAnswers.length;
  }

  QuizState copyWith({
    QuizStatus? status,
    StudyMaterial? material,
    List<Question>? questions,
    Map<int, Answer>? userAnswers,
    int? currentQuestionIndex,
    String? errorMessage,
    bool clearError = false,
  }) {
    return QuizState(
      status: status ?? this.status,
      material: material ?? this.material,
      questions: questions ?? this.questions,
      userAnswers: userAnswers ?? this.userAnswers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

// The StateNotifier
class QuizNotifier extends StateNotifier<QuizState> {
  final Ref _ref;
  QuizNotifier(this._ref) : super(QuizState());

  Future<void> startQuiz({
    required StudyMaterial material,
    required int count,
    List<String>? questionTypes,
  }) async {
    state = state.copyWith(
        status: QuizStatus.loading, material: material, clearError: true);
    try {
      final questions = await _ref.read(aiServiceProvider).generateQuestions(
            materialId: material.id!,
            count: count,
            questionTypes: questionTypes,
          );
      if (questions.isEmpty) {
        throw Exception('Could not generate any questions for this material.');
      }
      state = state.copyWith(
        status: QuizStatus.active,
        questions: questions,
      );
    } catch (e) {
      state = state.copyWith(
          status: QuizStatus.initial, errorMessage: e.toString());
    }
  }

  Future<void> submitAnswer(String answerText) async {
    if (state.status != QuizStatus.active) return;

    final currentQuestion = state.questions[state.currentQuestionIndex];
    state = state.copyWith(status: QuizStatus.submitting, clearError: true);

    try {
      final result = await _ref.read(aiServiceProvider).submitAnswer(
            questionId: currentQuestion.id!,
            answerText: answerText,
          );

      final newAnswers = Map<int, Answer>.from(state.userAnswers);
      newAnswers[currentQuestion.id!] = result;

      // Check if it's the last question
      if (state.currentQuestionIndex >= state.questions.length - 1) {
        state = state.copyWith(
          status: QuizStatus.completed,
          userAnswers: newAnswers,
        );
      } else {
        // Move to the next question
        state = state.copyWith(
          status: QuizStatus.active,
          userAnswers: newAnswers,
          currentQuestionIndex: state.currentQuestionIndex + 1,
        );
      }
    } catch (e) {
      state =
          state.copyWith(status: QuizStatus.active, errorMessage: e.toString());
    }
  }

  void resetQuiz() {
    state = QuizState();
  }
}

// The provider
final quizProvider =
    StateNotifierProvider.autoDispose<QuizNotifier, QuizState>((ref) {
  // 1. Create the instance of the notifier.
  final notifier = QuizNotifier(ref);

  // 2. Schedule a cleanup task when the provider is disposed.
  //    This now calls the method directly on the `notifier` instance we just created,
  //    which breaks the dependency cycle.
  ref.onDispose(() {
    notifier.resetQuiz();
  });

  // 3. Return the fully configured notifier instance.
  return notifier;
});
