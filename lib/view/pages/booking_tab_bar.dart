import 'package:flutter/material.dart';

class BookingTabBar extends StatelessWidget {
  const BookingTabBar({
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
          // text: 'Past Booking',
          child: Text(
            'Post Booking',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Tab(
          child: Text(
            'Upcoming',
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
