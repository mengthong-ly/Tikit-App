import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/viewModels/product_provider.dart';
import 'package:event_with_thong/viewModels/taxon_provider.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:event_with_thong/view/components/custom_appbar.dart';
import 'package:event_with_thong/view/components/event_sliver_app_bar.dart';
import 'package:event_with_thong/view/pages/product_view.dart';
import 'package:event_with_thong/viewModels/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventHomePage extends StatefulWidget {
  const EventHomePage({super.key});

  @override
  State<EventHomePage> createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage> {
  late TabController tabController;

  late List<TaxonModel> taxons;
  late Future<void> _loadTaxonFuture; // Cached future

  @override
  void initState() {
    super.initState();
    _loadTaxonFuture = loadTaxon();
  }

  bool isCollapsed = false;
  void onCollapsed(bool value) {
    if (isCollapsed == value) return;
    setState(() => isCollapsed = value);
  }

  void onEventClick(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) => ProductView(
                  model: taxons[index],
                )));
  }

  Future<void> loadTaxon() async {
    await context.read<TaxonModelProvider>().load();
    await context.read<ProductModelProvider>().load();
    taxons = context.read<TaxonModelProvider>().taxons;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadTaxonFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CustomScrollView(
              slivers: [
                EventSliverAppBar(
                  isCollapsed: isCollapsed,
                  onCollapsed: onCollapsed,
                  welcomeText: 'Hi👋🏻\nUser',
                  isOperator: false,
                ),
                const EventPageCardTitle(),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 343 * 9 / 16,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: taxons.length,
                      itemBuilder: (context, index) {
                        return Center(
                          child: GestureDetector(
                            onTap: () => onEventClick(index),
                            child: Container(
                              width: 343,
                              height: 343 * 9 / 16,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(taxons[index].image != ''
                                        ? taxons[index].image
                                        : 'assets/Group 60.png'),
                                    fit: BoxFit.cover),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              alignment: Alignment.center,
                              // child: Text(
                              //   taxons[index].name,
                              //   style: const TextStyle(fontSize: 16),
                              // ),
                              child: Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(12),
                                  ),
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromARGB(0, 0, 0, 0),
                                      Color.fromARGB(108, 0, 0, 0),
                                      Color.fromARGB(255, 0, 0, 0),
                                    ],
                                  ),
                                ),
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, bottom: 20),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          // backgroundImage: Image.asset('name'),
                                          backgroundImage: AssetImage(context
                                              .read<VendorProvider>()
                                              .getVendorImageById(
                                                  taxons[index].vendorId)),
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        SizedBox(
                                          width: 200,
                                          child: Text(
                                            taxons[index].name,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const EventPageCardTitle(),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 343 * 9 / 16,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Container(
                            width: 343,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Item $index',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const EventPageCardTitle(),
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 343 * 9 / 16,
                    child: ListView.builder(
                      padding: const EdgeInsets.only(left: 10),
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Center(
                          child: Container(
                            width: 343,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade100,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'Item $index',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  Widget buildTitle() {
    return AnimatedOpacity(
        opacity: isCollapsed ? 1 : 0,
        duration: const Duration(milliseconds: 200),
        child: const CustomAppbar());
  }

  Widget buildSliverAppbar() {
    return SliverAppBar(
      elevation: 0,
      expandedHeight: 250,
      centerTitle: false,
      collapsedHeight: kToolbarHeight,
      toolbarHeight: kToolbarHeight,
      backgroundColor: const Color(0xffffffff),
      pinned: true,
      title: buildTitle(),
      shadowColor: Colors.transparent,
      flexibleSpace: buildFlexibleSpaceBar(),
    );
  }

  Widget buildFlexibleSpaceBar() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final top = constraints.biggest.height;
        final collapsePoint =
            MediaQuery.of(context).viewPadding.top + kToolbarHeight;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Avoid updating state unnecessarily
          if (isCollapsed != (top <= collapsePoint)) {
            onCollapsed(top <= collapsePoint);
          }
        });

        return FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          background: AnimatedContainer(
            duration: const Duration(milliseconds: 500), // Smooth animation
            curve: Curves.easeInOut, // Smooth curve for changes
            color: const Color(0xfff4f4f4),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    'Hi 👋🏻\nMengthong',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class EventPageCardTitle extends StatelessWidget {
  const EventPageCardTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Text(
          'Event',
          style: context.watch<ThemeProvider>().theme.textTheme.headlineMedium,
        ),
      ),
    );
  }
}

class NoStretchScrollBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const ClampingScrollPhysics(); // so it won't scroll strech again
  }
}
