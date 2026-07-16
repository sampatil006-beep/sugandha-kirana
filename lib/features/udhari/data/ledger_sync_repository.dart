import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/supabase/tables.dart';

class LedgerSyncRepository {
  final AppDatabase database;

  LedgerSyncRepository(this.database);

  Future<void> syncPendingEntries() async {
    final pending =
    await database.ledgerDao.getPendingSyncEntries();

    for (final entry in pending) {
      try {
        await SupabaseService.client
            .from(SupabaseTables.ledgerEntries)
            .upsert(
          {
            'uuid': entry.uuid,
            'customer_uuid': entry.customerUuid,
            'type': entry.type,
            'amount': entry.amount,
            'note': entry.note,
            'entry_date':
            entry.entryDate.toIso8601String(),
            'created_at':
            entry.createdAt?.toIso8601String(),
            'updated_at':
            entry.updatedAt?.toIso8601String(),
            'deleted_at':
            entry.deletedAt?.toIso8601String(),
            'is_synced': true,
          },
          onConflict: 'uuid',
        );

        await database.ledgerDao.markEntrySynced(
          entry.uuid,
        );
      } catch (e) {
        print('Ledger Sync Error: $e');
      }
    }
  }

  Future<void> downloadEntries() async {
    final response = await SupabaseService.client
        .from(SupabaseTables.ledgerEntries)
        .select()
        .order('updated_at');

    for (final item in response) {
      if (item['deleted_at'] != null) {
        await database.ledgerDao.deleteByUuid(
          item['uuid'],
        );
        continue;
      }

      await database.ledgerDao.insertOrUpdateEntry(
        LedgerEntriesCompanion.insert(
          uuid: item['uuid'],
          customerUuid: item['customer_uuid'],
          type: item['type'],
          amount:
          (item['amount'] as num).toDouble(),
          note: Value(item['note']),
          entryDate: DateTime.parse(
            item['entry_date'],
          ),
          isSynced: const Value(true),
          createdAt: Value(
            item['created_at'] != null
                ? DateTime.parse(
              item['created_at'],
            )
                : DateTime.now(),
          ),
          updatedAt: Value(
            item['updated_at'] != null
                ? DateTime.parse(
              item['updated_at'],
            )
                : DateTime.now(),
          ),
          deletedAt: Value(
            item['deleted_at'] != null
                ? DateTime.parse(
              item['deleted_at'],
            )
                : null,
          ),
        ),
      );
    }
  }
}