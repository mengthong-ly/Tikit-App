import 'package:event_with_thong/database/taxonomies_database.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:logger/web.dart';

class ProductService extends BaseService {
  ProductService._privateConstructor();
  static final ProductService _instance = ProductService._privateConstructor();
  static ProductService get instance => _instance;

  final ProductDatabase productData = ProductDatabase.instance;

  Future<void> loadProduct() async {
    try {
      if (await checkBox('product')) {
        final myBox = await getBox<ProductModel>('product');
        productData.products = myBox.values.toList();
        Logger().d('success load product');
      } else {
        final myBox = await getBox<ProductModel>('product');
        await myBox.putAll(productData.products.asMap());
        Logger().e('load from local');
      }
    } catch (e) {
      Logger().d('loadProduct: $e');
    }
  }

  Future<List<ProductModel>?> getAllProducts() async {
    try {
      final myBox = await getBox<ProductModel>('product');
      productData.products = myBox.values.toList();
      return productData.products;
    } catch (e) {
      Logger().d('getAllProduct Fail: $e');
      return null;
    }
  }

  ProductModel? getProductById(String id) {
    try {
      return productData.products.firstWhere((product) => product.id == id);
    } catch (e) {
      Logger().d('getProductById: $e');
      return null;
    }
  }

  Future<bool> addProduct(ProductModel product) async {
    try {
      final myBox = await getBox<ProductModel>('product');
      productData.products.add(product);
      await myBox.putAll(productData.products.asMap());
      await loadProduct();
      return true;
    } catch (e) {
      Logger().d('addProduct: $e');
      return false;
    }
  }

  Future<bool> removeProductById(String id) async {
    if (productData.products.isEmpty) return false;
    final int index =
        productData.products.indexWhere((product) => product.id == id);
    try {
      final myBox = await getBox<ProductModel>('product');
      await myBox.deleteAt(index);
      await loadProduct();
      return true;
    } catch (e) {
      Logger().d('removeProductById: $e');
      return false;
    }
  }

  Future<bool> updateProduct(ProductModel product) async {
    final int index =
        productData.products.indexWhere((model) => model.id == product.id);
    if (index == -1) {
      Logger().d('Product with id ${product.id} not found');
      return false;
    }
    try {
      final myBox = await getBox<ProductModel>('product');
      productData.products[index] = product;
      Logger().d(index);
      await myBox.putAll(productData.products.asMap());
      await loadProduct();
      return true;
    } catch (e) {
      Logger().d('updateProduct error: $e');
      return false;
    }
  }
}
