import 'package:drift/drift.dart';
import '../../../core/database/app_database.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/supabase/tables.dart';

class ProductSyncRepository {
  final AppDatabase database;

  ProductSyncRepository(this.database);

  Future<void> syncPendingProducts() async {
    final pending =
    await database.productDao.getPendingSyncProducts();

    for (final product in pending) {
      print(
        'SYNC => ${product.name} | deletedAt=${product.deletedAt}',
      );
      try {
        await SupabaseService.client
            .from(SupabaseTables.products)
            .upsert(
            {
          'uuid': product.uuid,
          'name': product.name,
          'barcode': product.barcode,
          'purchase_price': product.purchasePrice,
          'selling_price': product.sellingPrice,
          'mrp': product.mrp,
          'unit': product.unit,
          'is_loose_item': product.isLooseItem,
          'stock': product.stock,
          'created_at': product.createdAt?.toIso8601String(),
          'updated_at': product.updatedAt?.toIso8601String(),
          'deleted_at': product.deletedAt?.toIso8601String(),
              'is_synced': true,
            },
          onConflict: 'uuid',
        );
        print('SYNC SUCCESS => ${product.name}');
        await database.productDao.markProductSynced(
          product.uuid,
        );
      } catch (e) {
        print('Product Sync Error: $e');
      }
    }
  }
  Future<void> downloadProducts() async {
    final response = await SupabaseService.client
        .from(SupabaseTables.products)
        .select()
        .order('updated_at');

    for (final item in response) {
      print(item);
      if (item['deleted_at'] != null) {
        await database.productDao.deleteByUuid(
          item['uuid'],
        );
        continue;
      }

      await database.productDao.insertOrUpdateProduct(
        ProductsCompanion.insert(
          uuid: item['uuid'],
          name: item['name'],
          purchasePrice: (item['purchase_price'] as num).toDouble(),
          sellingPrice: (item['selling_price'] as num).toDouble(),
          mrp: (item['mrp'] as num).toDouble(),
          unit: item['unit'],
          barcode: Value(item['barcode']),
          isLooseItem: Value(item['is_loose_item']),
          stock: Value(item['stock']),
          isSynced: const Value(true),
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
          deletedAt: const Value(null),
        ),
      );
    }
  }
}