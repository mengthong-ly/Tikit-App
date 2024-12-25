import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/models/order.dart';
import 'package:event_with_thong/models/payment.dart';
import 'package:event_with_thong/models/payment_type.dart';
import 'package:event_with_thong/services/cart_service.dart';
import 'package:event_with_thong/services/order_service.dart';
import 'package:event_with_thong/services/payment_service.dart';
import 'package:event_with_thong/viewModels/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class OrderProvider extends ChangeNotifier {
  static Uuid uuid = const Uuid();
  final CartService cartService = CartService.instance;
  final OrderService orderService = OrderService.instance;
  final AuthenticationProvider auth = AuthenticationProvider();
  final PaymentService paymentService = PaymentService.instance;

  void loadOrder() async {
    await orderService.laodOrder();
  }

  Future<List<OrderModel>> getAllOrders() async {
    await orderService.laodOrder();
    await auth.loadCurrentUser();
    return orderService.orderData.orders
        .where(
          (order) => order.userId == auth.currentUser!.id,
        )
        .toList();
  }

  Future<void> constructOrder(bool paymentStatus, PaymentTypeModel paymentType,
      List<LineItemModel>? cart) async {
    String paymentId = uuid.v1();
    String orderId = uuid.v1();
    await auth.loadCurrentUser();
    final PaymentModel payment = PaymentModel(
        id: paymentId,
        orderId: orderId,
        paymentType: paymentType,
        status: paymentStatus,
        userId: auth.currentUser!.id,
        amount: cartService.totalSummary());

    final OrderModel order = OrderModel(
        id: orderId,
        orderNumber: 'R$orderId',
        userId: auth.currentUser!.id,
        totalPrice: cartService.totalSummary(),
        status: paymentStatus,
        lineitems: cart,
        payment: payment,
        dateTime: DateTime.now());
    print('--------------------------------------------------------');
    print(cartService.totalSummary());
    print('--------------------------------------------------------');
    await orderService.laodOrder();
    await paymentService.loadAllPayment();

    await paymentService.addPayment(payment);
    await orderService.addOrder(order);
  }
}
