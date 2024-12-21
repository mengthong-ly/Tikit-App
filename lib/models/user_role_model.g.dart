// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserRoleModelAdapter extends TypeAdapter<UserRoleModel> {
  @override
  final int typeId = 1;

  @override
  UserRoleModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return UserRoleModel.user;
      case 1:
        return UserRoleModel.admin;
      case 2:
        return UserRoleModel.vendor;
      default:
        return UserRoleModel.user;
    }
  }

  @override
  void write(BinaryWriter writer, UserRoleModel obj) {
    switch (obj) {
      case UserRoleModel.user:
        writer.writeByte(0);
        break;
      case UserRoleModel.admin:
        writer.writeByte(1);
        break;
      case UserRoleModel.vendor:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRoleModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
