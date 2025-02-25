// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OptionTypeModelAdapter extends TypeAdapter<OptionTypeModel> {
  @override
  final int typeId = 8;

  @override
  OptionTypeModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OptionTypeModel(
      id: fields[0] as String,
      type: fields[1] as String,
      description: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OptionTypeModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.description);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
