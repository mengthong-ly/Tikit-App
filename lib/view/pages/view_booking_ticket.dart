import 'package:event_with_thong/theme/text_theme.dart';
import 'package:flutter/material.dart';

class ViewBookingTicket extends StatelessWidget {
  const ViewBookingTicket({super.key});

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
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 50),
                const CustomTicketCard(
                  title: "RUN WITH SAI",
                  ticketNumber: "L439307592",
                  eventName: "7.1 KM - KOH KONG BRIDGE RACE",
                  details: "Distance: 7.1KM, T-Shirt: L\n(65-75kg | 1.70m)",
                  date: "10 ខែឧសភា 2024",
                ),
                const SizedBox(
                  height: 20,
                ),
                buildTitle('Date & Time'),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.schedule),
                    SizedBox(
                      width: 10,
                    ),
                    Text(' 3:00pm - 9:00pm'),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                // locatioin
                buildTitle('Location'),
                const SizedBox(height: 15),
                const Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Icon(Icons.pin_drop_outlined),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 350,
                      child: Text(
                          'st 230,  songkat beoung salang, khan toul kork, Phnom Penh'),
                    ),
                  ],
                ),
                // map image
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width * 9 / 21,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 20,
                            spreadRadius: 2,
                            color: Color.fromARGB(37, 0, 0, 0))
                      ],
                      color: const Color(0xff303030),
                      image: const DecorationImage(
                          image: AssetImage('assets/map.png'),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(5)),
                ),
                buildTitle('Description'),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu',
                    style: TTextTheme.lightTextTheme.bodyMedium,
                  ),
                ),
                const SizedBox(
                  height: 200,
                )
              ],
            ),
          ),
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
  final String eventName;
  final String details;
  final String date;

  const CustomTicketCard({
    super.key,
    required this.title,
    required this.ticketNumber,
    required this.eventName,
    required this.details,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Container(
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
                      Text(
                        "លេខអត្តសញ្ញាណប័ណ្ណ: $ticketNumber",
                        style: const TextStyle(color: Colors.white70),
                      ),
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
                        decoration: const BoxDecoration(
                            color: Color(0xff16a34a),
                            borderRadius: BorderRadius.all(Radius.circular(3))),
                        child: Center(
                          child: FittedBox(
                            fit: BoxFit.cover,
                            child: Text(
                              "valid",
                              style: TTextTheme.darkTextTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        'x2 Run with sai',
                        style: TTextTheme.lightTextTheme.titleLarge,
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
