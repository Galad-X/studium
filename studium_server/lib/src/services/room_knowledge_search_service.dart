import 'package:serverpod/database.dart';
import 'package:serverpod/server.dart';

import '../generated/protocol.dart';

class RoomKnowledgeSearchService {
  static Future<List<RoomResourceChunk>> search(
    Session session, {
    required int roomId,
    required List<num> queryEmbedding,
    required int limit,
  }) async {
    final safeLimit = limit.clamp(1, 20);
    final result = await session.db.unsafeQuery(
      '''
      SELECT c."id" AS id
      FROM "room_resource_chunks" c
      INNER JOIN "room_resources" r
        ON r."id" = c."roomResourceId"
      INNER JOIN "room_resource_chunk_embeddings" e
        ON e."roomResourceChunkId" = c."id"
      WHERE r."roomId" = @roomId
        AND r."status" = 'active'
      ORDER BY e."embedding" <=> @query::vector
      LIMIT @limit
      ''',
      parameters: QueryParameters.named({
        'query': '[${queryEmbedding.join(',')}]',
        'roomId': roomId,
        'limit': safeLimit,
      }),
    );
    final rankedIds =
        result.map((row) => row.toColumnMap()['id']).whereType<int>().toList();
    if (rankedIds.isEmpty) return const [];
    // The generated nullable-ID column has a runtime generic mismatch for
    // inSet on Serverpod 3.4.x. Hydrate the bounded result set individually,
    // retaining the database-computed ranking order.
    final chunks = <RoomResourceChunk>[];
    for (final id in rankedIds) {
      final chunk = await RoomResourceChunk.db.findById(session, id);
      if (chunk != null) chunks.add(chunk);
    }
    return chunks;
  }
}
