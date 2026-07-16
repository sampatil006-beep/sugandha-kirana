import 'sync_repository.dart';

class SyncService {
  final List<SyncRepository> _repositories;

  SyncService({
    required List<SyncRepository> repositories,
  }) : _repositories = repositories;

  Future<void> syncAll() async {
    for (final repository in _repositories) {
      final pendingItems = await repository.getPendingSyncItems();

      for (final item in pendingItems) {
        try {
          await repository.markAsSyncing(item.uuid);

          await repository.upload(item);

          await repository.markAsSynced(item.uuid);
        } catch (_) {
          await repository.markAsFailed(item.uuid);
        }
      }

      await repository.download(
        lastSyncedAt: null,
      );
    }
  }
}