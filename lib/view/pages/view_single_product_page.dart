import 'package:event_with_thong/models/option_type.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/product_variant.dart';
import 'package:event_with_thong/view/pages/bottom_sheet_content.dart';
import 'package:event_with_thong/view/pages/welcome_page.dart';
import 'package:event_with_thong/viewModels/product_variant_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

enum Mode {
  addToCart,
  checkOut;
}

class ViewSingleProductPage extends StatefulWidget {
  final ProductModel model;
  const ViewSingleProductPage({super.key, required this.model});

  @override
  State<ViewSingleProductPage> createState() =>
      _ViewSingleVarientTicketPageState();
}

class _ViewSingleVarientTicketPageState extends State<ViewSingleProductPage> {
  List<ProductVariantModel> productVariants = [];
  List<OptionTypeModel> optionTypes = [];
  late ProductVariantModel? selectedProductVariant;
  ProductVariantModel? get initialSelectVariants =>
      productVariants.isNotEmpty ? productVariants.first : null;
  int get totalStock => context
      .read<ProductVariantProvider>()
      .getAllStockQuantityByProductId(widget.model.id);

  @override
  void initState() {
    super.initState();
    load();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      productVariants = context
          .read<ProductVariantProvider>()
          .getVariantsByProductId(widget.model.id);
      optionTypes =
          context.read<ProductVariantProvider>().getOptionTypeForEachVariant();
      selectedProductVariant = initialSelectVariants;
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void load() async {
    await context.read<ProductVariantProvider>().load();
  }

  void onVariantSelected(ProductVariantModel variant) {
    setState(() {
      selectedProductVariant = variant;
    });
  }

  void triggerModelForBuyNow() {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return BottomSheetContent(
              mode: Mode.checkOut,
              product: widget.model,
              scrollController: scrollController,
              productVariants: productVariants,
              onVariantSelected: onVariantSelected,
            );
          },
        );
      },
    );
  }

  void triggerModelForAddToCart() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => DraggableScrollableSheet(
        expand: false,
        builder: (context, scrollController) => BottomSheetContent(
          mode: Mode.addToCart,
          product: widget.model,
          productVariants: productVariants,
          onVariantSelected: onVariantSelected,
          scrollController: scrollController,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: buildBottomNavigationBar(
        context,
        triggerAddToCart: triggerModelForAddToCart,
        triggerBuy: triggerModelForBuyNow,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            flexibleSpace: buildFlexibleSpace(),
            foregroundColor: Colors.white,
            leading: IconButton(
              style: IconButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.all(0),
              ),
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.navigate_before,
                size: 24,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),
                  buildEventHeader(),
                  const SizedBox(height: 15),
                  const Divider(),
                  const SizedBox(height: 15),
                  buildEventDetailRow('Locations', widget.model.location),
                  buildEventDetailRow(
                      'Time', widget.model.eventDate.toString()),
                  buildEventDetailRow('Cautious',
                      'lorem imsump lorem imsump lorem imsump lorem imsump'),
                  const Divider(),
                  const SizedBox(height: 10),
                  const Text('check-in note'),
                  const SizedBox(height: 10),
                  const Text(
                    'Instruction',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    'Before Entering the Events you must come with your Ticket in the App not Screen shot. Do not resell any ticket to anyone. Incase you get scam, we will not responsible for that',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context,
      {VoidCallback? triggerAddToCart, VoidCallback? triggerBuy}) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: Container(
        decoration: const BoxDecoration(
          // color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              spreadRadius: 5,
              color: Color.fromARGB(28, 0, 0, 0),
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TElevatedButtonSmall(
              label: 'Add to Cart',
              onPress: triggerAddToCart!,
            ),
            TElevatedButtonSmall(label: 'Buy Now', onPress: triggerBuy!),
          ],
        ),
      ),
    );
  }

  Widget buildEventHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.model.name,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text('\$${widget.model.price}'),
          ],
        ),
        Container(
          width: 65,
          height: 23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: const Color(0xff16A34A),
          ),
          child: FittedBox(
            child: Text(
              totalStock.toString(),
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildEventDetailRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 70,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 300,
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFlexibleSpace() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FlexibleSpaceBar(
          background: StaggeredGrid.count(
            crossAxisCount: 4,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: List.generate(5, (index) {
              return StaggeredGridTile.count(
                crossAxisCellCount: index == 0 ? 4 : 1,
                mainAxisCellCount: index == 0 ? 2 : 1,
                child: Image.asset(
                  'assets/image/event2.jpeg',
                  fit: BoxFit.cover,
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

Widget buildFlexibleSpace() {
  return LayoutBuilder(
    builder: (context, constraints) {
      return FlexibleSpaceBar(
        background: StaggeredGrid.count(
          crossAxisCount: 4,
          mainAxisSpacing: 4,
          crossAxisSpacing: 4,
          children: [
            StaggeredGridTile.count(
              crossAxisCellCount: 4,
              mainAxisCellCount: 2,
              child: Image.asset(
                'assets/image/event2.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Image.asset(
                'assets/image/event2.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Image.asset(
                'assets/image/event2.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Image.asset(
                'assets/image/event2.jpeg',
                fit: BoxFit.cover,
              ),
            ),
            StaggeredGridTile.count(
              crossAxisCellCount: 1,
              mainAxisCellCount: 1,
              child: Image.asset(
                'assets/image/event2.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    },
  );
}
