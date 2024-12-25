import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventPageCardTitle extends StatelessWidget {
  final String title;
  const EventPageCardTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Text(
          title,
          style: context.watch<ThemeProvider>().theme.textTheme.headlineMedium,
        ),
      ),
    );
  }
}
