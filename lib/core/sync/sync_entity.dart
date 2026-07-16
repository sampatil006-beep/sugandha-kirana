import 'sync_status.dart';

abstract class SyncEntity {
  String get uuid;

  bool get isSynced;

  DateTime? get deletedAt;

  DateTime? get updatedAt;

  SyncStatus get syncStatus;
}