import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/providers/orders_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/widgets/single_order_details.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/device_info.dart';
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

        return Scaffold(
            appBar: AppBar(
              title: const Text('Orders Details'),
              backgroundColor: Colors.transparent,
            ),
            backgroundColor: Colors.transparent,
            body: Container(
                margin: const EdgeInsets.only(top: 20),
                // padding: const EdgeInsets.only(top: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleOrderDetails()));
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
