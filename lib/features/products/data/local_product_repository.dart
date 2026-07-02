import 'package:drift/drift.dart' as drift;

import '../../../core/database/app_database.dart';
import '../../../core/supabase/supabase_service.dart';
import '../../../core/supabase/tables.dart';

import 'product_model.dart';
import 'product_repository.dart';

class LocalProductRepository implements ProductRepository {
  final AppDatabase database;

  LocalProductRepository(this.database);

  ProductModel _map(Product p) {
    return ProductModel(
      id: p.id,
      name: p.name,
      barcode: p.barcode,
      purchasePrice: p.purchasePrice,
      sellingPrice: p.sellingPrice,
      mrp: p.mrp,
      unit: p.unit,
      isLooseItem: p.isLooseItem,
      stock: p.stock,
      createdAt: p.createdAt,
      updatedAt: p.updatedAt,
    );
  }

  @override
  Future<void> addProduct(ProductModel product) async {
    await database.productDao.insertProduct(
      ProductsCompanion.insert(
        name: product.name,
        purchasePrice: product.purchasePrice,
        sellingPrice: product.sellingPrice,
        mrp: product.mrp,
        unit: product.unit,
        barcode: drift.Value(product.barcode),
        isLooseItem: drift.Value(product.isLooseItem),
        stock: drift.Value(product.stock),
      ),
    );

    try {
      await SupabaseService.client
          .from(SupabaseTables.products)
          .insert({
        'name': product.name,
        'barcode': product.barcode,
        'purchase_price': product.purchasePrice,
        'selling_price': product.sellingPrice,
        'mrp': product.mrp,
        'unit': product.unit,
        'is_loose_item': product.isLooseItem,
        'stock': product.stock,
      });
    } catch (e) {
      print("SUPABASE ERROR: $e");
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    await database.productDao.updateProduct(
      Product(
        id: product.id!,
        name: product.name,
        barcode: product.barcode,
        purchasePrice: product.purchasePrice,
        sellingPrice: product.sellingPrice,
        mrp: product.mrp,
        unit: product.unit,
        isLooseItem: product.isLooseItem,
        stock: product.stock,
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
}