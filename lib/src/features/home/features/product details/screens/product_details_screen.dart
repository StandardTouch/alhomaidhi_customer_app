import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/models/single_product_model.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/providers/product_details_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/widgets/product_carousel.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/widgets/product_widget_1.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/widgets/product_widget_2.dart';
import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/widgets/product_widget_3.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/homaidhi_appbar.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/assets.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ProductDetailsScreen extends ConsumerStatefulWidget {
  const ProductDetailsScreen({
    super.key,
    required this.productId,
  });
  final String productId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends ConsumerState<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final productDetails = ref.watch(productDetailsProvider(widget.productId));
    return Scaffold(
      appBar: const HomaidhiAppbar(),
      body: productDetails.when(
        data: (data) {
          return ListView(
            children: [
              ProductCarousel(
                images: data.message!.images ??
                    [
                      Images(
                        id: 1,
                        name: "no-image-404",
                        src: Assets.fallBackProductImage,
                      )
                    ],
              ),
              ProductWidget1(
                productName: data.message!.productDetails!.name!,
                priceAfter: data.message!.productDetails!.price!,
                priceBefore: data.message!.productDetails!.regularPrice!,
                skuNumber: data.message!.productDetails!.sku!,
              ),
              const Gap(10),
              const ProductWidget2(),
              const Gap(10),
              const ProductWidget3(),
            ],
          );
        },
        error: (err, stk) {
          return Center(
            child: (err is HomaidhiException)
                ? Text(
                    "An error Occurred: " + err.message,
                  )
                : Text(
                    err.toString(),
                  ),
          );
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      bottomNavigationBar: FittedBox(
        child: Row(
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text("Add to cart"),
              style: ElevatedButton.styleFrom(
                  shape: const BeveledRectangleBorder()),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.credit_card),
              label: Text("Buy Now"),
              style: ElevatedButton.styleFrom(
                shape: const BeveledRectangleBorder(),
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
