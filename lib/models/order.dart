import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/models/payment.dart';
import 'package:hive/hive.dart';
part 'order.g.dart';

@HiveType(typeId: 12)
class OrderModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String orderNumber;
  @HiveField(2)
  final double totalPrice;
  @HiveField(3)
  final bool status;
  @HiveField(4)
  final String userId;
  @HiveField(5)
  final PaymentModel payment;
  @HiveField(6)
  final List<LineItemModel> lineitems;
  @HiveField(7)
  final DateTime dateTime;

  OrderModel(
      {required this.id,
      required this.orderNumber,
      required this.userId,
      required this.totalPrice,
      required this.status,
      required this.payment,
      required this.dateTime,
      List<LineItemModel>? lineitems})
      : lineitems = lineitems ?? [];

  PaymentModel get orderPayment => payment;
}
