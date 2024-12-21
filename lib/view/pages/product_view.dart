import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/pages/view_single_product_page.dart';
import 'package:event_with_thong/viewModels/classification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  final TaxonModel model;
  const ProductView({super.key, required this.model});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  bool isCollapsed = false;
  double scrollHeight = 10;
  final ScrollController _scrollController = ScrollController();
  late final List<ProductModel?> product;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    loadProduct();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void loadProduct() {
    product = context
        .read<ClassificationProvider>()
        .getAllProductByTaxonId(widget.model.id);
  }

  void _onScroll() {
    final double offset = _scrollController.offset;
    double newHeight;

    if (offset <= 90) {
      newHeight = (offset / 2).clamp(0, 50); // Grow until offset 100
    } else {
      newHeight = 50; // Stop growing after 100
    }

    if (scrollHeight != newHeight) {
      setState(() {
        scrollHeight = newHeight;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          buildSliverAppBar(),
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: product.length,
            (context, index) {
              return Align(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return ViewSingleProductPage(
                          model: product[index]!,
                        );
                      },
                    ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width * 9 / 21,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: const Color(0xff303030)),
                    child: Center(
                      child: Text(
                        product[index]!.name,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
              );
            },
          )),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      elevation: 0,
      expandedHeight: 220,
      scrolledUnderElevation: 0,
      centerTitle: false,
      collapsedHeight: kToolbarHeight + 24,
      toolbarHeight: kToolbarHeight + 18,
      foregroundColor: Colors.white,
      backgroundColor: !isCollapsed ? Colors.black : Colors.white,
      flexibleSpace: buildFlexibleSpaceBar(),
      pinned: true,
      shadowColor: Colors.transparent,
    );
  }

  void onCollapsed(bool value) {
    if (isCollapsed == value) return;
    setState(() => isCollapsed = value);
  }

  Widget buildFlexibleSpaceBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final top = constraints.biggest.height + 40;
        final collapsePoint =
            MediaQuery.of(context).viewPadding.top + kToolbarHeight + 40;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (isCollapsed != (top <= collapsePoint)) {
            onCollapsed(top <= collapsePoint);
          }
        });

        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          titlePadding: const EdgeInsets.only(top: 20),
          background: buildFlexibleSpaceBarBackground(context),
          expandedTitleScale: 1,
          title: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(117, 0, 0, 0),
                  Colors.black,
                ])),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      SizedBox(
                        width: scrollHeight,
                      ),
                      Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white, width: 1)),
                        child: const ClipRRect(
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              'https://picsum.photos/id/1015/200/300',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.model.name,
                            style: TTextTheme.darkTextTheme.titleLarge,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              widget.model.description,
                              style: TTextTheme.darkTextTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildFlexibleSpaceBarBackground(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(),
      child: Image.asset(
        'assets/image/event3.jpg',
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildFlexibleSpaceBarTitle(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color.fromARGB(0, 0, 0, 0),
            Color.fromARGB(117, 0, 0, 0),
            Colors.black,
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                  child: const ClipRRect(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/id/1015/200/300',
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'The Voice Cambodia',
                      style: TTextTheme.darkTextTheme.headlineSmall,
                    ),
                    Text(
                      'Lorem Ipsum',
                      style: TTextTheme.darkTextTheme.bodyLarge,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
