// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'taxon_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaxonTypeAdapter extends TypeAdapter<TaxonType> {
  @override
  final int typeId = 15;

  @override
  TaxonType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return TaxonType.sport;
      case 1:
        return TaxonType.education;
      case 2:
        return TaxonType.nationalEvent;
      case 3:
        return TaxonType.conference;
      case 4:
        return TaxonType.workshop;
      case 5:
        return TaxonType.exhibition;
      case 6:
        return TaxonType.book;
      case 7:
        return TaxonType.podcast;
      case 8:
        return TaxonType.concert;
      case 9:
        return TaxonType.fun;
      case 10:
        return TaxonType.game;
      case 11:
        return TaxonType.other;
      case 12:
        return TaxonType.charity;
      default:
        return TaxonType.sport;
    }
  }

  @override
  void write(BinaryWriter writer, TaxonType obj) {
    switch (obj) {
      case TaxonType.sport:
        writer.writeByte(0);
        break;
      case TaxonType.education:
        writer.writeByte(1);
        break;
      case TaxonType.nationalEvent:
        writer.writeByte(2);
        break;
      case TaxonType.conference:
        writer.writeByte(3);
        break;
      case TaxonType.workshop:
        writer.writeByte(4);
        break;
      case TaxonType.exhibition:
        writer.writeByte(5);
        break;
      case TaxonType.book:
        writer.writeByte(6);
        break;
      case TaxonType.podcast:
        writer.writeByte(7);
        break;
      case TaxonType.concert:
        writer.writeByte(8);
        break;
      case TaxonType.fun:
        writer.writeByte(9);
        break;
      case TaxonType.game:
        writer.writeByte(10);
        break;
      case TaxonType.other:
        writer.writeByte(11);
        break;
      case TaxonType.charity:
        writer.writeByte(12);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaxonTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
