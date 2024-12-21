import 'package:event_with_thong/models/order.dart';
import 'package:event_with_thong/view/operator/operator_order_detail.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/viewModels/order_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperatorOrderView extends StatefulWidget {
  const OperatorOrderView({super.key});

  @override
  State<OperatorOrderView> createState() => _OperatorOrderViewState();
}

class _OperatorOrderViewState extends State<OperatorOrderView> {
  late List<OrderModel> orders;

  @override
  void initState() {
    super.initState(); 
  }

  Future<void> onEdit(OrderModel order) async {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return OperatorOrderDetail(order: order);
      },
    ));
  }

  Future<void> onCreate() async {}
  Future<void> load() async {
    orders = await context.read<OrderProvider>().getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      title: 'Order',
      bottom: const SizedBox.shrink(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: FutureBuilder(
            future: load(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => onEdit(orders[index]),
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                            bottom: 20, left: 20, right: 20),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.white)),
                        width: MediaQuery.of(context).size.width - 40,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 160,
                              child: Text(
                                '${index + 1}. ${orders[index].orderNumber}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            Text(
                              'UserId: ${orders[index].userId}',
                              style: const TextStyle(color: Colors.white),
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
            },
          ),
        ),
      ),
    );
  }
}
