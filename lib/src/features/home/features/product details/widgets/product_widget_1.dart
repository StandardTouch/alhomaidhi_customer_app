import 'package:Alhomaidhi/src/shared/providers/language_provider.dart';
import 'package:Alhomaidhi/src/utils/helpers/conversion.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ProductWidget1 extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = ref.watch(languageProvider);
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
                  isArabic
                      ? ConversionHelper.getArabicPart(productName)
                      : ConversionHelper.getEnglishPart(productName),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
              Expanded(
                flex: 1,
                child: FittedBox(
                  child: Text(
                    "${TranslationHelper.translation(context)!.sku} $skuNumber",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.grey),
                  ),
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
                  "${discountPercentage.substring(0, 2)}${TranslationHelper.translation(context)!.percentOff}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 40, 122, 43),
                      ),
                ),
                const Gap(10),
                Text(
                  "$priceAfter ريال",
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
