import 'package:alhomaidhi_customer_app/src/features/cart/providers/my_cart_provider.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:input_quantity/input_quantity.dart';

class ShoppingCartScreen extends ConsumerStatefulWidget {
  const ShoppingCartScreen({super.key});

  @override
  ConsumerState<ShoppingCartScreen> createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends ConsumerState<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(myCartProvider);
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text("My Cart"),
      ),
      body: cart.when(data: (data) {
        return ListView(
          padding: EdgeInsets.all(10),
          shrinkWrap: true,
          children: [
            Text(
              "Delivered to: Mr Hamzah Mauzam.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const Gap(5),
            Text(
              "Customer Address. KSA",
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.normal,
                  ),
            ),
            const Gap(5),
            Container(
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
                        child: Image.network(data
                            .message!.cart![0].productDetails!.images![0].src!),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            FittedBox(
                              child: Text(
                                  data.message!.cart![0].productDetails!.name!),
                            ),
                            const Gap(5),
                            // quantity field
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                InputQty(
                                  initVal: data.message!.cart![0].quantity!,
                                  qtyFormProps:
                                      const QtyFormProps(enableTyping: false),

                                  maxVal:
                                      10, // todo - addd stock quantity as max value
                                  steps: 1,
                                  minVal: 1,
                                  onQtyChanged: (value) {
                                    // todo - implement update cart API
                                  },
                                  decoration: QtyDecorationProps(
                                    btnColor: Theme.of(context).primaryColor,
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                      color: Colors.black,
                                    )),
                                    // borderShape: BorderShapeBtn.circle,
                                    contentPadding: const EdgeInsets.all(2),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(
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
                      Text(
                        "Delivered by date",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text("${data.message!.cart![0].lineTotal!} ريال")
                    ],
                  ),
                ],
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
