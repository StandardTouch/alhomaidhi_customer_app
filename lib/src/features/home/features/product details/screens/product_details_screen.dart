import 'package:Alhomaidhi/src/features/cart/providers/my_cart_provider.dart';
import 'package:Alhomaidhi/src/features/home/features/product%20details/models/single_product_model.dart';
import 'package:Alhomaidhi/src/features/home/features/product%20details/providers/product_details_provider.dart';
import 'package:Alhomaidhi/src/features/home/features/product%20details/widgets/product_carousel.dart';
import 'package:Alhomaidhi/src/features/home/features/product%20details/widgets/product_widget_1.dart';
import 'package:Alhomaidhi/src/features/home/features/product%20details/widgets/product_widget_2.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:Alhomaidhi/src/shared/providers/auth_provider.dart';
import 'package:Alhomaidhi/src/shared/services/auth_service.dart';
import 'package:Alhomaidhi/src/shared/widgets/homaidhi_appbar.dart';
import 'package:Alhomaidhi/src/utils/constants/assets.dart';
import 'package:Alhomaidhi/src/utils/exceptions/homaidhi_exception.dart';
import 'package:Alhomaidhi/src/utils/helpers/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
  bool isStockReady = false;
  int stock = 0;

  @override
  Widget build(BuildContext context) {
    final productDetails = ref.watch(productDetailsProvider(widget.productId));
    final cart = ref.watch(cartDetailsProvider);
    final cartOperations = ref.read(cartDetailsProvider.notifier);
    ref.watch(addressProvider);
    final isLoggedIn = ref.watch(authProvider);

    return PopScope(
      canPop: (cart.isLoading) ? false : true,
      child: Scaffold(
        appBar: const HomaidhiAppbar(
          isProductScreen: true,
        ),
        body: productDetails.when(
          data: (data) {
            setState(() {
              stock = data.message!.productDetails!.stockQuantity!;
              isStockReady = true;
            });
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
                  discountPercentage:
                      data.message!.productDetails!.discountPercentage!,
                ),
                const Gap(10),
                const ProductWidget2(),
              ],
            );
          },
          error: (err, stk) {
            return Center(
              child: (err is HomaidhiException)
                  ? Text(
                      "An error Occurred: ${err.message}",
                    )
                  : const Text(
                      "An Error Occurred. Please contact the developer for more information",
                    ),
            );
          },
          loading: () {
            return LinearProgressIndicator(
              color: Theme.of(context).colorScheme.onSecondary,
            );
          },
        ),
        bottomNavigationBar: ElevatedButton.icon(
          onPressed: (cart.isLoading || stock == 0)
              ? null
              : () {
                  if (!isLoggedIn) {
                    context.go("/login");
                  } else {
                    cartOperations.additemToCart(
                        int.parse(widget.productId), ref, context);
                  }
                },
          icon: const Icon(Icons.add_shopping_cart),
          label: Text(isLoggedIn
              ? ((cart.isLoading)
                  ? "Adding Item"
                  : (!isStockReady)
                      ? "Calculating Stock"
                      : (stock < 1)
                          ? "No Stock Left"
                          : "Add to cart")
              : "Login for cart"),
          style: ElevatedButton.styleFrom(
            shape: const BeveledRectangleBorder(),
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
            foregroundColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
