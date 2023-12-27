import 'package:alhomaidhi_customer_app/src/features/cart/providers/my_cart_provider.dart';
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
  });
  final String productImage;
  final String productName;
  final String productQuantity;
  final int itemTotal;
  final int stockQty;
  final int productId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(cartDetailsProvider);
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
      child: Column(
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
                        InputQty(
                          initVal: int.parse(productQuantity),
                          qtyFormProps: const QtyFormProps(enableTyping: false),

                          maxVal: 100, // todo - add stock quantity as max value
                          steps: 1,
                          minVal: 1,
                          onQtyChanged: (value) {
                            cartOperations.updateCartItem(
                              productId,
                              value as int,
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
                            onPressed: () {},
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.grey,
                            ))
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
              Text("$itemTotal ريال"),
            ],
          ),
        ],
      ),
    );
  }
}
