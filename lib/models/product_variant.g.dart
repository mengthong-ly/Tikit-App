// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_variant.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductVariantModelAdapter extends TypeAdapter<ProductVariantModel> {
  @override
  final int typeId = 10;

  @override
  ProductVariantModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductVariantModel(
      id: fields[0] as String,
      productId: fields[1] as String,
      optionTypesId: (fields[3] as List).cast<String>(),
      stockId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductVariantModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.productId)
      ..writeByte(2)
      ..write(obj.stockId)
      ..writeByte(3)
      ..write(obj.optionTypesId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductVariantModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
