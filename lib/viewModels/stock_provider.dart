import 'package:event_with_thong/models/stock.dart';
import 'package:event_with_thong/services/product_variant_service.dart';
import 'package:event_with_thong/services/stock_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class StockProvider extends ChangeNotifier {
  StockService stockService = StockService.instance;
  ProductVariantService productVariantService = ProductVariantService.instance;

  Future<void> loadStock() async {
    await stockService.loadStock();
    Logger().d('load done');
    notifyListeners();
  }

  Future<List<StockModel>> getStock() async {
    Logger().d('load done');
    return await stockService.getAllStock();
  }

  Future<void> addStock(StockModel stock) async {
    await stockService.addStock(stock);
    await productVariantService.load();
    notifyListeners();
  }
}
