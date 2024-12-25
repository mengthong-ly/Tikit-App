import 'package:event_with_thong/models/taxon_type.dart';
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
  @HiveField(6)
  bool isFeatured;
  @HiveField(7)
  final TaxonType taxonType;

  TaxonModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.vendorId,
    required this.image,
    this.isFeatured = false,
    required this.taxonType,
  });
}
