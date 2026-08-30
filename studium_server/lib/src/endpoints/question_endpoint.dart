// lib/src/endpoints/question_endpoint.dart
import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../generated/protocol.dart';
import '../util/endpoint_utils.dart';

class QuestionEndpoint extends Endpoint with EndpointUtils {
  @override
  bool get requireLogin => true;

  /// Generate sample questions for unauthorized/demo users
  Future<List<Question>> getSampleQuestions(Session session, int count) async {
    // Limit sample questions
    final limitedCount = count > 5 ? 5 : count;

    try {
      // Use pre-defined sample content
      const sampleContent = '''
      Photosynthesis is the process by which green plants and some other organisms use sunlight 
      to synthesize foods with the help of chlorophyll. During this process, plants convert carbon 
      dioxide and water into glucose and oxygen. The equation for photosynthesis is: 
      6CO2 + 6H2O + light energy → C6H12O6 + 6O2. This process occurs in two main stages: 
      the light-dependent reactions and the Calvin cycle.
      ''';

      final prompt = _buildQuestionPrompt(
        sampleContent,
        ['saq', 'true_false'],
        limitedCount,
      );
      final response = await _callLlmApi(session, prompt);
      final questionsData = jsonDecode(response)['questions'] as List;

      return questionsData
          .take(limitedCount)
          .map((q) => Question(
                studyMaterialId: 0, // Sample material ID
                type: q['type'] ?? 'saq',
                questionText: q['text'] ?? 'Sample question',
                correctAnswer: q['correctAnswer'],
                createdAt: DateTime.now(),
                difficulty: '',
                bloomsLevel: '',
                estimatedTime: 5,
              ))
          .toList();
    } catch (e) {
      session.log('Error generating sample questions: $e',
          level: LogLevel.error);
      // Return fallback sample questions
      return _getFallbackSampleQuestions(limitedCount);
    }
  }

  // Helper methods
  String _buildQuestionPrompt(
      String content, List<String> questionTypes, int count) {
    return '''
Based on the following educational content, generate exactly $count questions of the specified types.

Content: $content

Question types to generate: ${questionTypes.join(', ')}

Requirements:
- Generate diverse questions that test different aspects of the content
- For each question, provide the type, question text, and correct answer where applicable
- For true/false questions, make them challenging but fair
- For essay questions, provide guidance on key points to cover
- Ensure questions are clear and unambiguous

Return the response as a JSON object with this exact structure:
{
  "questions": [
    {
      "type": "question_type",
      "text": "Question text here",
      "correctAnswer": "Answer (if applicable)",
      "diagramImageUrl": null,
      "labelingPoints": null
    }
  ]
}
''';
  }

  List<Question> _getFallbackSampleQuestions(int count) {
    final fallbackQuestions = [
      Question(
        studyMaterialId: 0,
        type: 'saq',
        questionText: 'What is photosynthesis?',
        correctAnswer:
            'The process by which plants convert light energy into chemical energy',
        createdAt: DateTime.now(),
        difficulty: '',
        bloomsLevel: '',
        estimatedTime: 5,
      ),
      Question(
        studyMaterialId: 0,
        type: 'true_false',
        questionText: 'Photosynthesis occurs only in the presence of sunlight.',
        correctAnswer: 'True',
        createdAt: DateTime.now(),
        difficulty: '',
        bloomsLevel: '',
        estimatedTime: 5,
      ),
      Question(
        studyMaterialId: 0,
        type: 'saq',
        questionText: 'What are the main reactants in photosynthesis?',
        correctAnswer: 'Carbon dioxide, water, and light energy',
        createdAt: DateTime.now(),
        difficulty: '',
        bloomsLevel: '',
        estimatedTime: 5,
      ),
    ];

    return fallbackQuestions.take(count).toList();
  }

  Future<String> _callLlmApi(Session session, String prompt) async {
    final apiKey = await getApiKey(session, 'openAI');

    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'model': 'gpt-4',
          'messages': [
            {
              'role': 'system',
              'content':
                  'You are an educational AI that generates high-quality questions and evaluations. Always respond with valid JSON.'
            },
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
          'max_tokens': 2000,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'LLM API error: ${response.statusCode} - ${response.body}');
      }

      final responseData = jsonDecode(response.body);
      return responseData['choices'][0]['message']['content'];
    } catch (e) {
      session.log('LLM API call failed: $e', level: LogLevel.error);
      rethrow;
    }
  }
}
