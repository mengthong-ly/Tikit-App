import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductModelProvider extends ChangeNotifier {
  final ProductService service = ProductService.instance;

  Future<void> load() async {
    await service.loadProduct();
    notifyListeners();
  }

  ProductModel? getProductById(String id) {
    return service.getProductById(id);
  }
}
