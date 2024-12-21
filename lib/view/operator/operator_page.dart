import 'package:event_with_thong/view/components/event_sliver_app_bar.dart';
import 'package:event_with_thong/view/operator/operator_event_view.dart';
import 'package:event_with_thong/view/operator/operator_option_button.dart';
import 'package:event_with_thong/view/operator/operator_order_view.dart';
import 'package:event_with_thong/view/operator/operator_payment.dart';
import 'package:event_with_thong/view/operator/operator_product_view.dart';
import 'package:event_with_thong/view/operator/operator_stock_view.dart';
import 'package:event_with_thong/view/operator/operator_user_view.dart';
import 'package:event_with_thong/view/operator/operator_vendor_view.dart';
import 'package:flutter/material.dart';

enum OperatorViewState {
  menu,
  event,
  product,
  stock,
  order,
  user,
  payment,
  vendor;
}

class OperatorPage extends StatefulWidget {
  const OperatorPage({super.key});

  @override
  State<OperatorPage> createState() => _OperatorPageState();
}

class _OperatorPageState extends State<OperatorPage> {
  @override
  void initState() {
    super.initState();
    setState(() {
      currentViewState = OperatorViewState.menu;
    });
  }

  bool isCollapsed = false;
  void onCollapsed(bool value) {
    if (isCollapsed == value) return;
    setState(() => isCollapsed = value);
  }

  late OperatorViewState currentViewState;

  void onViewEvent() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const OperatorEventView();
      },
    ));
  }

  void onViewProduct() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const OperatorProductView();
      },
    ));
  }

  void onViewStock() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const OperatorStockView();
      },
    ));
  }

  void onViewOrder() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const OperatorOrderView();
      },
    ));
  }

  void onViewPayment() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const OperatorPayment();
      },
    ));
  }

  void onViewVendor() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const OperatorVendorView();
      },
    ));
  }

  void onViewUser() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return const OperatorUserView();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        body: Stack(children: [
          Positioned(
            top: -200,
            right: -200,
            child: Opacity(
              opacity: 0.45,
              child: Container(
                width: 600,
                height: 600,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    radius: 1,
                    tileMode: TileMode.clamp,
                    colors: [
                      Color(0xff4338CA),
                      Color.fromARGB(255, 0, 0, 0),
                      Color(0xff4338CA),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -200,
            left: -200,
            child: Opacity(
              opacity: 0.75,
              child: Container(
                width: 600,
                height: 600,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    radius: 1,
                    tileMode: TileMode.clamp,
                    colors: [
                      Color(0xff4338CA),
                      Color.fromARGB(255, 0, 0, 0),
                      Color(0xff4338CA),
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomScrollView(
            slivers: [
              EventSliverAppBar(
                isCollapsed: isCollapsed,
                onCollapsed: onCollapsed,
                welcomeText: 'Welcome\nOperator',
                isOperator: true,
              ),
              SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(
                              height: 40,
                            ),
                            OperatorOptionButton(
                              title: 'Event',
                              state: OperatorViewState.event,
                              onView: onViewEvent,
                            ),
                            OperatorOptionButton(
                              title: 'Product',
                              state: OperatorViewState.product,
                              onView: onViewProduct,
                            ),
                            OperatorOptionButton(
                              title: 'Stock',
                              state: OperatorViewState.stock,
                              onView: onViewStock,
                            ),
                            OperatorOptionButton(
                              title: 'Users Order',
                              state: OperatorViewState.order,
                              onView: onViewOrder,
                            ),
                            OperatorOptionButton(
                              title: 'Users',
                              state: OperatorViewState.user,
                              onView: onViewUser,
                            ),
                            OperatorOptionButton(
                              title: 'Payment',
                              state: OperatorViewState.payment,
                              onView: onViewPayment,
                            ),
                            OperatorOptionButton(
                              title: 'Vendor',
                              state: OperatorViewState.vendor,
                              onView: onViewVendor,
                            )
                          ]))),
            ],
          )
        ]));
  }
}
