import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/services/base_service.dart';
import 'package:logger/web.dart';

class CartService extends BaseService {
  CartService._privateInstance();
  static final _instance = CartService._privateInstance();
  static CartService get instance => _instance;

  List<LineItemModel> cart = [];

  Future<bool> removeLineItemFromCart(LineItemModel lineitem) async {
    try {
      await loadCart();
      int index = cart.indexWhere((cartLineItem) => cartLineItem == lineitem);
      final cartBox = await getBox<LineItemModel>('cart');
      await cartBox.deleteAt(index);
      Logger().d('mengthong');
      await loadCart();
      return true;
    } catch (e) {
      Logger().d('remove from cart');
      return false;
    }
  }

  Future<void> loadCart() async {
    try {
      if (await checkBox('cart')) {
        final cartBox = await getBox<LineItemModel>('cart');
        cart = cartBox.values.toList();
        Logger().d('Loading cart from hive');
      } else {
        final cartBox = await getBox<LineItemModel>('cart');
        await cartBox.putAll(cart.asMap());
        Logger().d('Using New cart');
      }
    } catch (e) {
      Logger().d('Loading cart from local $e');
    }
  }

  Future<bool> addLineItemToCart(LineItemModel lineitem) async {
    try {
      cart.add(lineitem);
      Logger().d(cart.length);
      Logger().d(lineitem);
      final cartBox = await getBox<LineItemModel>('cart');
      await cartBox.putAll(cart.asMap());
      await loadCart();
      return true;
    } catch (e) {
      Logger().d('error adding to cart $e');
      return false;
    }
  }

  Future<void> cleanCart() async {
    try {
      cart = [];
      final cartBox = await getBox<LineItemModel>('cart');
      await cartBox.clear();
      await loadCart();
      Logger().d('clean cart');
    } catch (e) {
      Logger().d('error cleaning cart');
    }
  }

  double totalSummary() {
    return cart.fold(
        0.0, (previousValue, lineitem) => previousValue + lineitem.subTotalPrice);
  }
}
