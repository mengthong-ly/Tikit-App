import 'package:event_with_thong/models/option_type.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/product_variant.dart';
import 'package:event_with_thong/models/stock.dart';
import 'package:event_with_thong/services/product_service.dart';
import 'package:event_with_thong/services/product_variant_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';

class ProductVariantProvider extends ChangeNotifier {
  ProductVariantService service = ProductVariantService.instance;
  final ProductService productService = ProductService.instance;

  List<ProductVariantModel> productVarient = [];
  List<OptionTypeModel> optionType = [];
  int _totalQuantity = 0;

  Future<void> load() async {
    try {
      await service.load();
    } catch (e) {
      Logger().d("ProductVariant fail: $e ");
    }
  }

  List<ProductVariantModel> get variants => service.getAllVariant();

  
  ProductVariantModel? getVariantByid(String variantId) {
    return service.getVariantById(variantId);
  }

  ProductModel? getProductById(ProductVariantModel variant) {
    return productService.getProductById(variant.productId);
  }

  List<ProductVariantModel> getVariantsByProductId(String productId) {
    productVarient = service.getAllVariantByProductId(productId);
    Logger().d(productVarient);
    notifyListeners();
    return productVarient;
  }

  List<OptionTypeModel> getOptionTypeForEachVariant() {
    optionType = service.getVariantsOptionType(productVarient);
    notifyListeners();
    return optionType;
  }

  OptionTypeModel getOptionTypeById(String id) {
    return optionType.firstWhere(
      (optionType) => optionType.id == id,
    );
  }

  int getStockQuantityByVariantId(String variantId) {
    return service.stockService.getStockByVariantId(variantId)?.quantity ?? 0;
  }

  int getAllStockQuantityByProductId(String productId) {
    _totalQuantity = 0;
    for (ProductVariantModel variant in productVarient) {
      _totalQuantity += getStockQuantityByVariantId(variant.id);
    }
    return _totalQuantity;
  }

  List<StockModel> getAllStockByProduct(String productId) {
    List<StockModel> stockList = [];
    getVariantsByProductId(productId);
    for (ProductVariantModel variant in productVarient) {
      service.stockService.getStockByVariantId(variant.id) != null
          ? stockList.add(service.stockService.getStockByVariantId(variant.id)!)
          : null;
    }
    return stockList;
  }

  StockModel? getStockByVariantId(String variantId) {
    return service.stockService.getStockByVariantId(variantId);
  }
}
