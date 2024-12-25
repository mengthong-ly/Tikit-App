import 'package:event_with_thong/database/database.dart';
import 'package:event_with_thong/models/order.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:event_with_thong/services/cart_service.dart';
import 'package:event_with_thong/services/payment_service.dart';
import 'package:logger/web.dart';

class OrderService extends BaseService {
  OrderService._instanceService();
  static final OrderService _instance = OrderService._instanceService();
  static OrderService get instance => _instance;

  OrderDatabase orderData = OrderDatabase.instance;
  CartService service = CartService.instance;
  PaymentService paymentService = PaymentService.instance;

  Future<void> laodOrder() async {
    try {
      if (await checkBox('order')) {
        final myBox = await getBox<OrderModel>('order');
        orderData.orders = myBox.values.toList();
        Logger().d('loading: order ${orderData.orders.length}');
      } else {
        final myBox = await getBox<OrderModel>('order');
        await myBox.putAll(orderData.orders.asMap());
      }
    } catch (e) {
      Logger().d('Error: $e');
    }
  }

  Future<void> addOrder(OrderModel order) async {
    try {
      if (await checkBox('order')) {
        orderData.orders.add(order);
        final myBox = await getBox<OrderModel>('order');
        await myBox.putAll(orderData.orders.asMap());
        await service.cleanCart();
        await laodOrder();
        Logger().d('order count: ${orderData.orders.length}');
        Logger().d('saving order success');
      } else {
        Logger().d('saving order fail');
      }
    } catch (e) {
      Logger().d('Error: $e');
    }
  }
}
