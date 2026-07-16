import '../../features/products/data/product_model.dart';
import '../../features/products/data/product_repository.dart';
import '../../features/products/data/supabase_product_repository.dart';

class ProductSyncService {
  final ProductRepository localRepository;
  final SupabaseProductRepository remoteRepository;

  ProductSyncService({
    required this.localRepository,
    required this.remoteRepository,
  });

  Future<void> syncPendingProducts() async {
    final pending =
    await localRepository.getPendingSyncProducts();

    for (final ProductModel product in pending) {
      try {
        await remoteRepository.upsertProduct(product);

        await localRepository.markProductSynced(
          product.uuid,
        );
      } catch (_) {
        await localRepository.markProductPending(
          product.uuid,
        );
      }
    }
  }
}