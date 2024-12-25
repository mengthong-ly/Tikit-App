import 'package:event_with_thong/models/line_item.dart';
import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ViewBookingTicket extends StatelessWidget {
  final LineItemModel lineItem;
  final TaxonModel event;
  final ProductModel? product;
  const ViewBookingTicket({
    super.key,
    required this.lineItem,
    required this.event,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0,
            title: const Text("Tickets"),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shadowColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            forceElevated: true,
            pinned: true,
            toolbarHeight: kToolbarHeight,
          ),
          SliverList.builder(
            itemCount: lineItem.quantity,
            itemBuilder: (context, index) {
              return CustomTicketCard(
                eventDate: product!.eventDate,
                ticketImage: event.image,
                ticketName: product?.name ?? 'product not found',
                title: event.name,
                ticketNumber: event.id,
                eventName: "7.1 KM - KOH KONG BRIDGE RACE",
                details: "Distance: 7.1KM, T-Shirt: L\n(65-75kg | 1.70m)",
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        // 'Date & Time',
        title,
        style: TTextTheme.lightTextTheme.headlineSmall,
      ),
    );
  }
}

class CustomTicketCard extends StatelessWidget {
  final String title;
  final String ticketNumber;
  final String ticketName;
  final String ticketImage;
  final DateTime eventDate;
  final String eventName;
  final String details;

  const CustomTicketCard({
    super.key,
    required this.title,
    required this.ticketNumber,
    required this.eventName,
    required this.details,
    required this.ticketName,
    required this.ticketImage,
    required this.eventDate,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: 390,
        height: 390 * 9 / 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      blurRadius: 20,
                      spreadRadius: 2,
                      color: Color.fromARGB(37, 0, 0, 0))
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color(0xff4338CA),
                    Color(0xffFD2942),
                  ],
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Colors.white,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            DateFormat('dd-mm-yyyy').format(eventDate),
                            style: const TextStyle(color: Colors.white),
                          )
                        ],
                      )
                    ],
                  ),
                  const Icon(
                    Icons.qr_code_2,
                    size: 40,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: const Color(0xff303030),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          ticketImage,
                          fit: BoxFit.cover,
                        )),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 70,
                        height: 26,
                        decoration: BoxDecoration(
                            color: DateTime.now().isBefore(eventDate)
                                ? const Color(0xff16a34a)
                                : const Color(0xffFD2942),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(3))),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              DateTime.now().isBefore(eventDate)
                                  ? "valid"
                                  : 'Invalid',
                              style: TTextTheme.darkTextTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3),
                        child: Text(
                          ticketName,
                          style: TTextTheme.lightTextTheme.titleLarge,
                        ),
                      ),
                      const Text("Booked: 32 / 13/ 2050")
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
