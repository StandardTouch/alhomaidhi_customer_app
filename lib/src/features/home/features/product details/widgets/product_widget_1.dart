import 'package:alhomaidhi_customer_app/src/utils/helpers/conversion.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductWidget1 extends StatelessWidget {
  const ProductWidget1({
    super.key,
    required this.productName,
    required this.priceAfter,
    required this.priceBefore,
    required this.skuNumber,
    required this.discountPercentage,
  });
  final String productName;
  final String skuNumber;
  final String priceBefore;
  final String priceAfter;
  final String discountPercentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  ConversionHelper.getEnglishPart(productName),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "SKU: " + skuNumber,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.grey),
                ),
              ),
            ],
          ),
          const Gap(10),
          FittedBox(
            child: Text(
              productName,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey),
            ),
          ),
          const Gap(10),
          FittedBox(
            child: Row(
              children: [
                Text(
                  "${discountPercentage.substring(0, 2)}% off",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 40, 122, 43),
                      ),
                ),
                const Gap(10),
                Text(
                  "${priceAfter} ريال",
                  style: Theme.of(context).textTheme.bodyMedium!,
                ),
                const Gap(10),
                Text(
                  priceBefore,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
