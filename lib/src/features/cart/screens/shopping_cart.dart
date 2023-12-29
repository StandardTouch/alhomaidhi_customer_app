import 'package:alhomaidhi_customer_app/src/features/cart/providers/my_cart_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/widgets/cart_placeholder.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/widgets/price_widget.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/widgets/single_cart_item.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/provider/address_provider.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/address_widget.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ShoppingCartScreen extends ConsumerStatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  ConsumerState<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends ConsumerState<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(myCartProvider);
    final cartDetails = ref.watch(cartDetailsProvider);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text("My Cart"),
      ),
      body: cart.when(data: (data) {
        return ListView(
          padding: const EdgeInsets.all(10),
          shrinkWrap: true,
          children: [
            const AddressWidget(),
            ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: data.message!.cart!.length,
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  key: ValueKey(data.message!.cart![index].key!),
                  productImage: data
                      .message!.cart![index].productDetails!.images![0].src!,
                  productName: data.message!.cart![index].productDetails!.name!,
                  productQuantity: data.message!.cart![index].quantity!,
                  itemTotal: data.message!.cart![index].lineTotal!,
                  stockQty:
                      data.message!.cart![index].productDetails!.stockQuantity!,
                  productId:
                      data.message!.cart![index].productDetails!.productId!,
                  cartKey: data.message!.cart![index].key!,
                );
              },
            ),
            const Gap(5),
            Text(
              "Billing Details",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Gap(5),
            PriceWidget(
              title: "Subtotal",
              value: data.message!.cartTotals!.subtotal!,
            ),
            PriceWidget(
              title: "Tax",
              value: data.message!.cartTotals!.subtotalTax ?? 0,
            ),
            PriceWidget(
              title: "Discount",
              value: data.message!.cartTotals!.discountTotal!,
              isDiscount: true,
            ),
            const Divider(),
            PriceWidget(
              title: "Total Amount",
              value: data.message!.cartTotals!.total!,
            ),
            const Divider(),
            Text(
              "You will save SAR ${data.message!.cartTotals!.discountTotal!} on this order",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.green[800],
                  ),
            ),
            const Gap(5),
            const CartPlaceHolder(),
            const Gap(10),
            ElevatedButton.icon(
              onPressed: (cartDetails.isLoading ||
                      cartDetails.deletingElement["isDeleting"])
                  ? null
                  : () {
                      context.pushNamed("checkout", pathParameters: {
                        "totalBal": data.message!.cartTotals!.total!
                      });
                    },
              icon: const Icon(Icons.wallet),
              label: Text(
                (cartDetails.isLoading ||
                        cartDetails.deletingElement["isDeleting"])
                    ? "Updating Cart"
                    : "Checkout",
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            )
          ],
        );
      }, error: (err, stk) {
        if (err is HomaidhiException) {
          return Center(
            child: Text(err.message),
          );
        } else {
          return Center(
            child: Text(err.toString()),
          );
        }
      }, loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
