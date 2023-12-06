import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyOrderDetailsScreen extends ConsumerWidget {
  const MyOrderDetailsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myOrderDetail = ref.watch(MyOrderDetailsProvider);
    return myOrderDetail.when(data: (data) {
      if (data.status == "APP00") {
        // logger.i(data.message!.toString());
        return Center(
          child: Text(data.message!.orderDetails!.cartTax!),
        );
      } else {
        return const Center(
          child: Text("data.errorMessage!"),
        );
      }
    }, error: (err, stk) {
      return Center(
        child: Text("$err"),
      );
    }, loading: () {
      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
