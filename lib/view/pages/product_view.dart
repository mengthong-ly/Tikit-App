import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/components/product_item.dart';
import 'package:event_with_thong/viewModels/classification_provider.dart';
import 'package:event_with_thong/viewModels/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatefulWidget {
  final TaxonModel model;
  const ProductView({super.key, required this.model});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView>
    with TickerProviderStateMixin {
  bool isCollapsed = false;
  double scrollHeight = 10;
  late final TabController _tabController;
  late final ScrollController _scrollController = ScrollController();
  late final List<ProductModel?> product;
  String? get taxonImage => widget.model.image;
  String? get vendorImage =>
      context.read<VendorProvider>().getVendorImageById(widget.model.vendorId);

  void onCollapsed(bool value) {
    if (isCollapsed == value) return;
    setState(() => isCollapsed = value);
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _tabController = TabController(vsync: this, length: 2);
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
      newHeight = (offset / 2).clamp(0, 50);
    } else {
      newHeight = 50;
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
          SliverToBoxAdapter(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: TabBar(
                    controller: _tabController,
                    indicatorWeight: 2.0,
                    indicatorColor: Theme.of(context).primaryColor,
                    labelColor: Theme.of(context).primaryColor,
                    enableFeedback: false,
                    splashFactory: NoSplash.splashFactory,
                    splashBorderRadius: const BorderRadius.only(),
                    dividerColor: Colors.transparent,
                    tabs: const [
                      Tab(
                        text: 'Tickets',
                      ),
                      Tab(
                        text: 'Event Info',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  kToolbarHeight -
                  220, // Adjust height based on your layout
              child: TabBarView(
                controller: _tabController,
                children: [
                  ListView.builder(
                    padding: const EdgeInsets.only(bottom: 150, top: 20),
                    itemCount: product.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        product: product,
                        taxonImage: taxonImage != null && taxonImage!.isNotEmpty
                            ? taxonImage!
                            : 'assets/Group 60.png',
                        index: index,
                      );
                    },
                  ),
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        alignment: Alignment.center,
                        child: Text(widget.model.description),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
      flexibleSpace: buildFlexibleSpaceBar(
          taxonImage != null && taxonImage!.isNotEmpty
              ? taxonImage!
              : 'assets/Group 60.png'),
      pinned: true,
      shadowColor: Colors.transparent,
    );
  }

  Widget buildFlexibleSpaceBar(String? taxonImage) {
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
          background: buildFlexibleSpaceBarBackground(
              context,
              taxonImage != null && taxonImage.isNotEmpty
                  ? taxonImage
                  : 'assets/Group 60.png'),
          expandedTitleScale: 1,
          title: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(183, 0, 0, 0),
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
                        child: ClipRRect(
                          child: CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(
                                  vendorImage != null && vendorImage!.isNotEmpty
                                      ? vendorImage!
                                      : 'assets/Group 60.png')
                              // taxonImage != null && taxonImage.isNotEmpty
                              //     ? taxonImage
                              //     : 'assets/Group 60.png'),
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

  Widget buildFlexibleSpaceBarBackground(
    BuildContext context,
    String image,
  ) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(),
      child: Image.asset(
        image.isNotEmpty ? image : 'assets/Group 60.png',
        fit: BoxFit.cover,
      ),
    );
  }
}
