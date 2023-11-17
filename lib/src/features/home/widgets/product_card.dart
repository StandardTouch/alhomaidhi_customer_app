import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.imageUrl});
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final cardHeight = DeviceInfo.getDeviceHeight(context) * 0.4;
    final cardWidth = DeviceInfo.getDeviceWidth(context) * 0.4;
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(15),
        ),
        // height: cardHeight,
        // width: cardWidth,
        constraints: BoxConstraints(
          minHeight: cardHeight,
          minWidth: cardWidth,
          maxHeight: cardHeight + 150,
          maxWidth: cardWidth + 150,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // picture container
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.contain)),
              height: cardHeight * 0.4,
              width: double.infinity,
              child: const SizedBox.shrink(),
            ),
            // details container
            Container(
              height: cardHeight * 0.4,
              child: Column(
                children: [
                  Text(
                    "Product Title",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Product title/Arabic Title",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Row(
                    children: [
                      Text(
                        "100.22",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                      const Gap(4),
                      Text(
                        "98.99",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ],
              ),
            ),
            const Gap(4),
            SizedBox(
              height: cardHeight * 0.075,
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
                    backgroundColor: Theme.of(context).colorScheme.onSecondary),
                child: Text(
                  "Buy Now",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
