// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'line_item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LineItemModelAdapter extends TypeAdapter<LineItemModel> {
  @override
  final int typeId = 11;

  @override
  LineItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LineItemModel(
      id: fields[0] as String,
      orderId: fields[1] as String?,
      quantity: fields[2] as int,
      price: fields[3] as double,
      subTotalPrice: fields[4] as double,
      productVariant: fields[5] as ProductVariantModel,
    );
  }

  @override
  void write(BinaryWriter writer, LineItemModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.orderId)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.price)
      ..writeByte(4)
      ..write(obj.subTotalPrice)
      ..writeByte(5)
      ..write(obj.productVariant);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LineItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
