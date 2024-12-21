import 'package:event_with_thong/models/payment.dart';
import 'package:event_with_thong/view/operator/operator_payment_detial.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/viewModels/payment_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class OperatorPayment extends StatefulWidget {
  const OperatorPayment({super.key});

  @override
  State<OperatorPayment> createState() => _OperatorPaymentState();
}

class _OperatorPaymentState extends State<OperatorPayment> {
  late List<PaymentModel> payments;

  @override
  void initState() {
    super.initState();
  }

  Future<void> load() async {
    await context.read<PaymentProvider>().load();
    payments = context.read<PaymentProvider>().getAllPayment();
  }

  void onView(PaymentModel payment) async {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return OperatorPaymentDetial(
          payment: payment,
        );
      },
    ));
  }

  void onRemove(PaymentModel payment) async {}

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      bottom: const SizedBox.shrink(),
      title: 'Payment',
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: FutureBuilder(
                future: load(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: payments.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => onView(payments[index]),
                          child: Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                                bottom: 20, left: 20, right: 20),
                            padding: const EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.white)),
                            width: MediaQuery.of(context).size.width - 40,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${index + 1}. ${payments[index].id}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                IconButton(
                                  onPressed: () => onRemove(payments[index]),
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          )),
    );
  }
}
