import 'package:event_with_thong/models/classification.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/services/classification_service.dart';
import 'package:flutter/material.dart';

class ClassificationProvider extends ChangeNotifier {
  ClassificationService service = ClassificationService.instance;

  List<ProductTaxonModel> productTaxonModels = [];
  List<ProductModel?> _product = [];

  void load() async {
    productTaxonModels = await service.getAllProductTaxon() ?? [];
    notifyListeners();
  }

  List<ProductModel?> getAllProductByTaxonId(String taxonId) {
    _product = service.getAllProductsByTaxonId(taxonId) ?? [];
    return _product;
  }

  TaxonModel getTaxonByProductId(ProductModel product) {
    return service.getTaxonByProductId(product);
  }
}
