import 'package:hive/hive.dart';

part 'product_variant.g.dart';

@HiveType(typeId: 10)
class ProductVariantModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String productId;
  @HiveField(2)
  final String stockId;
  @HiveField(3)
  final List<String> optionTypesId;
  ProductVariantModel({
    required this.id,
    required this.productId,
    required this.optionTypesId,
    required this.stockId,
  });
}
