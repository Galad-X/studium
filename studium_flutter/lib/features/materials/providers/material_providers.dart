import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:studium_client/studium_client.dart';

import '../../../api/serverpod_client.dart';

// A provider that fetches the list of study materials from the backend.
// .autoDispose will automatically clean up the state when the widget is removed.
final materialsProvider =
    FutureProvider.autoDispose<List<StudyMaterial>>((ref) async {
  try {
    return await client.studyMaterial.getMaterials();
  } catch (e) {
    // Handle potential exceptions from the server call
    debugPrint('Failed to fetch materials: $e');
    return []; // Return empty list on error to prevent UI crash
  }
});
