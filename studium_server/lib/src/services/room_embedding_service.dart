import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:serverpod/database.dart';
import 'package:serverpod/server.dart';

import '../generated/protocol.dart';
import '../util/configuration_secrets.dart';

class RoomEmbeddingService {
  static Future<int> indexResource(
    Session session,
    int resourceId,
  ) async {
    final resource = await RoomResource.db.findById(session, resourceId);
    if (resource == null || resource.status != 'active') {
      throw Exception('Room resource not found.');
    }
    final chunks = await RoomResourceChunk.db.find(
      session,
      where: (t) => t.roomResourceId.equals(resourceId),
      orderBy: (t) => t.chunkIndex,
      limit: 100,
    );
    if (chunks.isEmpty) return 0;
    final apiKey = ConfigurationSecrets.read(session, 'openAi');
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('Room embeddings are not configured.');
    }
    final response = await http
        .post(
          Uri.parse('https://api.openai.com/v1/embeddings'),
          headers: {
            'authorization': 'Bearer $apiKey',
            'content-type': 'application/json',
          },
          body: jsonEncode({
            'model': 'text-embedding-3-small',
            'input': chunks.map((chunk) => chunk.content).toList(),
          }),
        )
        .timeout(const Duration(seconds: 30));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception('Room embedding request failed.');
    }
    final payload = jsonDecode(response.body) as Map<String, dynamic>;
    final values = payload['data'];
    if (values is! List<dynamic> || values.length != chunks.length) {
      throw Exception('Room embedding response was incomplete.');
    }
    for (var index = 0; index < chunks.length; index++) {
      final item = values[index];
      final embedding = item is Map<String, dynamic> ? item['embedding'] : null;
      if (embedding is! List<dynamic> || embedding.isEmpty) {
        throw Exception('Room embedding response was invalid.');
      }
      final encodedEmbedding = jsonEncode(embedding);
      chunks[index].embedding = encodedEmbedding;
      await RoomResourceChunk.db.updateRow(session, chunks[index]);
      await session.db.unsafeExecute(
        'INSERT INTO "room_resource_chunk_embeddings" '
        '("roomResourceChunkId", "embedding", "updatedAt") '
        'VALUES (@id, @embedding::vector, @updatedAt) '
        'ON CONFLICT ("roomResourceChunkId") DO UPDATE SET '
        '"embedding" = EXCLUDED."embedding", "updatedAt" = EXCLUDED."updatedAt"',
        parameters: QueryParameters.named({
          'embedding': encodedEmbedding,
          'id': chunks[index].id,
          'updatedAt': DateTime.now().toUtc(),
        }),
      );
    }
    return chunks.length;
  }
}
