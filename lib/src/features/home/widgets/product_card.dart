import 'package:alhomaidhi_customer_app/src/utils/helpers/conversion.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.priceBefore,
    required this.priceNow,
  });
  final String imageUrl;
  final String title;
  final String priceBefore;
  final String priceNow;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.center,
              child: Expanded(
                flex: 2,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            // details
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      ConversionHelper.getEnglishPart(title),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  // price before and after
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Text(
                          "$priceNow ريال",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Gap(4),
                        Text(
                          ConversionHelper.formatPrice(priceBefore),
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // const Spacer(),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 40,
                    width: 70,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 2,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor:
                              Theme.of(context).colorScheme.onSecondary),
                      child: Text(
                        "Buy Now",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
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
