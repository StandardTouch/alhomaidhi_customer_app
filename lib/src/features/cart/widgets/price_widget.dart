import 'dart:ui';

import 'package:alhomaidhi_customer_app/src/features/cart/providers/my_cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PriceWidget extends ConsumerWidget {
  const PriceWidget({
    super.key,
    required this.value,
    required this.title,
    this.isDiscount = false,
    this.isTotal = false,
  });
  final String title;
  final dynamic value;
  final bool isDiscount;
  final bool isTotal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartDetails = ref.watch(cartDetailsProvider);
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // const Gap(5),
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: (isTotal) ? FontWeight.bold : FontWeight.normal,
                ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ImageFiltered(
            imageFilter: (cartDetails.isLoading)
                ? ImageFilter.blur(sigmaX: 2, sigmaY: 2)
                : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
            child: Text(
              "SAR $value",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: (isTotal) ? FontWeight.bold : FontWeight.normal,
                    color: isDiscount ? Colors.green[800] : null,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
