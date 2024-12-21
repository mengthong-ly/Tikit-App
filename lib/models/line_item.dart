import 'package:event_with_thong/models/product_variant.dart';
import 'package:hive/hive.dart';
part 'line_item.g.dart';

@HiveType(typeId: 11)
class LineItemModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? orderId;
  @HiveField(2)
  final int quantity;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final double subTotalPrice;
  @HiveField(5)
  final ProductVariantModel productVariant;

  LineItemModel({
    required this.id,
    required this.orderId,
    required this.quantity,
    required this.price,
    required this.subTotalPrice,
    required this.productVariant,
  }) ;
}
