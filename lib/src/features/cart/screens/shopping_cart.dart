import 'package:alhomaidhi_customer_app/src/features/cart/providers/my_cart_provider.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
        return const Center(
          child: Text("Data found"),
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
