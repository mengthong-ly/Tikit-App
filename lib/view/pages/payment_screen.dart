import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/models/payment_type.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/product_variant.dart';
import 'package:event_with_thong/services/cart_service.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/components/payment_option_item.dart';
import 'package:event_with_thong/view/pages/success_screen.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:event_with_thong/viewModels/order_provider.dart';
import 'package:event_with_thong/viewModels/product_variant_provider.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:provider/provider.dart';

class PaymentScreen extends StatefulWidget {
  final List<LineItemModel>? cart;

  const PaymentScreen({
    super.key,
    required this.cart,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<LineItemModel> lineitems = [];
  PaymentTypeModel selectedPaymentOption = PaymentTypeModel.aba;

  ProductModel getProduct(BuildContext context, ProductVariantModel variant) {
    return context.read<ProductVariantProvider>().getProductById(variant)!;
  }

  double sum = 0;
  double get totalSammary => lineitems.fold(
        sum,
        (previousValue, lineItem) => previousValue + lineItem.subTotalPrice,
      );

  @override
  void initState() {
    super.initState();
    loadLineItem();
    Logger().d(lineitems.length);
  }

  void onSelectPaymentOption(PaymentTypeModel paymentType) {
    setState(() {
      selectedPaymentOption = paymentType;
    });
  }

  void loadLineItem() {
    for (LineItemModel lineItem in CartService.instance.cart) {
      lineitems.add(lineItem);
    }
  }

  Future<void> onSubmitPayment() async {
    await context
        .read<OrderProvider>()
        .constructOrder(true, selectedPaymentOption, widget.cart);
     Navigator.pushReplacement(context, MaterialPageRoute(
      builder: (context) {
        return const SuccessScreen();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
        child: TElevatedButton(label: 'Pay Now', onPress: onSubmitPayment),
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: context.read<ThemeProvider>().isDarkMode ? Colors.white : Colors.black
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  PaymentOptionItem(
                    callback: onSelectPaymentOption,
                    title: PaymentTypeModel.aba.label,
                    value: PaymentTypeModel.aba,
                    groupValue: selectedPaymentOption,
                  ),
                  PaymentOptionItem(
                    callback: onSelectPaymentOption,
                    title: PaymentTypeModel.applepay.label,
                    value: PaymentTypeModel.applepay,
                    groupValue: selectedPaymentOption,
                  ),
                  PaymentOptionItem(
                    callback: onSelectPaymentOption,
                    title: PaymentTypeModel.acleda.label,
                    value: PaymentTypeModel.acleda,
                    groupValue: selectedPaymentOption,
                  ),
                  PaymentOptionItem(
                    callback: onSelectPaymentOption,
                    title: PaymentTypeModel.creditcard.label,
                    value: PaymentTypeModel.creditcard,
                    groupValue: selectedPaymentOption,
                  ),
                  PaymentOptionItem(
                    callback: onSelectPaymentOption,
                    title: PaymentTypeModel.khqr.label,
                    value: PaymentTypeModel.khqr,
                    groupValue: selectedPaymentOption,
                  ),
                  PaymentOptionItem(
                    callback: onSelectPaymentOption,
                    title: PaymentTypeModel.paypal.label,
                    value: PaymentTypeModel.paypal,
                    groupValue: selectedPaymentOption,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Payment Summary',
                    style: TTextTheme.lightTextTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buildPaymentSummary(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildPaymentSummary(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      // height: 400,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(27, 0, 0, 0),
              spreadRadius: 2,
              blurRadius: 15,
            )
          ]),
      child: Column(
        children: [
          buildPaymentSammaryTitle(),
          const SizedBox(
            height: 20,
          ),
          ...lineitems.map((lineItem) => buildSammaryData(
                getProduct(context, lineItem.productVariant),
                lineItem.quantity,
              )),
          buildDivider(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 100,
                  child: Text(
                    ' Total',
                    style: TTextTheme.lightTextTheme.headlineSmall,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                    width: 90,
                    child: Text(
                      "\$${totalSammary.toStringAsFixed(2)}",
                      style: TTextTheme.lightTextTheme.titleLarge,
                      textAlign: TextAlign.right,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding buildDivider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Divider(),
    );
  }

  Widget buildSammaryData(
    ProductModel product,
    int quantity,
  ) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              product.name,
              textAlign: TextAlign.left,
              style: TTextTheme.lightTextTheme.bodyLarge,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          SizedBox(
            width: 70,
            child: Text(
              quantity.toString(),
              textAlign: TextAlign.center,
              style: TTextTheme.lightTextTheme.bodyLarge,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 90,
            child: Text(
              // price,
              "\$${product.price.toStringAsFixed(2)}",
              // '12',
              textAlign: TextAlign.right,
              style: TTextTheme.lightTextTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPaymentSammaryTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              'Item',
              textAlign: TextAlign.left,
              style: TTextTheme.lightTextTheme.bodyLarge,
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          SizedBox(
            width: 70,
            child: Text(
              'Quantity',
              textAlign: TextAlign.center,
              style: TTextTheme.lightTextTheme.bodyLarge,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          SizedBox(
            width: 90,
            child: Text(
              'Total',
              textAlign: TextAlign.right,
              style: TTextTheme.lightTextTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
