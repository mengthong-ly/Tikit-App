import 'package:event_with_thong/database/taxonomies_database.dart';
import 'package:event_with_thong/models/classification.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:event_with_thong/services/product_service.dart';
import 'package:event_with_thong/services/taxon_service.dart';
import 'package:logger/web.dart';

class ClassificationService extends BaseService {
  ClassificationService._privateConstructor();
  static final ClassificationService _instance =
      ClassificationService._privateConstructor();
  static ClassificationService get instance => _instance;

  ProductTaxonDatabase productTaxonData = ProductTaxonDatabase.instance;
  ProductService productService = ProductService.instance;
  TaxonService taxonService = TaxonService.instance;

  Future<bool> updateProductTaxonById(
      TaxonModel taxon, ProductModel product) async {
    final int index = productTaxonData.classifications
        .indexWhere((model) => model.productId == product.id);

    if (index == -1) return false;

    ProductTaxonModel newProductTaxon = ProductTaxonModel(
      id: product.id,
      taxonId: taxon.id,
      productId: product.id,
    );

    try {
      final myBox = await getBox<ProductTaxonModel>('product_taxon');
      productTaxonData.classifications[index] = newProductTaxon;
      await myBox.putAll(productTaxonData.classifications.asMap());
      await loadProductTaxon();
      return true;
    } catch (e) {
      Logger().d('updateProductTaxonById: $e');
      return false;
    }
  }

  TaxonModel getTaxonByProductId(ProductModel product) {
    final ProductTaxonModel classificated =
        productTaxonData.classifications.firstWhere(
      (classffication) => classffication.productId == product.id,
    );
    return taxonService.getTaxonById(classificated.taxonId)!;
  }

  Future<bool> addProductTaxon(TaxonModel taxon, ProductModel product) async {
    try {
      final ProductTaxonModel model = ProductTaxonModel(
          id: (productTaxonData.classifications.length + 1).toString(),
          taxonId: taxon.id,
          productId: product.id);
      final myBox = await getBox<ProductTaxonModel>('product_taxon');
      productTaxonData.classifications.add(model);
      await myBox.putAll(productTaxonData.classifications.asMap());
      await loadProductTaxon();
      return true;
    } catch (e) {
      Logger().d('addProductTaxon: $e');
      return false;
    }
  }

  Future<void> loadProductTaxon() async {
    try {
      if (await checkBox('product_taxon')) {
        final myBox = await getBox<ProductTaxonModel>('product_taxon');
        await myBox.putAll(productTaxonData.classifications.asMap());
        await productService.loadProduct();
        productTaxonData.classifications = myBox.values.toList();
        print(productService.productData.products.first.name);
      }
    } catch (e) {
      Logger().d('loadProductTaxon: $e');
    }
  }

  Future<List<ProductTaxonModel>?> getAllProductTaxon() async {
    try {
      await loadProductTaxon();
      return productTaxonData.classifications;
    } catch (e) {
      return null;
    }
  }

  Future<List<ProductTaxonModel>?> getProductsTaxonByTaxonId(
      String taxonId) async {
    try {
      return productTaxonData.classifications
          .where((classification) => classification.taxonId == taxonId)
          .toList();
    } catch (e) {
      Logger().d('getProductsTaxonByTaxonId: $e');
      return null;
    }
  }

  Future<List<ProductTaxonModel>?> getProductsTaxonByProduct(
      String productId) async {
    try {
      return productTaxonData.classifications
          .where((classification) => classification.productId == productId)
          .toList();
    } catch (e) {
      Logger().d('getProductsTaxonByProductId: $e');
      return null;
    }
  }

  List<ProductModel?>? getAllProductsByTaxonId(String taxonId) {
    try {
      return productTaxonData.classifications
          .where(
            (classification) => classification.taxonId == taxonId,
          )
          .toList()
          .map(
            (classification) =>
                productService.getProductById(classification.productId),
          )
          .toList();
    } catch (e) {
      Logger().d('getAllProductsByTaxonId: $e');
      return null;
    }
  }

  Future<bool> removeProductTaxonById(String id) async {
    try {
      final index = productTaxonData.classifications
          .indexWhere((classification) => classification.id == id);
      if (index == -1) return false;
      final myBox = await getBox<ProductTaxonModel>('product_taxon');
      await myBox.deleteAt(index);
      await loadProductTaxon();
      return true;
    } catch (e) {
      Logger().d('removeProductTaxonById: $e');
      return false;
    }
  }

  Future<bool> removeProductTaxonByTaxonId(String taxonId) async {
    try {
      final myBox = await getBox<ProductTaxonModel>('product_taxon');
      for (ProductTaxonModel classification
          in productTaxonData.classifications) {
        if (classification.taxonId == taxonId) {
          await myBox.deleteAt(productTaxonData.classifications
              .indexWhere((model) => model.id == classification.id));
          productTaxonData.classifications.remove(classification);
        }
      }
      await loadProductTaxon();
      return true;
    } catch (e) {
      Logger().d('removeProductTaxonByTaxonId: $e');
      return false;
    }
  }

  Future<bool> removeProductTaxonByProductId(String productId) async {
    try {
      final myBox = await getBox<ProductTaxonModel>('product_taxon');
      for (ProductTaxonModel classification
          in productTaxonData.classifications) {
        if (classification.productId == productId) {
          await myBox.deleteAt(productTaxonData.classifications
              .indexWhere((model) => model.id == classification.id));
          productTaxonData.classifications.remove(classification);
        }
      }
      await loadProductTaxon();
      return true;
    } catch (e) {
      Logger().d('removeProductTaxonByProductId: $e');
      return false;
    }
  }
}
