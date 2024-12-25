import 'package:event_with_thong/models/taxon.dart';
import 'package:event_with_thong/viewModels/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EventCard extends StatelessWidget {
  final void Function(TaxonModel) onEventClick;
  final TaxonModel taxon;
  bool get isFeature => taxon.isFeatured;

  const EventCard({
    super.key,
    required this.taxon,
    required this.onEventClick,
  });

  @override
  Widget build(BuildContext context) {
    final vendorImage =
        context.read<VendorProvider>().getVendorImageById(taxon.vendorId);
    return GestureDetector(
      onTap: () => onEventClick(taxon),
      child: Stack(
        children: [
          Container(
            width: 343,
            height: 343 * 9 / 16,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage((taxon.image.isNotEmpty)
                      ? taxon.image
                      : 'assets/Group 60.png'),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
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
                  padding: const EdgeInsets.only(left: 20, bottom: 20),
                  child: Row(
                    crossAxisAlignment: (isFeature)
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundImage: AssetImage(
                            vendorImage != null && vendorImage.isNotEmpty
                                ? vendorImage
                                : 'assets/Group 60.png'),
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
                          if (isFeature)
                            Container(
                              width: 85,
                              height: 18,
                              margin: const EdgeInsets.only(top: 2),
                              padding: const EdgeInsets.all(0.5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(2),
                                color: const Color(0xff16A34A),
                              ),
                              child: const FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  'Best Seller',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
