import 'package:hive/hive.dart';
part 'product.g.dart';

@HiveType(typeId: 2)
class ProductModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double price;
  @HiveField(4)
  final String location;
  @HiveField(5)
  final DateTime eventDate;
  @HiveField(6)
  bool isPromoted;
  @HiveField(7)
  double discountPercentage;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.location,
    required this.eventDate,
    this.isPromoted = false,
    this.discountPercentage = 0,
  });
}
