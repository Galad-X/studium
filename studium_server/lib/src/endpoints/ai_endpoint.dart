// lib/src/endpoints/ai_endpoint.dart
import 'package:serverpod/serverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../generated/protocol.dart';
import '../util/endpoint_utils.dart';

class AiEndpoint extends Endpoint with EndpointUtils {
  @override
  bool get requireLogin => true;


 
  // Generate questions from study material
 Future<List<Question>> generateQuestions(Session session, int studyMaterialId,
      List<String>? questionTypes, int count) async {
    final userId = await getAuthenticatedUserId(session);
    final isPremium = await isPremiumUser(session, userId);

    // Validate question count based on user type
    final maxQuestions = isPremium ? 50 : 10;
    final finalCount = count > maxQuestions ? maxQuestions : count;

    final allPossibleTypes = [
      'saq',
      'essay',
      'true_false',
      'matching',
      'fill_in_blank',
      'problem_solving',
      'diagram_labeling',
      'case_study',
      'long_answer'
    ];

    // Fetch and validate study material first to get content for analysis
    final material = await StudyMaterial.db.findById(session, studyMaterialId);
    if (material == null || material.userId != userId) {
      throw Exception('Material not found or unauthorized');
    }

    // Get processed content for analysis
    final fileProcessing = await FileProcessing.db.findFirstRow(
      session,
      where: (t) => t.studyMaterialId.equals(studyMaterialId),
    );
    final content = fileProcessing?.processedText ?? material.contentText;
    if (content == null || content.isEmpty) {
      throw Exception('Content not available for processing');
    }

    // Analyze content to get suitable question types
    final contentBasedTypes =
        _selectSuitableQuestionTypes(content, allPossibleTypes);

    final List<String> finalTypes;

    if (isPremium) {
      // Premium users: Use requested types if provided, otherwise use content-based analysis
      if (questionTypes != null && questionTypes.isNotEmpty) {
        final validRequestedTypes =
            questionTypes.where((t) => allPossibleTypes.contains(t)).toList();

        finalTypes = validRequestedTypes.isNotEmpty
            ? validRequestedTypes
            : contentBasedTypes;
      } else {
        finalTypes = contentBasedTypes;
      }
    } else {
      // Free users: Always restricted to basic types
      final allowedFreeTypes = ['saq', 'true_false'];
      final contentBasedFreeTypes = contentBasedTypes
          .where((type) => allowedFreeTypes.contains(type))
          .toList();

      finalTypes = contentBasedFreeTypes.isNotEmpty
          ? contentBasedFreeTypes
          : allowedFreeTypes;
    }

    try {
      // Generate questions using AI with enhanced prompt
      final prompt =
          _buildEnhancedQuestionPrompt(content, finalTypes, finalCount);
      final response = await _callLlmApi(session, prompt);
      final questionsData = jsonDecode(response)['questions'] as List;

      // Save questions to database with enhanced fields
      final questions = <Question>[];
      for (var i = 0; i < questionsData.length && i < finalCount; i++) {
        final questionData = questionsData[i];
        final type = questionData['type'] ?? finalTypes.first;

        final question = Question(
          studyMaterialId: material.id!,
          type: type,
          questionText: questionData['question'] ?? '',
          correctAnswer: questionData['answer'],
          options: questionData['options']
              ?.cast<String>(), // For multiple choice/matching
          explanation: questionData['explanation'],
          difficulty: questionData['difficulty'] ?? 'medium',
          bloomsLevel: questionData['bloomsLevel'] ?? 'understand',
          estimatedTime: questionData['estimatedTime'] ?? 5,
          tags: questionData['tags']?.cast<String>() ?? [],
          diagramImageUrl: questionData['diagramImageUrl'],
          labelingPoints: questionData['labelingPoints']?.cast<String>(),
          createdAt: DateTime.now(),
        );

        final savedQuestion = await Question.db.insertRow(session, question);
        questions.add(savedQuestion);
      }

      // Update study history
      await _updateStudyHistory(
        session,
        userId,
        questionIds: questions.map((q) => q.id!).toList(),
      );

      return questions;
    } catch (e) {
      print('Error generating questions: $e');
      throw Exception('Failed to generate questions: ${e.toString()}');
    }
  }

  List<String> _selectSuitableQuestionTypes(
      String text, List<String> allTypes) {
    final selectedTypes = <String>[];
    final textLength = text.length;
    // final wordCount = text.split(' ').length;

    // Analyze content characteristics
    final hasNumbers = RegExp(r'\d+').hasMatch(text);
    final hasFormulas = RegExp(r'[=+\-*/()^]').hasMatch(text);
    final hasDefinitions =
        RegExp(r'\b(is|are|means|refers to|defined as)\b', caseSensitive: false)
            .hasMatch(text);
    final hasProcesses = RegExp(
            r'\b(step|process|procedure|method|algorithm)\b',
            caseSensitive: false)
        .hasMatch(text);
    final hasConcepts =
        RegExp(r'\b(concept|theory|principle|law|rule)\b', caseSensitive: false)
            .hasMatch(text);
    final hasExamples = RegExp(r'\b(example|instance|case|illustration)\b',
            caseSensitive: false)
        .hasMatch(text);

    // Always include basic types
    selectedTypes.addAll(['saq', 'true_false', 'fill_in_blank']);

    // Add specific types based on content analysis
    if (textLength > 1000) {
      selectedTypes.addAll(['essay', 'long_answer']);
    }

    if (hasNumbers || hasFormulas) {
      selectedTypes.add('problem_solving');
    }

    if (hasDefinitions && hasConcepts) {
      selectedTypes.add('matching');
    }

    if (hasExamples || hasProcesses) {
      selectedTypes.add('case_study');
    }

    if (text.contains(RegExp(r'\b(diagram|figure|chart|graph|image)\b',
        caseSensitive: false))) {
      selectedTypes.add('diagram_labeling');
    }

    return selectedTypes.toSet().toList(); // Remove duplicates
  }

 /// Submit and evaluate an answer
  Future<Answer> submitAnswer(
      Session session, int questionId, String answerText) async {
    final userId = await getAuthenticatedUserId(session);

    final question = await Question.db.findById(session, questionId);
    if (question == null) throw Exception('Question not found');

    try {
      // Evaluate answer using AI
      final prompt = _buildEvaluationPrompt(question, answerText);
      final response = await _callLlmApi(session, prompt);
      final evaluation = jsonDecode(response);

      final answer = Answer(
        userId: userId,
        questionId: questionId,
        answerText: answerText,
        score: (evaluation['score'] as num?)?.toDouble() ?? 0.0,
        feedback: evaluation['feedback'] ?? 'No feedback available',
        submittedAt: DateTime.now(),
      );

      return await Answer.db.insertRow(session, answer);
    } catch (e) {
      print('Error evaluating answer: $e');
      // Return answer with basic evaluation
      final answer = Answer(
        userId: userId,
        questionId: questionId,
        answerText: answerText,
        score: 50.0, // Default score
        feedback:
            'Answer submitted successfully. Detailed feedback unavailable.',
        submittedAt: DateTime.now(),
      );
      return await Answer.db.insertRow(session, answer);
    }
  }

   String _buildEvaluationPrompt(Question question, String answerText) {
    return '''
Evaluate this student answer for the given question:

Question: ${question.questionText}
Question Type: ${question.type}
Correct Answer: ${question.correctAnswer ?? 'No specific correct answer'}
Student Answer: $answerText

Provide evaluation in JSON format:
{
  "score": 85, // Score out of 100
  "feedback": "Detailed feedback explaining the score and areas for improvement"
}

Evaluation criteria:
- Accuracy of content
- Completeness of answer
- Understanding demonstrated
- Quality of explanation
- Relevance to question

Be constructive and educational in your feedback.
''';
  }

  // Generate summary
  Future<Summary> generateSummary(
      Session session, int studyMaterialId, int? maxWords) async {
  final userId = await getAuthenticatedUserId(session);
   

     final isPremium = await isPremiumUser(session, userId);
    final material = await StudyMaterial.db.findById(session, studyMaterialId);
    if (material == null || material.userId != userId) {
      throw Exception('Material not found or unauthorized');
    }

    final fileProcessing = await FileProcessing.db.findFirstRow(session,
        where: (t) => t.studyMaterialId.equals(studyMaterialId));
    final content = fileProcessing?.processedText ?? material.contentText;
    if (content == null) throw Exception('Content not available');

    final prompt = _buildSummaryPrompt(
        content, isPremium ? null : maxWords ?? 200, isPremium);
    final response = await _callLlmApi(session, prompt);
    final summaryData = jsonDecode(response);

    final summary = Summary(
      studyMaterialId: studyMaterialId,
      userId: userId,
      isPremium: isPremium,
      subject: summaryData['subject'],
      topic: summaryData['topic'],
      wordCount: summaryData['wordCount'],
      introduction: summaryData['introduction'],
      subtopics: summaryData['subtopics']?.cast<String>(),
      nuggets: summaryData['nuggets']?.cast<String>(),
      createdAt: DateTime.now(),
    );
    final savedSummary = await Summary.db.insertRow(session, summary);

    await _updateStudyHistory(session, userId, summaryIds: [savedSummary.id!]);
    return savedSummary;
  }

  // Generate sample summary
  Future<Summary> generateSampleSummary(Session session, int maxWords) async {
    final sampleMaterial = await StudyMaterial.db
        .findFirstRow(session, where: (t) => t.title.equals('Sample Material'));
    if (sampleMaterial == null) throw Exception('Sample material not found');

    final prompt = _buildSummaryPrompt(
        sampleMaterial.contentText ?? 'Sample educational content',
        maxWords,
        false);
    final response = await _callLlmApi(session, prompt);
    final summaryData = jsonDecode(response);

    return Summary(
      studyMaterialId: sampleMaterial.id!,
      userId: 0, // Dummy user ID for sample
      isPremium: false,
      subject: summaryData['subject'],
      topic: summaryData['topic'],
      wordCount: summaryData['wordCount'],
      introduction: summaryData['introduction'],
      subtopics: summaryData['subtopics']?.cast<String>(),
      nuggets: summaryData['nuggets']?.cast<String>(),
      createdAt: DateTime.now(),
    );
  }

  // Generate academic writing (premium only)
  Future<AcademicWriting> generateAcademicWriting(
      Session session,
      int? studyMaterialId,
      String type,
      String title,
      String format,
      int? targetWordCount) async {
        final userId = await getAuthenticatedUserId(session);
    if (!await isPremiumUser(session, userId)) {
      throw Exception('Premium access required');
    }

   

    String? content;
    if (studyMaterialId != null) {
      final material =
          await StudyMaterial.db.findById(session, studyMaterialId);
      if (material == null || material.userId != userId) {
        throw Exception('Material not found or unauthorized');
      }
      final fileProcessing = await FileProcessing.db.findFirstRow(session,
          where: (t) => t.studyMaterialId.equals(studyMaterialId));
      content = fileProcessing?.processedText ?? material.contentText;
      if (content == null) throw Exception('Content not available');
    }

    final prompt =
        _buildWritingPrompt(content, type, title, targetWordCount ?? 1000);
    final response = await _callLlmApi(session, prompt);
    final writingData = jsonDecode(response);

    // Generate file (e.g., PDF or DOCX)
    final fileUrl = await _generateDocument(writingData['content'], format);

    final writing = AcademicWriting(
      userId: userId,
      studyMaterialId: studyMaterialId,
      type: type,
      title: title,
      wordCount: writingData['wordCount'],
      content: writingData['content'],
      format: format,
      fileUrl: fileUrl,
      createdAt: DateTime.now(),
    );
    final savedWriting = await AcademicWriting.db.insertRow(session, writing);

    await _updateStudyHistory(session, userId, writingIds: [savedWriting.id!]);
    return savedWriting;
  }

  // Generate research comparison (premium only)
  Future<ResearchComparison> generateResearchComparison(
      Session session, int studyMaterialId) async {
        final userId = await getAuthenticatedUserId(session);
    if (! await isPremiumUser(session, userId)) {
      throw Exception('Premium access required');
    }

    

    final material = await StudyMaterial.db.findById(session, studyMaterialId);
    if (material == null || material.userId != userId) {
      throw Exception('Material not found or unauthorized');
    }

    final fileProcessing = await FileProcessing.db.findFirstRow(session,
        where: (t) => t.studyMaterialId.equals(studyMaterialId));
    final content = fileProcessing?.processedText ?? material.contentText;
    if (content == null) throw Exception('Content not available');

    final prompt = _buildResearchComparisonPrompt(content);
    final response = await _callLlmApi(session, prompt);
    final comparisonData = jsonDecode(response);

    final comparison = ResearchComparison(
      studyMaterialId: studyMaterialId,
      summaryId: null, // Optionally link to a summary
      newerFindings: comparisonData['newerFindings'],
      unsolvedProblems: comparisonData['unsolvedProblems']?.cast<String>(),
      createdAt: DateTime.now(),
    );
    return await ResearchComparison.db.insertRow(session, comparison);
  }

  // Helper methods
  Future<String> _callLlmApi(Session session, String prompt) async {
   
    final apiKey = await getApiKey(session, 'openAI');


    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'model': 'gpt-4',
        'messages': [
          {'role': 'user', 'content': prompt}
        ],
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('LLM API error: ${response.body}');
    }

    final responseData = jsonDecode(response.body);
    return responseData['choices'][0]['message']['content'];
  }

   Future<void> _updateStudyHistory(Session session, int userId,
      {List<int>? materialIds,
      List<int>? questionIds,
      List<int>? summaryIds,
      List<int>? writingIds}) async {
    var history = await StudyHistory.db
        .findFirstRow(session, where: (t) => t.userId.equals(userId));
    if (history == null) {
      history = StudyHistory(
        userId: userId,
        materialIds: materialIds ?? [],
        questionIds: questionIds ?? [],
        summaryIds: summaryIds ?? [],
        writingIds: writingIds ?? [],
        progress: 0.0,
        lastUpdated: DateTime.now(),
      );
      await StudyHistory.db.insertRow(session, history);
    } else {
      history = history.copyWith(
        materialIds: materialIds != null
            ? [...history.materialIds, ...materialIds]
            : history.materialIds,
        questionIds: questionIds != null
            ? [...history.questionIds, ...questionIds]
            : history.questionIds,
        summaryIds: summaryIds != null
            ? [...history.summaryIds, ...summaryIds]
            : history.summaryIds,
        writingIds: writingIds != null
            ? [...history.writingIds, ...writingIds]
            : history.writingIds,
        lastUpdated: DateTime.now(),
      );
      await StudyHistory.db.updateRow(session, history);
    }
  }

  // Helper methods
 // Enhanced prompt builder for better AI question generation
  String _buildEnhancedQuestionPrompt(
      String content, List<String> types, int count) {
    return '''
Generate $count educational questions based on the following content. 
Create a variety of question types from: ${types.join(', ')}.

Content:
$content

Requirements:
1. Return valid JSON with this structure:
{
  "questions": [
    {
      "type": "question_type",
      "question": "The question text",
      "answer": "Correct answer or sample answer",
      "options": ["option1", "option2", "option3", "option4"], // For multiple choice/matching only
      "explanation": "Detailed explanation of the correct answer",
      "difficulty": "easy|medium|hard",
      "bloomsLevel": "remember|understand|apply|analyze|evaluate|create",
      "estimatedTime": 5, // Time in minutes
      "tags": ["tag1", "tag2"], // Relevant subject tags
      "diagramImageUrl": null, // Only for diagram_labeling questions
      "labelingPoints": null // Only for diagram_labeling questions
    }
  ]
}

2. Question type guidelines:
   - saq: Short answer questions (1-2 sentences)
   - essay: Longer analytical questions
   - true_false: Boolean questions with explanations
   - matching: Provide 4-6 options to match
   - fill_in_blank: Use _____ for blanks
   - problem_solving: Mathematical or logical problems
   - case_study: Scenario-based questions
   - long_answer: Detailed explanatory questions

3. Bloom's Taxonomy levels:
   - remember: Recall facts and basic concepts
   - understand: Explain ideas or concepts
   - apply: Use information in new situations
   - analyze: Draw connections among ideas
   - evaluate: Justify a stand or decision
   - create: Produce new or original work

4. Difficulty levels:
   - easy: Basic recall and understanding
   - medium: Application and analysis
   - hard: Evaluation and creation

5. Ensure questions are:
   - Clear and unambiguous
   - Directly related to the content
   - Educationally valuable
   - Appropriately challenging

Generate diverse, high-quality questions that test different aspects of the content.
''';
  }


  String _buildSummaryPrompt(String content, int? maxWords, bool isPremium) {
    return '''
Summarize the following content: 
$content
${isPremium ? 'Provide a detailed summary with subject, topic, introduction, subtopics, and Provide key nuggets or takeaways, Ensure the summary is suitable for study purposes, Focus on the main concepts, key points, and important information that a student should remember.' : 'Provide a brief summary (max $maxWords words) with subject, topic, and key points.'}
Return as a JSON object with fields: subject, topic, wordCount, introduction (optional), subtopics (list), nuggets (list).
''';
  }

  String _buildWritingPrompt(
      String? content, String type, String title, int targetWordCount) {
    return '''
Generate an academic document of type "$type" with title "$title" and approximately $targetWordCount words.
${content != null ? 'Base it on the following content: $content' : 'Use general knowledge relevant to the type.'}
Return as a JSON object with fields: content, wordCount.
''';
  }

  String _buildResearchComparisonPrompt(String content) {
    return '''
Compare the following content with recent findings in the field: 
$content
Identify newer findings and unsolved problems. Return as a JSON object with fields: newerFindings (string), unsolvedProblems (list of strings).
''';
  }

  Future<String> _generateDocument(String content, String format) async {
    // Implement document generation (e.g., using a library like pdf or python-docx via a separate service)
    return 'https://example.com/generated-document.$format';
  }
}
