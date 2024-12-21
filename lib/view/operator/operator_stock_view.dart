import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/product_variant.dart';
import 'package:event_with_thong/models/stock.dart';
import 'package:event_with_thong/view/operator/operator_event_form.dart';
import 'package:event_with_thong/view/operator/operator_stock_form.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/viewModels/product_provider.dart';
import 'package:event_with_thong/viewModels/product_variant_provider.dart';
import 'package:event_with_thong/viewModels/stock_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperatorStockView extends StatefulWidget {
  const OperatorStockView({super.key});

  @override
  State<OperatorStockView> createState() => _OperatorStockViewState();
}

class _OperatorStockViewState extends State<OperatorStockView> {
  List<StockModel> stocks = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> load() async {
    await context.read<ProductModelProvider>().load();
    await context.read<StockProvider>().loadStock();
    stocks = await context.read<StockProvider>().getStock();
    await context.read<ProductVariantProvider>().load();
  }

  ProductModel? getProductByVariantId(String variantId) {
    final ProductVariantModel? variant =
        context.read<ProductVariantProvider>().getVariantByid(variantId);

    if (variant != null) {
      return context.read<ProductVariantProvider>().getProductById(variant);
    }
    return null;
  }

  Future<void> onEdit(StockModel stock) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OperatorStockForm(
          mode: FormMode.edit,
          stock: stock,
        ),
      ),
    );
    setState(() {});
  }

  Future<void> onTap() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OperatorStockForm(
          mode: FormMode.create,
        ),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      title: 'Stock View',
      bottom: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0xff16A34A),
          ),
          height: 70,
          child: const Text(
            'Create a new Product',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: load(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // print(stocks.length);
              return ListView.builder(
                itemCount: stocks.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => onEdit(stocks[index]),
                  child: Container(
                    alignment: Alignment.center,
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white)),
                    width: MediaQuery.of(context).size.width - 40,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 170,
                              child: Text(
                                '${index + 1}. ${getProductByVariantId(stocks[index].variantId)?.name}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            const VerticalDivider(
                              endIndent: 10,
                              indent: 10,
                            ),
                          ],
                        ),
                        Text(
                          '${stocks[index].quantity} left',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Text(
                          '${stocks[index].limitStock} Stock',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
