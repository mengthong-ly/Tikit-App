import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/view/operator/operator_event_form.dart';
import 'package:event_with_thong/view/operator/operator_product_form.dart';
import 'package:event_with_thong/view/operator/operator_template_page.dart';
import 'package:event_with_thong/viewModels/classification_provider.dart';
import 'package:event_with_thong/viewModels/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OperatorProductView extends StatefulWidget {
  const OperatorProductView({super.key});

  @override
  State<OperatorProductView> createState() => _OperatorProductViewState();
}

class _OperatorProductViewState extends State<OperatorProductView> {
  late List<ProductModel> products;

  @override
  void initState() {
    super.initState();
  }

  Future<void> load() async {
    await context.read<ProductModelProvider>().load();
    products =
        await context.read<ProductModelProvider>().service.getAllProducts() ??
            [];
  }

  Future<void> onTap(BuildContext context) async {
    final Map<TaxonModel, ProductModel>? result =
        await Navigator.push<Map<TaxonModel, ProductModel>>(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const OperatorProductForm(mode: FormMode.create);
        },
      ),
    );
    if (result != null) {
      await context
          .read<ProductModelProvider>()
          .service
          .addProduct(result.values.first);
      await context
          .read<ClassificationProvider>()
          .service
          .addProductTaxon(result.keys.first, result.values.first);
      setState(() {});
    }
  }

  Future<void> onEdit(ProductModel product) async {
    final Map<TaxonModel, ProductModel>? result =
        await Navigator.push<Map<TaxonModel, ProductModel>>(context,
            MaterialPageRoute(
      builder: (context) {
        return OperatorProductForm(mode: FormMode.edit, product: product);
      },
    ));
    if (result != null) {
      await context
          .read<ProductModelProvider>()
          .service
          .updateProduct(result.values.first);

      await context
          .read<ClassificationProvider>()
          .service
          .updateProductTaxonById(result.keys.first, result.values.first);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return OperatorTemplatePage(
      title: 'Product',
      bottom: GestureDetector(
        onTap: () => onTap(context),
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
      child: FutureBuilder(
          future: load(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => onEdit(products[index]),
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
                        children: [
                          Text(
                            '${index + 1}. ',
                            style: const TextStyle(color: Colors.white),
                          ),
                          Text(
                            products[index].name,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
