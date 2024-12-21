import 'package:hive/hive.dart';

part 'user_role_model.g.dart'; // For Hive code generation.

@HiveType(typeId: 1)
enum UserRoleModel {
  @HiveField(0)
  user,

  @HiveField(1)
  admin,

  @HiveField(2)
  vendor,
}

extension UserRoleModelExtension on UserRoleModel {
  String get title {
    switch (this) {
      case UserRoleModel.user:
        return 'User';
      case UserRoleModel.admin:
        return 'Admin';
      case UserRoleModel.vendor:
        return 'Vendor';
    }
  }
}
