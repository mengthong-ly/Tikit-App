import 'package:event_with_thong/models/payment_type.dart';
import 'package:hive/hive.dart';
part 'payment.g.dart';
@HiveType(typeId: 13)
class PaymentModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userId;
  @HiveField(2)
  final PaymentTypeModel paymentType;
  @HiveField(3)
  final String orderId;
  @HiveField(4)
  final bool status;
  @HiveField(5)
  double amount;

  PaymentModel({
    required this.id,
    required this.orderId,
    required this.paymentType,
    required this.userId,
    required this.amount,
    this.status = false,
  });

  // nv ng chea private method

  // double _calculateAmount() {
  //   double temp = 0;
  //   for (var lineItem in paymentOrder.lineitems) {
  //     temp += lineItem.quantity * lineItem.price;
  //   }
  //   return temp;
  // }
}
