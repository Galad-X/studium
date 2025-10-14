import 'package:flutter/foundation.dart' hide Summary;
import 'package:studium_client/studium_client.dart';

class AiService {
  final Client _client;
  AiService(this._client);

  /// Calls the backend to generate a summary for a given material.
  /// The backend handles the word count based on user subscription status.
  Future<Summary> generateSummary(int materialId) async {
    try {
      return await _client.ai.generateSummary(materialId, null);
    } catch (e) {
      // Provide a more user-friendly error message
      throw Exception(
          'Failed to communicate with the AI. Please try again later.');
    }
  }

  Future<ResearchComparison> generateResearchComparison(int materialId) async {
    try {
      return await _client.ai.generateResearchComparison(materialId);
    } catch (e) {
      // The backend will throw 'Premium access required' if the user is not premium.
      // We can catch and re-throw a more specific error or let the UI handle it.
      if (e.toString().contains('Premium access required')) {
        throw Exception(
            'This is a premium feature. Please upgrade your account to use it.');
      }
      throw Exception(
          'Failed to generate research comparison. Please try again.');
    }
  }

  Future<List<Question>> generateQuestions({
    required int materialId,
    required int count,
    List<String>? questionTypes, // e.g., ['saq', 'true_false']
  }) async {
    try {
      return await _client.ai
          .generateQuestions(materialId, questionTypes, count);
    } catch (e) {
      debugPrint('Error generating questions: $e');
      throw Exception(
          'Failed to generate questions. The AI might be busy, please try again.');
    }
  }

  /// Submits a user's answer to a question and gets an AI-evaluated result.
  Future<Answer> submitAnswer({
    required int questionId,
    required String answerText,
  }) async {
    try {
      return await _client.ai.submitAnswer(questionId, answerText);
    } catch (e) {
      debugPrint('Error submitting answer: $e');
      throw Exception('Failed to submit your answer for evaluation.');
    }
  }

  /// Calls the backend to generate a full academic document.
  Future<AcademicWriting> generateAcademicWriting({
    int? studyMaterialId,
    required String type,
    required String title,
    required String format,
    int? targetWordCount,
  }) async {
    try {
      return await _client.academicWriting.generateWriting(
        studyMaterialId,
        type,
        title,
        format,
        targetWordCount,
      );
    } catch (e) {
      debugPrint('Error generating academic writing: $e');
      if (e.toString().contains('Premium access required')) {
        throw Exception(
            'This is a premium feature. Please upgrade to generate academic documents.');
      }
      throw Exception(
          'Failed to generate the document. The AI may be busy or the request is too complex.');
    }
  }
}
