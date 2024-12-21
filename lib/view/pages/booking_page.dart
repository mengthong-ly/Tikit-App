import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/models/order.dart';
import 'package:event_with_thong/viewModels/order_provider.dart';
import 'package:event_with_thong/viewModels/product_variant_provider.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:event_with_thong/view/pages/view_booking_ticket.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookingHome extends StatefulWidget {
  const BookingHome({super.key});

  @override
  State<BookingHome> createState() => _BookingHomeState();
}

class _BookingHomeState extends State<BookingHome>
    with SingleTickerProviderStateMixin {
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
    order = await context.read<OrderProvider>().getAllOrders();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: load(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverAppBar(
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
                      buildPastBooking(),
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

Widget buildPastBooking() {
  return ListView.builder(
    itemCount: 20,
    itemBuilder: (context, index) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ViewBookingTicket(),
              ));
        },
        child: Container(
          width: 343,
          height: 193,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: const Color(0xff303030)),
        ),
      );
    },
  );
}

Widget buildUpcomingBooking(List<OrderModel> order, BuildContext context) {
  if (order.isNotEmpty) {
    List<LineItemModel> lineItems = [];
    for (var element in order) {
      lineItems.addAll(element.lineitems);
    }

    return ListView.builder(
      itemCount: lineItems.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ViewBookingTicket(),
                ),
              );
            },
            child: lineItems.length - 1 != index
                ? NormalSizeTicket(
                    lineItems: lineItems,
                    index: index,
                  )
                : LastSizeTIcket(lineItems: lineItems, index: index));
      },
    );
  } else {
    return const Center(
      child: Text(
        'No Upcoming Booking',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}




class LastSizeTIcket extends StatelessWidget {
  final int index;
  const LastSizeTIcket({
    super.key,
    required this.lineItems,
    required this.index,
  });

  final List<LineItemModel> lineItems;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          width: 343,
          height: 193,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color(0xff303030),
          ),
          child: Center(
            child: Text(
              context
                  .read<ProductVariantProvider>()
                  .getProductById(lineItems[index].productVariant)!
                  .name,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(
          height: 200,
        )
      ],
    );
  }
}

class NormalSizeTicket extends StatelessWidget {
  final int index;
  const NormalSizeTicket({
    super.key,
    required this.lineItems,
    required this.index,
  });

  final List<LineItemModel> lineItems;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: 343,
      height: 193,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color(0xff303030),
      ),
      child: Center(
        child: Text(
          context
              .read<ProductVariantProvider>()
              .getProductById(lineItems[index].productVariant)!
              .name,
          style: const TextStyle(color: Colors.white),
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
