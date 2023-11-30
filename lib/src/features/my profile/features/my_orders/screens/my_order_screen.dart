import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/providers/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyOrderScreen extends ConsumerWidget {
  const MyOrderScreen({super.key});
  // @Zaid - add your code here
  // @Zaid - Create screens if required
  // @Zaid - add API integration for my order details screen
  // @Zaid - Assign widget design to maaz if required

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myOrders = ref.watch(MyOrdersProvider);
    return myOrders.when(data: (data) {
      if (data.status == "APP00") {
        return Center(
          child: Text(data.message![0].productDetails!.catalogVisibility!),
        );
      } else {
        return Center(
          child: Text(data.errorMessage!),
        );
      }
    }, error: (err, stk) {
      return Center(
        child: Text("$err"),
      );
    }, loading: () {
      return Center(
        child: const CircularProgressIndicator(),
      );
    });
  }
}
