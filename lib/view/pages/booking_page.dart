import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/models/order.dart';
import 'package:event_with_thong/viewModels/classification_provider.dart';
import 'package:event_with_thong/viewModels/order_provider.dart';
import 'package:event_with_thong/viewModels/product_provider.dart';
import 'package:event_with_thong/viewModels/taxon_provider.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:event_with_thong/view/pages/view_booking_ticket.dart';
import 'package:event_with_thong/viewModels/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingHome extends StatefulWidget {
  const BookingHome({super.key});

  @override
  State<BookingHome> createState() => _BookingHomeState();
}

class _BookingHomeState extends State<BookingHome>
    with SingleTickerProviderStateMixin {
  bool isLoading = true;
  bool isCollapsed = false;
  late TabController controller;
  void onCollapsed(bool value) {
    if (isCollapsed == value) return;
    setState(() => isCollapsed = value);
  }

  List<OrderModel> order = [];

  @override
  void initState() {
    super.initState();
    controller = TabController(vsync: this, length: 2);
  }

  Future<void> load() async {
    context.read<OrderProvider>().loadOrder();
    order = await context.read<OrderProvider>().getAllOrders();
    context.read<ClassificationProvider>().load();
    isLoading = false;
    print(order[0].lineitems[0].productVariant.productId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            isLoading == false) {
          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () async {
                      isLoading = true;
                      context.read<ClassificationProvider>().load();
                      context.read<OrderProvider>().loadOrder();
                      await context.read<TaxonModelProvider>().load();
                      await load();
                      setState(() {});
                    },
                  ),
                ],
                centerTitle: false,
                title: const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Booking',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(kToolbarHeight),
                  child: BuildTabBar(controller: controller),
                ),
                pinned: true,
                surfaceTintColor: Colors.transparent,
                forceElevated: true,
                elevation: 0.0,
                backgroundColor: context
                    .watch<ThemeProvider>()
                    .theme
                    .scaffoldBackgroundColor,
                shadowColor: Colors.transparent,
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - kToolbarHeight,
                  child: TabBarView(
                    controller: controller,
                    children: [
                      buildUpcomingBooking(order, context),
                      buildPastBooking(order, context),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

Widget buildPastBooking(List<OrderModel> order, BuildContext context) {
  final List<LineItemModel> lineItems = [];
  for (var order in order) {
    for (var lineItem in order.lineitems) {
      final product = context
          .read<ProductModelProvider>()
          .getProductById(lineItem.productVariant.productId);
      if (product != null && product.eventDate.isBefore(DateTime.now())) {
        lineItems.add(lineItem);
      }
    }
  }

  if (lineItems.isEmpty) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 200),
        child: Text(
          'No Past Booking',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  return ListView.builder(
    itemCount: lineItems.length,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewBookingTicket(
                product: context
                    .read<ProductModelProvider>()
                    .getProductById(lineItems[index].productVariant.productId),
                event: context
                    .read<ClassificationProvider>()
                    .getTaxonByProductId(
                        lineItems[index].productVariant.productId),
                lineItem: lineItems[index],
              ),
            ),
          );
        },
        child: NormalSizeTicket(
          lineItem: lineItems[index],
        ),
      );
    },
  );
}

// Widget buildPastBooking(List<OrderModel> order, BuildContext context) {
//   if (order.isNotEmpty) {
//     final List<LineItemModel> lineItems = [];
//     for (OrderModel order in order) {
//       for (LineItemModel lineItem in order.lineitems) {
//         if (context
//             .read<ProductModelProvider>()
//             .getProductById(lineItem.productVariant.productId)!
//             .eventDate
//             .isBefore(DateTime.now())) {
//           lineItems.add(lineItem);
//         }
//       }
//     }
//     return ListView.builder(
//       itemCount: lineItems.length,
//       itemBuilder: (context, index) {
//         return GestureDetector(
//           onTap: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => ViewBookingTicket(
//                   product: context.read<ProductModelProvider>().getProductById(
//                       lineItems[index].productVariant.productId),
//                   event: context
//                       .read<ClassificationProvider>()
//                       .getTaxonByProductId(
//                           lineItems[index].productVariant.productId),
//                   lineItem: lineItems[index],
//                 ),
//               ),
//             );
//           },
//           child: NormalSizeTicket(
//             lineItem: lineItems[index],
//           ),
//         );
//       },
//     );
//   } else {
//     return const Center(
//       child: Padding(
//         padding: EdgeInsets.only(bottom: 200),
//         child: Text('Empty'),
//       ),
//     );
//   }
// }

// Widget buildUpcomingBooking(List<OrderModel> order, BuildContext context) {
//   if (order.isNotEmpty) {
//     final List<LineItemModel> lineItems = [];
//     for (OrderModel order in order) {
//       for (LineItemModel lineItem in order.lineitems) {
//         if (context
//             .read<ProductModelProvider>()
//             .getProductById(lineItem.productVariant.productId)!
//             .eventDate
//             .isAfter(DateTime.now())) {
//           lineItems.add(lineItem);
//         }
//       }
//     }
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 230),
//       child: ListView.builder(
//         itemCount: lineItems.length,
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ViewBookingTicket(
//                     product: context
//                         .read<ProductModelProvider>()
//                         .getProductById(
//                             lineItems[index].productVariant.productId),
//                     event: context
//                         .read<ClassificationProvider>()
//                         .getTaxonByProductId(
//                             lineItems[index].productVariant.productId),
//                     lineItem: lineItems[index],
//                   ),
//                 ),
//               );
//             },
//             child: NormalSizeTicket(
//               lineItem: lineItems[index],
//             ),
//           );
//         },
//       ),
//     );
//   } else {
//     return const Center(
//       child: Padding(
//         padding: EdgeInsets.only(bottom: 200),
//         child: Text(
//           'No Upcoming Booking',
//           style: TextStyle(
//             fontSize: 18,
//             fontWeight: FontWeight.w500,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }

Widget buildUpcomingBooking(List<OrderModel> order, BuildContext context) {
  final List<LineItemModel> lineItems = [];
  for (var order in order) {
    for (var lineItem in order.lineitems) {
      final product = context
          .read<ProductModelProvider>()
          .getProductById(lineItem.productVariant.productId);
      if (product != null && product.eventDate.isAfter(DateTime.now())) {
        lineItems.add(lineItem);
      }
    }
  }

  if (lineItems.isEmpty) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.only(bottom: 200),
        child: Text(
          'No Upcoming Booking',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 230),
    child: ListView.builder(
      itemCount: lineItems.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewBookingTicket(
                  product: context.read<ProductModelProvider>().getProductById(
                      lineItems[index].productVariant.productId),
                  event: context
                      .read<ClassificationProvider>()
                      .getTaxonByProductId(
                          lineItems[index].productVariant.productId),
                  lineItem: lineItems[index],
                ),
              ),
            );
          },
          child: NormalSizeTicket(lineItem: lineItems[index]),
        );
      },
    ),
  );
}

class NormalSizeTicket extends StatelessWidget {
  final LineItemModel lineItem;

  const NormalSizeTicket({
    super.key,
    required this.lineItem,
  });

  @override
  Widget build(BuildContext context) {
    final taxon = context
        .watch<ClassificationProvider>()
        .getTaxonByProductId(lineItem.productVariant.productId);

    return Container(
      margin: const EdgeInsets.all(20),
      width: 343,
      height: 193,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              taxon.image,
              fit: BoxFit.cover,
            ),
            Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(0, 0, 0, 0),
                      Colors.black,
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            context
                                    .read<VendorProvider>()
                                    .getVendorImageById(taxon.vendorId) ??
                                'assets/Group 60.png',
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                taxon.name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class CartItem extends StatelessWidget {
  final LineItemModel lineItem;

  const CartItem({
    super.key,
    required this.lineItem,
  });

  @override
  Widget build(BuildContext context) {
    final taxon = context
        .watch<ClassificationProvider>()
        .getTaxonByProductId(lineItem.productVariant.productId);

    return Container(
      width: 343,
      height: 193,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              taxon.image,
              fit: BoxFit.cover,
            ),
            Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(0, 0, 0, 0),
                      Colors.black,
                    ],
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 15,
                        ),
                        CircleAvatar(
                          backgroundImage: AssetImage(
                            context
                                    .read<VendorProvider>()
                                    .getVendorImageById(taxon.vendorId) ??
                                'assets/Group 60.png',
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 200,
                              child: Text(
                                taxon.name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

class BuildTabBar extends StatelessWidget {
  const BuildTabBar({
    super.key,
    required this.controller,
  });
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      indicatorWeight: 2.0,
      indicatorColor: Theme.of(context).primaryColor,
      labelColor: Theme.of(context).primaryColor,
      enableFeedback: false,
      splashFactory: NoSplash.splashFactory,
      splashBorderRadius: const BorderRadius.only(),
      dividerColor: Colors.transparent,
      tabs: const [
        Tab(
          child: Text(
            'Upcoming',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Tab(
          // text: 'Past Booking',
          child: Text(
            'Past Booking',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
