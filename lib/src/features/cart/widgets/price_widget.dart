import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    super.key,
    required this.value,
    required this.title,
    this.isDiscount = false,
  });
  final String title;
  final dynamic value;
  final bool isDiscount;

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // const Gap(5),
        Expanded(
          flex: 2,
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            "SAR $value",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.normal,
                  color: isDiscount ? Colors.green[800] : null,
                ),
          ),
        ),
      ],
    );
  }
}
