import 'package:Alhomaidhi/main.dart';
import 'package:Alhomaidhi/src/features/cart/providers/my_cart_provider.dart';
import 'package:Alhomaidhi/src/features/cart/widgets/cart_placeholder.dart';
import 'package:Alhomaidhi/src/features/cart/widgets/price_widget.dart';
import 'package:Alhomaidhi/src/features/cart/widgets/single_cart_item.dart';
import 'package:Alhomaidhi/src/shared/providers/auth_provider.dart';
import 'package:Alhomaidhi/src/shared/providers/loading_provider.dart';
import 'package:Alhomaidhi/src/shared/widgets/address_widget.dart';
import 'package:Alhomaidhi/src/shared/widgets/homaidhi_appbar.dart';
import 'package:Alhomaidhi/src/shared/widgets/login_to_continue_widget.dart';
import 'package:Alhomaidhi/src/shared/widgets/refresh_button.dart';
import 'package:Alhomaidhi/src/utils/exceptions/homaidhi_exception.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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
  void initState() {
    ref.read(cartDetailsProvider.notifier).checkAddress(ref);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(isLoadingProvider);
    final cart = ref.watch(myCartProvider);
    final cartDetails = ref.watch(cartDetailsProvider);
    final isLoggedIn = ref.watch(authProvider);
    if (!isLoggedIn) {
      return LoginToContinueWidget();
    }

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
                        TranslationHelper.translation(context)!.billingDetails,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const Gap(5),
                      PriceWidget(
                        title: TranslationHelper.translation(context)!.subtotal,
                        value: data.message!.cartTotals!.subtotal!,
                      ),
                      PriceWidget(
                        title: TranslationHelper.translation(context)!.tax,
                        value: data.message!.cartTotals!.subtotalTax ?? 0,
                      ),
                      const Divider(),
                      PriceWidget(
                        isTotal: true,
                        title:
                            TranslationHelper.translation(context)!.totalAmount,
                        value: data.message!.cartTotals!.total!,
                      ),
                      const Divider(),
                      const CartPlaceHolder(),
                      const Gap(10),
                      if (!cartDetails.isPasswordPresent)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                  TranslationHelper.translation(context)!
                                      .pleaseAddPassword),
                            ),
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  context.push("/address");
                                },
                                label: Text(
                                    TranslationHelper.translation(context)!
                                        .addPassword),
                                icon: const Icon(Icons.add),
                              ),
                            )
                          ],
                        ),
                      const Gap(10),
                      ElevatedButton.icon(
                        onPressed: (cartDetails.isLoading ||
                                cartDetails.deletingElement["isDeleting"] ||
                                !cartDetails.isAddressPresent ||
                                !cartDetails.isPasswordPresent ||
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
                              ? TranslationHelper.translation(context)!
                                  .updatingCart
                              : (!cartDetails.isAddressPresent)
                                  ? TranslationHelper.translation(context)!
                                      .addressNotProvided
                                  : (cartDetails.isCheckingOut)
                                      ? TranslationHelper.translation(context)!
                                          .checkingOut
                                      : TranslationHelper.translation(context)!
                                          .checkout,
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
                          TranslationHelper.translation(context)!.cartIsEmpty,
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
                          label: Text(
                            TranslationHelper.translation(context)!.refresh,
                            style: const TextStyle(
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(TranslationHelper.translation(context)!
                            .serverErrorOccurred),
                        RefreshButton(provider: myCartProvider)
                      ],
                    ),
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
