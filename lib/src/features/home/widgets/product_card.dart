import 'package:alhomaidhi_customer_app/src/utils/helpers/conversion.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
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
    final cardHeight = DeviceInfo.getDeviceHeight(context) * 0.5;
    final cardWidth = DeviceInfo.getDeviceWidth(context) * 0.4;
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).highlightColor,
          borderRadius: BorderRadius.circular(15),
        ),
        height: cardHeight,
        width: cardWidth,
        // constraints: BoxConstraints(
        //   minHeight: cardHeight,
        //   minWidth: cardWidth,
        //   maxHeight: cardHeight + 150,
        //   maxWidth: cardWidth + 150,
        // ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // picture container
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover)),
              height: cardHeight * 0.3,
              width: double.infinity,
              child: const SizedBox.shrink(),
            ),
            // details container
            Column(
              children: [
                Text(
                  ConversionHelper.getEnglishPart(title),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  "$title",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Row(
                  children: [
                    Text(
                      priceBefore,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                    const Gap(4),
                    Text(
                      priceNow,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                const Spacer(),
                SizedBox(
                  height: cardHeight * 0.065,
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
            )
          ],
        ),
      ),
    );
  }
}
