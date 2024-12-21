// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PaymentTypeModelAdapter extends TypeAdapter<PaymentTypeModel> {
  @override
  final int typeId = 14;

  @override
  PaymentTypeModel read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return PaymentTypeModel.creditcard;
      case 1:
        return PaymentTypeModel.paypal;
      case 2:
        return PaymentTypeModel.aba;
      case 3:
        return PaymentTypeModel.khqr;
      case 4:
        return PaymentTypeModel.applepay;
      case 5:
        return PaymentTypeModel.acleda;
      default:
        return PaymentTypeModel.creditcard;
    }
  }

  @override
  void write(BinaryWriter writer, PaymentTypeModel obj) {
    switch (obj) {
      case PaymentTypeModel.creditcard:
        writer.writeByte(0);
        break;
      case PaymentTypeModel.paypal:
        writer.writeByte(1);
        break;
      case PaymentTypeModel.aba:
        writer.writeByte(2);
        break;
      case PaymentTypeModel.khqr:
        writer.writeByte(3);
        break;
      case PaymentTypeModel.applepay:
        writer.writeByte(4);
        break;
      case PaymentTypeModel.acleda:
        writer.writeByte(5);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaymentTypeModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
