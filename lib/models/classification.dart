import 'package:hive/hive.dart';
part 'classification.g.dart';

@HiveType(typeId: 7)
class ProductTaxonModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String taxonId;
  @HiveField(2)
  final String productId;

  ProductTaxonModel({
    required this.id,
    required this.taxonId,
    required this.productId,
  });
}

