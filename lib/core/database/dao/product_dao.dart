import 'package:drift/drift.dart' as drift;
import 'package:drift/drift.dart';

import '../app_database.dart';
import '../tables/products_table.dart';
import '../../../features/products/data/product_model.dart';

part 'product_dao.g.dart';

@DriftAccessor(tables: [Products])
class ProductDao extends DatabaseAccessor<AppDatabase>
    with _$ProductDaoMixin {
  ProductDao(super.db);

  Future<List<Product>> getAllProducts() {
    return (select(products)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.name),
      ]))
        .get();
  }

  Future<Product?> getProductById(int id) =>
      (select(products)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  Future<List<Product>> searchProducts(String query) {
    return (select(products)
      ..where(
            (t) =>
        t.deletedAt.isNull() &
        t.name.like('%$query%'),
      ))
        .get();
  }

  Future<int> insertProduct(
      ProductsCompanion product,
      ) =>
      into(products).insert(product);

  Future<void> insertOrUpdateProduct(
      ProductsCompanion product,
      ) async {
    final uuid = product.uuid.value;

    final existing = await (select(products)
      ..where((t) => t.uuid.equals(uuid)))
        .getSingleOrNull();

    if (existing == null) {
      await into(products).insert(product);
    } else {
      await (update(products)
        ..where((t) => t.uuid.equals(uuid)))
          .write(product);
    }
  }

  Future<bool> updateProduct(
      Product product,
      ) =>
      update(products).replace(product);

  Future<void> deleteProduct(int id) async {
    await (update(products)
      ..where((t) => t.id.equals(id)))
        .write(
      ProductsCompanion(
        deletedAt: drift.Value(DateTime.now()),
        isSynced: const drift.Value(false),
      ),
    );
  }

  Stream<List<Product>> watchProducts() {
    return (select(products)
      ..where((tbl) => tbl.deletedAt.isNull())
      ..orderBy([
            (tbl) => OrderingTerm.asc(tbl.name),
      ]))
        .watch();
  }
  Future<List<Product>> getPendingSyncProducts() {
    return (select(products)
      ..where(
            (tbl) =>
                tbl.isSynced.equals(false)
      ))
        .get();
  }

  Future<void> markProductSynced(String uuid) {
    return (update(products)
      ..where((tbl) => tbl.uuid.equals(uuid)))
        .write(
      const ProductsCompanion(
        isSynced: Value(true),
      ),
    );
  }

  Future<void> markProductPending(String uuid) {
    return (update(products)
      ..where((tbl) => tbl.uuid.equals(uuid)))
        .write(
      const ProductsCompanion(
        isSynced: Value(false),
      ),
    );
  }
  Future<void> deleteByUuid(String uuid) async {
    await (delete(products)
      ..where((tbl) => tbl.uuid.equals(uuid)))
        .go();
  }
  Future<void> upsertFromSync(ProductModel product) async {
    await into(products).insertOnConflictUpdate(
      ProductsCompanion(
        id: product.id == null
            ? const Value.absent()
            : Value(product.id!),
        uuid: Value(product.uuid),
        name: Value(product.name),
        barcode: Value(product.barcode),
        purchasePrice: Value(product.purchasePrice),
        sellingPrice: Value(product.sellingPrice),
        mrp: Value(product.mrp),
        unit: Value(product.unit),
        isLooseItem: Value(product.isLooseItem),
        stock: Value(product.stock),
        isSynced: const Value(true),
        deletedAt: Value(product.deletedAt),
        createdAt: Value(
          product.createdAt ?? DateTime.now(),
        ),
        updatedAt: Value(
          product.updatedAt ?? DateTime.now(),
        ),
      ),
    );
  }
}