import 'package:flutter/foundation.dart';

import '../../../core/database/app_database.dart';
import 'product_model.dart';
import 'supabase_product_repository.dart';

class ProductSyncService {
  final AppDatabase database;
  final SupabaseProductRepository supabaseRepository;

  ProductSyncService({
    required this.database,
    required this.supabaseRepository,
  });

  Future<void> syncProducts() async {
    try {
      debugPrint("========== PRODUCT SYNC STARTED ==========");

      //------------------------------------------
      // STEP 1
      // Upload Local Unsynced Products
      //------------------------------------------

      final unsyncedProducts =
      await database.productDao.getPendingSyncProducts();

      if (unsyncedProducts.isNotEmpty) {
        final products = unsyncedProducts
            .map((e) => ProductModel.fromJson(e.toJson()))
            .toList();

        await supabaseRepository.uploadProducts(products);

        debugPrint(
          "Uploaded ${products.length} unsynced products",
        );
      }

//------------------------------------------
// STEP 2
// Download Latest Products
//------------------------------------------

      final remoteProducts =
      await supabaseRepository.downloadProducts();

      debugPrint(
        "Downloaded ${remoteProducts.length} products",
      );

//------------------------------------------
// STEP 3
// Save into Drift
//------------------------------------------

      for (final product in remoteProducts) {
        final localProduct =
        await database.productDao.getProductById(product.id ?? 0);

        if (localProduct == null) {
          await database.productDao.upsertFromSync(product);
          continue;
        }

        final localUpdated =
            localProduct.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

        final remoteUpdated =
            product.updatedAt ?? DateTime.fromMillisecondsSinceEpoch(0);

        if (remoteUpdated.isAfter(localUpdated)) {
          await database.productDao.upsertFromSync(product);
        }
      }

      //------------------------------------------
      // STEP 4
      // Mark Uploaded Products Synced
      //------------------------------------------

      if (unsyncedProducts.isNotEmpty) {
        for (final product in unsyncedProducts) {
          try {
            await database.productDao.markProductSynced(
              product.uuid,
            );
          } catch (e) {
            debugPrint(
              "Failed to mark synced: ${product.uuid}",
            );
          }
        }
      }

      debugPrint("========== PRODUCT SYNC FINISHED ==========");
    } catch (e, s) {
      debugPrint("PRODUCT SYNC ERROR");
      debugPrint(e.toString());
      debugPrintStack(stackTrace: s);
      rethrow;
    }
  }
}