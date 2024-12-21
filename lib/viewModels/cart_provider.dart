import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/product_variant.dart';
import 'package:event_with_thong/services/cart_service.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:logger/web.dart';
import 'package:uuid/uuid.dart';

class CartProvider extends ChangeNotifier {
  static Uuid uuid = const Uuid();
  final CartService service = CartService.instance;

  // List<LineItemModel> cart = [];

  Future<List<LineItemModel>> loadCart() async {
    await service.loadCart();
    // cart = service.cart;
    notifyListeners();
    return service.cart;
    // return cart;
  }

  Future<List<LineItemModel>> constructLineItem(
      ProductVariantModel variant, int quantity, ProductModel product) async {
    LineItemModel lineItem = LineItemModel(
        id: uuid.v1(),
        orderId: uuid.v4(),
        productVariant: variant,
        quantity: quantity,
        price: product.price,
        subTotalPrice: product.price * quantity);
    await addProductToCart(lineItem);
    Logger().d('''
        Constructing line item done
      ''');
    notifyListeners();
    return service.cart;
  }

  Future<void> addProductToCart(LineItemModel lineitem) async {
    await service.addLineItemToCart(lineitem);
    Logger().d('''
        addLineItem
      ''');
    for (LineItemModel lineitem in service.cart) {
      Logger().d('''
        Constructing line item:
        id: ${lineitem.id},
        orderId: ${lineitem.orderId},
        quantity: ${lineitem.quantity},
        price: ${lineitem.price},
        subtotalPrice: ${lineitem.subTotalPrice}
      ''');
    }
    notifyListeners();
  }

  Future<void> removeProductFromCart(LineItemModel lineItem) async {
    service.cart.remove(lineItem);
    await service.removeLineItemFromCart(lineItem);
    notifyListeners();
  }
}
