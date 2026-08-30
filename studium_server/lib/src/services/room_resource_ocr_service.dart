import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/server.dart';

import '../generated/protocol.dart';
import '../util/configuration_secrets.dart';
import 'background_job_service.dart';

class RoomResourceOcrService {
  static Future<int> processResource(Session session, int resourceId) async {
    final resource = await RoomResource.db.findById(session, resourceId);
    if (resource == null || resource.status != 'processing') {
      throw StateError('Room OCR resource is not available.');
    }
    try {
      final apiKey = ConfigurationSecrets.read(session, 'ocrApiKey');
      if (apiKey == null || apiKey.isEmpty) {
        throw StateError('Room OCR is not configured.');
      }
      final uri = Uri.tryParse(resource.uri ?? '');
      if (uri == null || !{'http', 'https'}.contains(uri.scheme)) {
        throw StateError('Room OCR source URL is invalid.');
      }
      final source = await http.get(uri).timeout(const Duration(seconds: 30));
      if (source.statusCode != 200 ||
          source.bodyBytes.length > 50 * 1024 * 1024) {
        throw StateError('Room OCR source could not be downloaded.');
      }
      final response = await http
          .post(
            Uri.https('vision.googleapis.com', '/v1/images:annotate', {
              'key': apiKey,
            }),
            headers: {'content-type': 'application/json'},
            body: jsonEncode({
              'requests': [
                {
                  'image': {'content': base64Encode(source.bodyBytes)},
                  'features': [
                    {'type': 'DOCUMENT_TEXT_DETECTION'},
                  ],
                },
              ],
            }),
          )
          .timeout(const Duration(seconds: 30));
      if (response.statusCode < 200 || response.statusCode >= 300) {
        throw StateError('Room OCR provider request failed.');
      }
      final payload = jsonDecode(response.body) as Map<String, dynamic>;
      final responses = payload['responses'];
      String? text;
      if (responses is List<dynamic> && responses.isNotEmpty) {
        final first = responses.first;
        final annotation =
            first is Map<String, dynamic> ? first['fullTextAnnotation'] : null;
        final candidate =
            annotation is Map<String, dynamic> ? annotation['text'] : null;
        if (candidate is String) text = candidate;
      }
      if (text == null ||
          text.trim().isEmpty ||
          text.length > 2 * 1024 * 1024) {
        throw StateError('Room OCR returned no usable text.');
      }
      final extractedText = text.trim();
      final now = DateTime.now().toUtc();
      await session.db.transaction((transaction) async {
        resource.content = extractedText;
        resource.status = 'active';
        resource.updatedAt = now;
        await RoomResource.db.updateRow(
          session,
          resource,
          transaction: transaction,
        );
        const chunkSize = 6000;
        var index = 0;
        for (var start = 0;
            start < resource.content!.length;
            start += chunkSize) {
          final end = (start + chunkSize).clamp(0, resource.content!.length);
          final chunk = resource.content!.substring(start, end).trim();
          if (chunk.isEmpty) continue;
          await RoomResourceChunk.db.insertRow(
            session,
            RoomResourceChunk(
              roomResourceId: resource.id!,
              chunkIndex: index++,
              content: chunk,
              tokenCount: chunk.split(RegExp(r'\s+')).length,
              createdAt: now,
            ),
            transaction: transaction,
          );
        }
        await BackgroundJobService.enqueue(
          session,
          jobType: 'room_resource.index_embeddings',
          payload: {'resourceId': resource.id},
        );
      });
      return extractedText.length;
    } catch (error) {
      // Keep the resource processing while the durable job is retryable. The
      // worker marks it failed only after the final attempt.
      resource.status = 'processing';
      resource.updatedAt = DateTime.now().toUtc();
      await RoomResource.db.updateRow(session, resource);
      rethrow;
    }
  }
}
