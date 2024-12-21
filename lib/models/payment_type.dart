import 'package:hive/hive.dart';

part 'payment_type.g.dart'; // For Hive code generation.

@HiveType(typeId: 14) // Assign a unique typeId for this enum.
enum PaymentTypeModel {
  @HiveField(0)
  creditcard,

  @HiveField(1)
  paypal,

  @HiveField(2)
  aba,

  @HiveField(3)
  khqr,

  @HiveField(4)
  applepay,

  @HiveField(5)
  acleda,
}

extension PaymentTypeModelExtension on PaymentTypeModel {
  String get label {
    switch (this) {
      case PaymentTypeModel.creditcard:
        return 'Credit Card';
      case PaymentTypeModel.paypal:
        return 'PayPal';
      case PaymentTypeModel.aba:
        return 'ABA';
      case PaymentTypeModel.khqr:
        return 'KHQR';
      case PaymentTypeModel.applepay:
        return 'Apple Pay';
      case PaymentTypeModel.acleda:
        return 'ACLEDA';
    }
  }

  String get id {
    switch (this) {
      case PaymentTypeModel.creditcard:
        return '1';
      case PaymentTypeModel.paypal:
        return '2';
      case PaymentTypeModel.aba:
        return '3';
      case PaymentTypeModel.khqr:
        return '4';
      case PaymentTypeModel.applepay:
        return '5';
      case PaymentTypeModel.acleda:
        return '6';
    }
  }
  String get image {
    switch (this) {
      case PaymentTypeModel.creditcard:
        return 'assets/logo/visa_logo.png';
      case PaymentTypeModel.paypal:
        return 'assets/logo/paypal_logo.png';
      case PaymentTypeModel.aba:
        return 'assets/logo/aba_logo.jpg';
      case PaymentTypeModel.khqr:
        return 'assets/logo/khqr_logo.png';
      case PaymentTypeModel.applepay:
        return 'assets/logo/Apple_logo_black.svg.png';
      case PaymentTypeModel.acleda:
        return 'assets/logo/acleda_logo.png';
    }
  }
}
