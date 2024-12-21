import 'package:event_with_thong/models/gender.dart';
import 'package:hive/hive.dart';
import 'user_role_model.dart';

part 'user.g.dart';

@HiveType(typeId: 0) // Unique typeId
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final UserRoleModel role;
  @HiveField(3)
  final String email;
  @HiveField(4)
  final String? address;
  @HiveField(5)
  final String? phoneNumber;
  @HiveField(6)
  final String password;
  @HiveField(7)
  final Gender? gender;
  @HiveField(8)
  final String? createdAt;
  @HiveField(9)
  final String? firstName;
  @HiveField(10)
  final String? lastName;

  // Constructor
  UserModel({
    required this.id,
    required this.email,
    required this.password,
    this.role = UserRoleModel.user,
    this.firstName,
    this.lastName,
    this.name,
    this.gender,
    this.address,
    this.phoneNumber,
  }) : createdAt = DateTime.now().toString();
}
