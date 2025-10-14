import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';
import '../../../core/providers/service_providers.dart';

enum WritingStatus { initial, loading, success, error }

class WritingState {
  final WritingStatus status;
  final AcademicWriting? result;
  final String? errorMessage;

  WritingState({
    this.status = WritingStatus.initial,
    this.result,
    this.errorMessage,
  });
}

class WritingNotifier extends StateNotifier<WritingState> {
  final Ref _ref;
  WritingNotifier(this._ref) : super(WritingState());

  Future<void> generateDocument({
    int? studyMaterialId,
    required String type,
    required String title,
    int? wordCount,
  }) async {
    state = WritingState(status: WritingStatus.loading);
    try {
      final result = await _ref.read(aiServiceProvider).generateAcademicWriting(
            studyMaterialId: studyMaterialId,
            type: type,
            title: title,
            format: 'docx', // Defaulting to docx for now
            targetWordCount: wordCount,
          );
      state = WritingState(status: WritingStatus.success, result: result);
    } catch (e) {
      state =
          WritingState(status: WritingStatus.error, errorMessage: e.toString());
    }
  }

  void reset() {
    state = WritingState();
  }
}

final academicWritingProvider =
    StateNotifierProvider.autoDispose<WritingNotifier, WritingState>((ref) {
  return WritingNotifier(ref);
});
