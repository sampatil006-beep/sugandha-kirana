import 'product_model.dart';

abstract class ProductRepository {
  Future<List<ProductModel>> getAllProducts();

  Future<ProductModel?> getProductById(int id);

  Future<List<ProductModel>> searchProducts(String query);

  Future<void> addProduct(ProductModel product);

  Future<void> updateProduct(ProductModel product);

  Future<void> deleteProduct(int id);

  Stream<List<ProductModel>> watchProducts();

}