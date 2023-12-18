import 'package:alhomaidhi_customer_app/src/features/cart/providers/my_cart_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/cart/widgets/single_cart_item.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:intl/intl.dart';

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
          padding: const EdgeInsets.all(10),
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
            ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: data.message!.cart!.length,
              itemBuilder: (ctx, index) {
                return SingleCartItem(
                  productImage: data
                      .message!.cart![index].productDetails!.images![0].src!,
                  productName: data.message!.cart![index].productDetails!.name!,
                  productQuantity: data.message!.cart![index].quantity!,
                  itemTotal: data.message!.cart![index].lineTotal!,
                );
              },
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
