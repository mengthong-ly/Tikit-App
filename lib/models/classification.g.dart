// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classification.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductTaxonModelAdapter extends TypeAdapter<ProductTaxonModel> {
  @override
  final int typeId = 7;

  @override
  ProductTaxonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductTaxonModel(
      id: fields[0] as String,
      taxonId: fields[1] as String,
      productId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ProductTaxonModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.taxonId)
      ..writeByte(2)
      ..write(obj.productId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductTaxonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
