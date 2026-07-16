import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/supabase/tables.dart';

class ShoppingSyncRepository {
  final AppDatabase database;

  ShoppingSyncRepository(this.database);

  Future<void> syncPendingItems() async {
    final pending =
    await database.shoppingDao.getPendingSyncItems();

    for (final item in pending) {
      print(
        'SHOPPING SYNC => ${item.name} | purchased=${item.isPurchased} | deleted=${item.deletedAt}',
      );
      try {
        print('Uploading shopping item: ${item.uuid}');
        await SupabaseService.client
            .from(SupabaseTables.shoppingItems)
            .upsert(
          {
            'uuid': item.uuid,
            'name': item.name,
            'category': item.category,
            'is_purchased': item.isPurchased,
            'deleted_at': item.deletedAt?.toIso8601String(),
            'created_at':
            item.createdAt.toIso8601String(),
            'updated_at':
            item.updatedAt.toIso8601String(),
            'is_synced': true,
          },
          onConflict: 'uuid',
        );

        await database.shoppingDao.markItemSynced(
          item.uuid,
        );
      } catch (e) {
        print('Shopping Sync Error: $e');
      }
    }
  }

  Future<void> downloadItems() async {
    print('DOWNLOAD SHOPPING START');

    final response = await SupabaseService.client
        .from(SupabaseTables.shoppingItems)
        .select()
        .order('updated_at');

    print('TOTAL SHOPPING ITEMS: ${response.length}');

    for (final item in response) {
      print(
        'DOWNLOAD => ${item['name']} | uuid=${item['uuid']}',
      );
      if (item['deleted_at'] != null) {
        await database.shoppingDao.deleteByUuid(
          item['uuid'],
        );
        continue;
      }

      await database.shoppingDao.insertOrUpdateItem(
        ShoppingItemsCompanion.insert(
          uuid: item['uuid'],
          name: item['name'],
          category: Value(item['category']),
          isPurchased:
          Value(item['is_purchased']),
          isSynced: const Value(true),
          deletedAt: const Value(null),
          createdAt: Value(
            item['created_at'] != null
                ? DateTime.parse(item['created_at'])
                : DateTime.now(),
          ),
          updatedAt: Value(
            item['updated_at'] != null
                ? DateTime.parse(item['updated_at'])
                : DateTime.now(),
          ),
        ),
      );
    }
  }
}