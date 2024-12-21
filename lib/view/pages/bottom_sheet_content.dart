import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/product_variant.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/pages/payment_screen.dart';
import 'package:event_with_thong/view/pages/view_single_product_page.dart';
import 'package:event_with_thong/viewModels/cart_provider.dart';
import 'package:event_with_thong/viewModels/product_variant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetContent extends StatefulWidget {
  final List<ProductVariantModel> productVariants;
  final Function(ProductVariantModel) onVariantSelected;
  final ScrollController scrollController;
  final ProductModel product;
  final Mode mode;

  const BottomSheetContent({
    required this.mode,
    required this.product,
    required this.productVariants,
    required this.onVariantSelected,
    required this.scrollController,
    super.key,
  });

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  ProductVariantModel? selectedProductVariant;
  int quantity = 0;
  bool get ischeckOutAble => quantity > 0 && quantity <= 5 && isStockValid;
  bool get isCheckOut => widget.mode == Mode.checkOut;
  ProductVariantModel? get initialProductVariant =>
      widget.productVariants.isEmpty ? null : widget.productVariants.first;
  bool get isStockValid =>
      checkStock(selectedProductVariant!.id) > 0 &&
      quantity <= checkStock(selectedProductVariant!.id);

  @override
  void initState() {
    super.initState();
    selectedProductVariant = initialProductVariant;
  }

  void increasequantity() {
    setState(() {
      quantity < 5 ? quantity += 1 : quantity += 0;
    });
  }

  int checkStock(String variantId) {
    return context
        .read<ProductVariantProvider>()
        .getStockQuantityByVariantId(variantId);
  }

  void decreamentquantity() {
    setState(() {
      quantity > 0 ? quantity -= 1 : quantity -= 0;
    });
  }

  void showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  void onVaraintSheetSelect(ProductVariantModel variant) {
    setState(() {
      selectedProductVariant = variant;
    });
    widget.onVariantSelected(variant);
  }

  void onCheckOut() async {
    if (quantity == 0 &&
        selectedProductVariant != null &&
        checkStock(selectedProductVariant!.id) <= 0) {
      showSnackbar(context, 'Invalid quantity');
    } else {
      // Directly await the result and navigate after getting the cart
      final cart = await context
          .read<CartProvider>()
          .constructLineItem(selectedProductVariant!, quantity, widget.product);
      redirect(cart);
    }
  }

  void redirect(List<LineItemModel> cart) {
    isCheckOut
        ? Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(cart: cart),
            ),
          )
        : Navigator.pop(context);
  }

  Widget buildBookingButton(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: const Color(0xfff4f4f4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "total",
                  style: TTextTheme.lightTextTheme.titleSmall,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        decreamentquantity();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFD2942),
                            borderRadius: BorderRadius.circular(5)),
                        width: 27,
                        height: 27,
                        child: const Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        '$quantity',
                        style: TTextTheme.lightTextTheme.titleSmall,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        increasequantity();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: const Color(0xffFD2942),
                            borderRadius: BorderRadius.circular(5)),
                        width: 27,
                        height: 27,
                        child: const Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFD2942),
                ),
                onPressed: ischeckOutAble ? onCheckOut : null,
                child: Text(
                  isCheckOut ? 'Check-out' : 'Add to Cart',
                  style: TTextTheme.darkTextTheme.titleLarge,
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: widget.scrollController,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 75,
                      height: 75,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const Text(
                          'In stock',
                          style: TextStyle(color: Color(0xff16a34a)),
                        ),
                        Text(
                          widget.product.price.toString(),
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Options Types',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                ...widget.productVariants.asMap().entries.map(
                      (variant) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text(variant.value.optionTypesId),
                            const SizedBox(height: 5),
                            Wrap(
                              spacing: 10,
                              runSpacing: 10,
                              children: List.generate(
                                variant.value.optionTypesId.length,
                                (index) => GestureDetector(
                                  onTap: () =>
                                      onVaraintSheetSelect(variant.value),
                                  child: Container(
                                    height: 23,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: selectedProductVariant ==
                                              variant.value
                                          ? const Color(0xffFD2942)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      border: Border.all(
                                        color: const Color(0xffFD2942),
                                      ),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.contain,
                                      child: Text(context
                                          .read<ProductVariantProvider>()
                                          .getOptionTypeById(variant
                                              .value.optionTypesId[index])
                                          .description),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
        ),
        buildBookingButton(context),
      ],
    );
  }
}
