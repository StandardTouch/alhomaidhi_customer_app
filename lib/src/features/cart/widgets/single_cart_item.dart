import 'dart:ui';

import 'package:Alhomaidhi/src/features/cart/providers/my_cart_provider.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:input_quantity/input_quantity.dart';

class SingleCartItem extends ConsumerWidget {
  const SingleCartItem({
    super.key,
    required this.productImage,
    required this.productName,
    required this.productQuantity,
    required this.itemTotal,
    required this.stockQty,
    required this.productId,
    required this.cartKey,
  });
  final String productImage;
  final String productName;
  final String productQuantity;
  final int itemTotal;
  final int stockQty;
  final int productId;
  final String cartKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartDetails = ref.watch(cartDetailsProvider);
    final cartOperations = ref.read(cartDetailsProvider.notifier);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border.fromBorderSide(
          BorderSide(color: Colors.black),
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      padding: const EdgeInsets.all(8),
      child: ((cartDetails.deletingElement["cartKey"] == cartKey) &&
              (cartDetails.deletingElement["isDeleting"] == true))
          ? Column(
              children: [
                const LinearProgressIndicator(),
                Text(TranslationHelper.translation(context)!.deletingItem),
              ],
            )
          : Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Image.network(productImage),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            child: Text(productName),
                          ),
                          const Gap(5),
                          // quantity field
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InputQty.int(
                                initVal: int.parse(productQuantity),
                                qtyFormProps:
                                    const QtyFormProps(enableTyping: false),

                                maxVal: stockQty -
                                    1, // todo - add stock quantity as max value
                                steps: 1,
                                minVal: 1,
                                onQtyChanged: (value) {
                                  cartOperations.updateCartItem(
                                    productId,
                                    value,
                                    ref,
                                  );
                                  // todo - implement update cart API
                                },
                                decoration: QtyDecorationProps(
                                  btnColor: Theme.of(context).primaryColor,
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.black,
                                  )),
                                  contentPadding: const EdgeInsets.all(2),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  cartOperations.deleteCartItem(cartKey, ref);
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Spacer(),
                    ImageFiltered(
                        imageFilter: (cartDetails.isLoading)
                            ? ImageFilter.blur(sigmaX: 2, sigmaY: 2)
                            : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                        child: Text("$itemTotal ريال")),
                  ],
                ),
              ],
            ),
    );
  }
}
