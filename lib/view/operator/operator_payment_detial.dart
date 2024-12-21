import 'package:event_with_thong/models/payment.dart';
import 'package:event_with_thong/models/payment_type.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:flutter/material.dart';

class OperatorPaymentDetial extends StatefulWidget {
  final PaymentModel payment;

  const OperatorPaymentDetial({
    super.key,
    required this.payment,
  });

  @override
  State<OperatorPaymentDetial> createState() => _OperatorPaymentDetialState();
}

class _OperatorPaymentDetialState extends State<OperatorPaymentDetial> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
        bottom: const SizedBox.shrink(),
        title: 'Payment Detail',
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 30),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: 40,
                        child: const Center(
                          child: Text(
                            'Payment Detail',
                            style:
                                TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildPaymentData(
                          title: 'Payment Id', desc: widget.payment.id),
                      const SizedBox(height: 15),
                      buildPaymentData(
                          title: 'Orders:', desc: widget.payment.orderId),
                      const SizedBox(height: 15),
                      buildPaymentData(
                          title: 'Payment type:',
                          desc: widget.payment.paymentType.label),
                      const SizedBox(height: 15),
                      buildPaymentData(
                          title: 'Status:',
                          desc: widget.payment.status ? 'Sucess' : 'Fail'),
                      const SizedBox(height: 15),
                      buildPaymentData(
                          title: 'Amount:',
                          desc: '\$${widget.payment.amount.toString()}'),
                      const SizedBox(height: 15),
                      buildPaymentData(
                          title: 'User:', desc: widget.payment.userId),
                      const SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget buildPaymentData({required String title, required String desc}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 200,
            child: Text(
              desc,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
