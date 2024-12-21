import 'package:hive/hive.dart';
part 'taxon.g.dart';

@HiveType(typeId: 5)
class TaxonModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String slug;
  @HiveField(3)
  final String description;
  @HiveField(4)
  final String vendorId;
  @HiveField(5)
  final String image;


  TaxonModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.vendorId,
    required this.image,
  });
}
