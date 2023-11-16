import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cardHeight = DeviceInfo.getDeviceHeight(context) * 0.3;
    final cardWidth = DeviceInfo.getDeviceWidth(context) * 0.45;
    return Card(
      child: Container(
        height: cardHeight,
        width: cardWidth,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.red,
              height: cardHeight * 0.5,
              width: double.infinity,
              child: const Text("product image"),
            ),
            // Product Title
            Text(
              "Product Title",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "Product title/Arabic Title",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            RichText(text: TextSpan(text: "Price", children: []))
          ],
        ),
      ),
    );
  }
}
