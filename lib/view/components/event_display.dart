import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/view/components/event_card.dart';
import 'package:event_with_thong/viewModels/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventDisplay extends StatelessWidget {
  final void Function(TaxonModel) onEventClick;
  final String title;
  final List<TaxonModel> taxons;

  const EventDisplay({
    super.key,
    required this.taxons,
    required this.onEventClick,
    required this.title,
  });


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Text(
             title,
              style:
                  context.watch<ThemeProvider>().theme.textTheme.headlineMedium,
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 343 * 9 / 16,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 10),
              scrollDirection: Axis.horizontal,
              itemCount: taxons.length,
              itemBuilder: (context, index) {
                return EventCard(
                  taxon: taxons[index],
                  onEventClick: onEventClick,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
