import 'package:event_with_thong/database/taxonomies_database.dart';
import 'package:event_with_thong/models/option_type.dart';
import 'package:event_with_thong/models/product_variant.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:event_with_thong/services/option_type_service.dart';
import 'package:event_with_thong/services/product_service.dart';
import 'package:event_with_thong/services/stock_service.dart';
import 'package:logger/web.dart';

class ProductVariantService extends BaseService {
  ProductVariantService._privateInstance();
  static final ProductVariantService _instance =
      ProductVariantService._privateInstance();
  static ProductVariantService get instance => _instance;

  OptiontypeService optionTypeService = OptiontypeService.instance;
  StockService stockService = StockService.instance;
  ProductVariantDatabase productVariantData = ProductVariantDatabase.instance;
  ProductService productService = ProductService.instance;

  Future<void> load() async {
    try {
      if (await checkBox('productVariant')) {
        final myBox = await getBox<ProductVariantModel>('productVariant');
        productVariantData.productVariant = myBox.values.toList();
        // await myBox.clear();
        // await myBox.deleteFromDisk();
        // await myBox.close();
        await optionTypeService.load();
        await stockService.loadStock();
        // Logger().d("ProductVariant loaded successfully ${myBox.values.length}");
      } else {
        final myBox = await getBox<ProductVariantModel>('productVariant');
        await myBox.putAll(productVariantData.productVariant.asMap());
        await optionTypeService.load();
        await stockService.loadStock();
      }
    } catch (e) {
      Logger().d("Failed to load productVariant: $e");
    }
  }

  List<ProductVariantModel> getAllVariant() {
    try {
      return productVariantData.productVariant;
    } catch (e) {
      Logger().d("Failed to getAll productVariants: $e");
      return [];
    }
  }

  List<ProductVariantModel> getAllVariantByProductId(String productId) {
    return productVariantData.productVariant
        .where(
          (variant) => variant.productId == productId,
        )
        .toList();
  }

  List<ProductVariantModel> getAllNoStockVariant() {
    return productVariantData.productVariant
        .where(
          (variant) => variant.stockId == '',
        )
        .toList();
  }


  ProductVariantModel? getVariantById(String variantId) {
    try {
      return productVariantData.productVariant
          .firstWhere((variant) => variant.id == variantId);
    } catch (e) {
      Logger().d("Failed to get product variant by id: $e");
      return null;
    }
  }

  List<OptionTypeModel> getVariantsOptionType(
      List<ProductVariantModel> variants) {
    List<OptionTypeModel> temp = [];
    for (ProductVariantModel variant in variants) {
      temp.addAll(variant.optionTypesId.map((optionId) => optionTypeService
          .optionTypeData.options
          .firstWhere((optionTypeModel) => optionTypeModel.id == optionId)));
    }
    return temp.toSet().toList();
  }
}
