import 'package:hive/hive.dart';

part 'stock.g.dart';

@HiveType(typeId: 9)
class StockModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String variantId;
  @HiveField(2)
  final String stockLocation;
  @HiveField(3)
  int quantity;
  @HiveField(4)
  int limitStock;

  StockModel({
    required this.id,
    required this.stockLocation,
    required this.quantity,
    required this.variantId,
    required this.limitStock,
  });

  void increaseStock(int quantityToIncrease) {
    (quantityToIncrease > 0 && quantityToIncrease <= limitStock)
        ? quantity += quantityToIncrease
        : quantity += 0;
  }

  void decreaseStock(int quantityToDecrease) {
    (quantityToDecrease > 0 && quantityToDecrease <= quantity)
        ? quantity -= quantityToDecrease
        : quantity -= 0;
  }
}
