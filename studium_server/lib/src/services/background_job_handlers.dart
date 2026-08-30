import 'background_worker_service.dart';
import '../generated/protocol.dart';
import 'opportunity_source_refresh_service.dart';
import 'room_embedding_service.dart';
import 'room_resource_ocr_service.dart';

class BackgroundJobHandlers {
  static Map<String, BackgroundJobHandler> defaults() => {
        'room_resource.index_embeddings': (session, job, payload) async {
          final resourceId = payload['resourceId'];
          if (resourceId is! int) {
            throw FormatException('Invalid room embedding job payload.');
          }
          await RoomEmbeddingService.indexResource(session, resourceId);
        },
        'room_resource.ocr': (session, job, payload) async {
          final resourceId = payload['resourceId'];
          if (resourceId is! int) {
            throw FormatException('Invalid room OCR job payload.');
          }
          try {
            await RoomResourceOcrService.processResource(session, resourceId);
          } catch (_) {
            if (job.attempts >= job.maxAttempts) {
              final resource = await RoomResource.db.findById(
                session,
                resourceId,
              );
              if (resource != null) {
                resource.status = 'failed';
                resource.updatedAt = DateTime.now().toUtc();
                await RoomResource.db.updateRow(session, resource);
              }
            }
            rethrow;
          }
        },
        'opportunity_source.refresh': (session, job, payload) async {
          final sourceId = payload['sourceId'];
          if (sourceId is! int) {
            throw FormatException('Invalid opportunity refresh job payload.');
          }
          await OpportunitySourceRefreshService.refreshSource(
              session, sourceId);
        },
      };
}
