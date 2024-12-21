
import 'package:hive/hive.dart';
part 'vendor.g.dart';
@HiveType(typeId: 6)
class VendorModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String email;
  @HiveField(3)
  final String contact;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final String profile;

  VendorModel({
    required this.id,
    required this.name,
    required this.email,
    required this.contact,
    required this.address,
    required this.profile,
  });
}
