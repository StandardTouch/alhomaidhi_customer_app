import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:Alhomaidhi/src/utils/helpers/conversion.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.priceBefore,
    required this.priceNow,
    this.isSearch = false,
    required this.onButtonPress,
    this.discountPercentage = "0",
  });
  final String imageUrl;
  final String title;
  final String priceBefore;
  final String priceNow;
  final bool isSearch;
  final String discountPercentage;
  final Function() onButtonPress;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(15),
      child: InkWell(
        onTap: onButtonPress,
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
              Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    placeholder: (context, url) =>
                        Image.asset(Assets.placeHolderImage),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              // heading
              Expanded(
                flex: isSearch ? 2 : 1,
                child: isSearch
                    ? Text(
                        ConversionHelper.getEnglishPart(title),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      )
                    : FittedBox(
                        child: Text(
                          ConversionHelper.getEnglishPart(title),
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
              ),
              // subheading
              isSearch
                  ? const SizedBox.shrink()
                  : Expanded(
                      flex: 1,
                      child: AutoSizeText(
                        title,
                        maxLines: 2,
                      ),
                    ),
              // price before and after
              if (!isSearch)
                Expanded(
                  flex: 1,
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
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                    ],
                  ),
                ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: isSearch
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceBetween,
                  children: [
                    if (!isSearch)
                      Expanded(
                        child: Text(
                          "${discountPercentage.substring(0, 2)}${TranslationHelper.translation(context)!.percentOff}",
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 40, 122, 43),
                              ),
                        ),
                      ),
                    Expanded(
                      child: SizedBox(
                        height: 30,
                        child: ElevatedButton(
                          onPressed: onButtonPress,
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              backgroundColor:
                                  Theme.of(context).colorScheme.onSecondary),
                          child: FittedBox(
                            child: Text(
                              TranslationHelper.translation(context)!.buyNow,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
