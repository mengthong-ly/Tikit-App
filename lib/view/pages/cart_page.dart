import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/view/pages/booking_page.dart';
import 'package:event_with_thong/view/pages/payment_screen.dart';
import 'package:event_with_thong/viewModels/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<LineItemModel> cart = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    laod();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> laod() async {
    final loadedCart = await context.read<CartProvider>().loadCart();
    setState(() {
      cart = loadedCart;
      isLoading = false; // Update loading state
    });
  }

  void onDelete(BuildContext context, int index) async {
    setState(() {
      isLoading == true;
    });
    await context.read<CartProvider>().removeProductFromCart(cart[index]);
    await laod();
  }

  Widget get display => cart.isNotEmpty
      ? SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: cart.length,
            (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Slidable(
                  useTextDirection: true,
                  closeOnScroll: true,
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      // A SlidableAction can have an icon and/or a label.
                      SlidableAction(
                        borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        onPressed: (context) => onDelete(context, index),
                        foregroundColor: const Color(0xFFFE4A49),
                        icon: Icons.delete,
                        label: 'Delete',
                        autoClose: true,
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xff303030),
                    ),
                    width: MediaQuery.of(context).size.width,
                    height: 173,
                    child: CartItem(
                      lineItem: cart[index],
                    ),
                  ),
                ),
              );
            },
          ),
        )
      : const SliverToBoxAdapter(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 350,
              ),
              Text('is Empty'),
            ],
          ),
        );

  @override
  Widget build(BuildContext context) {
    if (isLoading == false) {
      return CustomScrollView(
        physics: cart.isEmpty ? const NeverScrollableScrollPhysics() : null,
        slivers: [
          SliverAppBar(
            centerTitle: false,
            actions: [
              cart.isNotEmpty
                  ? IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return PaymentScreen(
                              cart: cart,
                            );
                          },
                        ));
                      },
                      icon: const Icon(Icons.shopping_cart_checkout_rounded))
                  : const SizedBox.shrink()
            ],
            title: const Text(
              'Shopping Cart',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 22,
              ),
            ),
            elevation: 0,
          ),
          display,
        ],
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
