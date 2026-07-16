import 'package:drift/drift.dart' as drift;
import 'package:uuid/uuid.dart';
import '../../../core/database/app_database.dart';


import 'product_model.dart';
import 'product_repository.dart';

class LocalProductRepository implements ProductRepository {
  final AppDatabase database;
  static const Uuid _uuid = Uuid();
  LocalProductRepository(this.database);

  ProductModel _map(Product p) {
    return ProductModel(
      id: p.id,
      uuid: p.uuid,
      name: p.name,
      barcode: p.barcode,
      purchasePrice: p.purchasePrice,
      sellingPrice: p.sellingPrice,
      mrp: p.mrp,
      unit: p.unit,
      isLooseItem: p.isLooseItem,
      stock: p.stock,
      isSynced: p.isSynced,
      deletedAt: p.deletedAt,
      createdAt: p.createdAt,
      updatedAt: p.updatedAt,
    );
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    final uuid =
    product.uuid.isEmpty ? _uuid.v4() : product.uuid;

    await database.productDao.insertProduct(
      ProductsCompanion.insert(
        uuid: uuid,
        name: product.name,
        purchasePrice: product.purchasePrice,
        sellingPrice: product.sellingPrice,
        mrp: product.mrp,
        unit: product.unit,
        barcode: drift.Value(product.barcode),
        isLooseItem: drift.Value(product.isLooseItem),
        stock: drift.Value(product.stock),
        isSynced: const drift.Value(false),
        deletedAt: drift.Value(product.deletedAt),
      ),
    );

  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await database.productDao.updateProduct(
      Product(
        id: product.id!,
        uuid: product.uuid,
        name: product.name,
        barcode: product.barcode,
        purchasePrice: product.purchasePrice,
        sellingPrice: product.sellingPrice,
        mrp: product.mrp,
        unit: product.unit,
        isLooseItem: product.isLooseItem,
        stock: product.stock,
        isSynced: false,
        deletedAt: product.deletedAt,
        createdAt: product.createdAt!,
        updatedAt: DateTime.now(),
      ),
    );
  }

  @override
  Future<void> deleteProduct(int id) async {
    await database.productDao.deleteProduct(id);
  }

  @override
  Future<List<ProductModel>> getAllProducts() async {
    final list = await database.productDao.getAllProducts();
    return list.map(_map).toList();
  }

  @override
  Future<ProductModel?> getProductById(int id) async {
    final p = await database.productDao.getProductById(id);
    return p == null ? null : _map(p);
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    final list = await database.productDao.searchProducts(query);
    return list.map(_map).toList();
  }

  @override
  Stream<List<ProductModel>> watchProducts() {
    return database.productDao
        .watchProducts()
        .map((list) => list.map(_map).toList());
  }
  @override
  Future<List<ProductModel>> getPendingSyncProducts() async {
    final list = await database.productDao.getPendingSyncProducts();
    return list.map(_map).toList();
  }

  @override
  Future<void> markProductSynced(String uuid) async {
    await database.productDao.markProductSynced(uuid);
  }

  @override
  Future<void> markProductPending(String uuid) async {
    await database.productDao.markProductPending(uuid);
  }
  @override
  Future<void> insertOrUpdateProduct(ProductModel product) async {
    await database.productDao.insertOrUpdateProduct(
      ProductsCompanion(
        id: product.id == null
            ? const drift.Value.absent()
            : drift.Value(product.id!),
        uuid: drift.Value(product.uuid),
        name: drift.Value(product.name),
        barcode: drift.Value(product.barcode),
        purchasePrice: drift.Value(product.purchasePrice),
        sellingPrice: drift.Value(product.sellingPrice),
        mrp: drift.Value(product.mrp),
        unit: drift.Value(product.unit),
        isLooseItem: drift.Value(product.isLooseItem),
        stock: drift.Value(product.stock),
        isSynced: drift.Value(product.isSynced),
        deletedAt: drift.Value(product.deletedAt),
        createdAt: drift.Value(
          product.createdAt ?? DateTime.now(),
        ),
        updatedAt: drift.Value(
          product.updatedAt ?? DateTime.now(),
        ),
      ),
    );
  }
}