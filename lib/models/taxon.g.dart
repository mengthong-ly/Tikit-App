// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxon.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaxonModelAdapter extends TypeAdapter<TaxonModel> {
  @override
  final int typeId = 5;

  @override
  TaxonModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaxonModel(
      id: fields[0] as String,
      name: fields[1] as String,
      slug: fields[2] as String,
      description: fields[3] as String,
      vendorId: fields[4] as String,
      image: fields[5] as String,
      isFeatured: fields[6] as bool,
      taxonType: fields[7] as TaxonType,
    );
  }

  @override
  void write(BinaryWriter writer, TaxonModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.slug)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.vendorId)
      ..writeByte(5)
      ..write(obj.image)
      ..writeByte(6)
      ..write(obj.isFeatured)
      ..writeByte(7)
      ..write(obj.taxonType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaxonModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
