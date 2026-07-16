import 'sync_entity.dart';

abstract class SyncRepository<T extends SyncEntity> {
  Future<List<T>> getPendingSyncItems();

  Future<void> markAsSyncing(String uuid);

  Future<void> markAsSynced(String uuid);

  Future<void> markAsFailed(String uuid);

  Future<void> upload(T item);

  Future<void> download({
    DateTime? lastSyncedAt,
  });
}