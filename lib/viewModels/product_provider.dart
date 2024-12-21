import 'package:event_with_thong/services/product_service.dart';
import 'package:flutter/material.dart';

class ProductModelProvider extends ChangeNotifier {
  final ProductService service = ProductService.instance;

  Future<void> load() async {
    await service.loadProduct();
    notifyListeners();
  }
}
