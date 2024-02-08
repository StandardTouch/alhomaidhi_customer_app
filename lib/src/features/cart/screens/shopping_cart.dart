import 'package:alhomaidhi_customer_app/main.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/providers/my_cart_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/widgets/cart_placeholder.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/widgets/price_widget.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/widgets/single_cart_item.dart';
import 'package:alhomaidhi_customer_app/src/shared/providers/loading_provider.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/address_widget.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/homaidhi_appbar.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';

class ShoppingCartScreen extends ConsumerStatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  ConsumerState<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends ConsumerState<ShoppingCartScreen> {
  @override
  void initState() {
    ref.read(cartDetailsProvider.notifier).checkAddress(ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final cart = ref.watch(myCartProvider);
    final cartDetails = ref.watch(cartDetailsProvider);
    return Scaffold(
      appBar: const HomaidhiAppbar(),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : cart.when(
              data: (data) {
                return RefreshIndicator(
                  onRefresh: () async {
                    // ignore: unused_result
                    await ref.refresh(myCartProvider.future);
                  },
                  child: ListView(
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
                            productImage: data.message!.cart![index]
                                .productDetails!.images![0].src!,
                            productName: data
                                .message!.cart![index].productDetails!.name!,
                            productQuantity:
                                data.message!.cart![index].quantity!,
                            itemTotal: data.message!.cart![index].lineTotal!,
                            stockQty: data.message!.cart![index].productDetails!
                                .stockQuantity!,
                            productId: data.message!.cart![index]
                                .productDetails!.productId!,
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
                      const Divider(),
                      PriceWidget(
                        isTotal: true,
                        title: "Total Amount",
                        value: data.message!.cartTotals!.total!,
                      ),
                      const Divider(),
                      const CartPlaceHolder(),
                      const Gap(10),
                      ElevatedButton.icon(
                        onPressed: (cartDetails.isLoading ||
                                cartDetails.deletingElement["isDeleting"] ||
                                !cartDetails.isAddressPresent ||
                                cartDetails.isCheckingOut)
                            ? null
                            : () {
                                ref
                                    .read(cartDetailsProvider.notifier)
                                    .onCheckout(context);
                              },
                        icon: const Icon(Icons.wallet),
                        label: Text(
                          (cartDetails.isLoading ||
                                  cartDetails.deletingElement["isDeleting"])
                              ? "Updating Cart"
                              : (!cartDetails.isAddressPresent)
                                  ? "Address Not Provided"
                                  : (cartDetails.isCheckingOut)
                                      ? "Checking Out"
                                      : "Checkout",
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.onSecondary,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const Gap(80),
                    ],
                  ),
                );
              },
              error: (err, stk) {
                if (err is HomaidhiException) {
                  return Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          err.message,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(),
                        ),
                        const Gap(10),
                        ElevatedButton.icon(
                          onPressed: () async {
                            globalContainer
                                .read(isLoadingProvider.notifier)
                                .state = true;
                            try {
                              // ignore: unused_result
                              await ref.refresh(myCartProvider.future);
                            } catch (_) {
                            } finally {
                              globalContainer
                                  .read(isLoadingProvider.notifier)
                                  .state = false;
                            }
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text(
                            "Refresh",
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: Text(err.toString()),
                  );
                }
              },
              loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
    );
  }
}
