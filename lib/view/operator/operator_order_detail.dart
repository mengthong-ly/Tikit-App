import 'package:event_with_thong/models/order.dart';
import 'package:event_with_thong/models/payment_type.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/viewModels/product_variant_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class OperatorOrderDetail extends StatelessWidget {
  final OrderModel order;
  const OperatorOrderDetail({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      title: 'Order Details',
      bottom: const SizedBox.shrink(),
      appbar: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Text(
            'Order Number',
            style: TextStyle(
                fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white),
          ),
          Text(
            order.orderNumber,
            style: TextStyle(
                fontSize: 13,
                fontWeight: TTextTheme.lightTextTheme.headlineLarge!.fontWeight,
                color: const Color.fromARGB(127, 255, 255, 255)),
          )
        ],
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Stack(
              children: [
                Positioned(
                  top: 60,
                  left: 0,
                  right: 0,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: MediaQuery.of(context).size.width * 0.9,
                      // height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black, width: 1),
                        color: Colors.white,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 50,
                          ),
                          Align(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  'Payment Total',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(132, 0, 0, 0),
                                  ),
                                ),
                                Text(
                                  ' \$${order.totalPrice}',
                                  style: const TextStyle(
                                    fontSize: 27,
                                    fontWeight: FontWeight.w600,
                                    color: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          buildReciptInfo(label: 'UserId:', data: order.userId),
                          const SizedBox(
                            height: 10,
                          ),
                          buildReciptInfo(
                              label: 'Status:',
                              data: order.status ? 'Success' : 'Failure'),
                          const SizedBox(
                            height: 10,
                          ),
                          buildReciptInfo(
                            label: 'Payment Type:',
                            data: order.payment.paymentType.label,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          buildReciptInfo(
                            label: 'Date:',
                            data:
                                DateFormat('dd/mm/yyyy').format(order.dateTime),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ...List.generate(
                            order.lineitems.length,
                            (index) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: buildReciptInfo(
                                    label: context
                                            .read<ProductVariantProvider>()
                                            .getProductById(order
                                                .lineitems[index].productVariant)
                                            ?.name ??
                                        'not found',
                                    data: 'x${order.lineitems[index].quantity}'),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Positioned(
                    left: 0,
                    right: 0,
                    top: -40,
                    child: Center(
                      child: LottieBuilder.asset(
                        'assets/success-light.json',
                        repeat: false,
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildReciptInfo({required String label, required String data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          // 'UserId:',
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 0, 0, 0),
          ),
        ),
        Text(
          data,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
