// lib/core/services/study_material_service.dart
import 'package:flutter/foundation.dart';
import 'package:studium_client/studium_client.dart';

class StudyMaterialService {
  final Client _client;
  StudyMaterialService(this._client);

  Future<List<StudyMaterial>> getMaterials() async {
    return _client.studyMaterial.getMaterials();
  }

  Future<StudyMaterial> uploadMaterial({
    required String title,
    required String fileType,
    required ByteData fileData,
  }) async {
    return _client.studyMaterial
        .uploadMaterial(title, fileType, fileData, null);
  }

  Future<FileProcessing?> getProcessingStatus(int materialId) async {
    try {
      return await _client.studyMaterial.getProcessingStatus(materialId);
    } catch (e) {
      // It's okay to return null on failure, the UI can handle it.
      debugPrint(
          'Failed to get processing status for material $materialId: $e');
      return null;
    }
  }

  Future<void> deleteMaterial(int materialId) async {
    return _client.studyMaterial.deleteMaterial(materialId);
  }
}
