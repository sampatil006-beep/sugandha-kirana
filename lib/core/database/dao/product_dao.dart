import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/products_table.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase>
    with _$ProductDaoMixin {
  ProductDao(super.db);

  Future<List<Product>> getAllProducts() =>
      select(products).get();

  Future<Product?> getProductById(int id) =>
      (select(products)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<Product>> searchProducts(String query) =>
      (select(products)
        ..where((t) => t.name.like('%$query%')))
          .get();

  Future<int> insertProduct(
      ProductsCompanion product,
      ) =>
      into(products).insert(product);

  Future<bool> updateProduct(
      Product product,
      ) =>
      update(products).replace(product);

  Future<int> deleteProduct(int id) =>
      (delete(products)..where((t) => t.id.equals(id)))
          .go();

  Stream<List<Product>> watchProducts() =>
      select(products).watch();
}