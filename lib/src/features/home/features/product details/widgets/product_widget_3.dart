import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductWidget3 extends StatelessWidget {
  const ProductWidget3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "10 Days return Policy",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
          ),
          const Gap(5),
          Text(
            "Customer Address, KSA",
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.grey,
                ),
          ),
        ],
      ),
    );
  }
}
