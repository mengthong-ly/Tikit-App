import 'package:event_with_thong/models/product.dart';
import 'package:event_with_thong/theme/text_theme.dart';
import 'package:event_with_thong/view/pages/view_single_product_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductCard extends StatelessWidget {
  final int index;
  const ProductCard({
    super.key,
    required this.product,
    required this.taxonImage,
    required this.index,
  });

  final List<ProductModel?> product;
  final String taxonImage;
  bool get isProductExpired =>
      product[index]!.eventDate.isAfter(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Align(
      child: GestureDetector(
        onTap: () {
          if (isProductExpired) {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return ViewSingleProductPage(
                  model: product[index]!,
                );
              },
            ));
          }
        },
        // here
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width * 9 / 21,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                  image: DecorationImage(
                    image: AssetImage(taxonImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                // height: 70,
                decoration: const BoxDecoration(
                  color: Color(0xff070707),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${product[index]!.name}  |  ',
                          style: TTextTheme.darkTextTheme.titleMedium,
                        ),
                        Text(
                          DateFormat('dd-mm-yyyy')
                              .format(product[index]!.eventDate),
                          style: TTextTheme.darkTextTheme.bodyLarge,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    isProductExpired
                        ? Container(
                            width: 70,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white),
                            ),
                            child: FittedBox(
                                fit: BoxFit.contain,
                                child: Text(
                                  '\$ ${product[index]!.price.toString()}',
                                  style: TTextTheme.darkTextTheme.bodyLarge,
                                )),
                          )
                        : Container(
                            width: 70,
                            height: 22,
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xffFD2942),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const FittedBox(
                              fit: BoxFit.contain,
                              child: Text(
                                'End',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
