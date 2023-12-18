import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/providers/orders_provider.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/services/my_order_details_services.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/widgets/single_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class MyOrderScreen extends ConsumerWidget {
  const MyOrderScreen({super.key});
  String getDeliveryDate(orderPlaceDate, orderModifiedDate, orderStatus) {
    DateTime placedDate = DateTime.parse(orderPlaceDate);
    DateTime modifiedDate = DateTime.parse(orderModifiedDate);
    String status = orderStatus;

    String formatDate(DateTime dateTime) {
      return DateFormat('EEE MMM d').format(dateTime);
    }

    DateTime deliveryDate = placedDate.add(const Duration(days: 5));
    if (status == 'wc-processing') {
      return "To be delivered on, ${formatDate(deliveryDate)}";
    } else if (status == 'wc-completed') {
      return "Delivered on, ${formatDate(modifiedDate)}";
    } else {
      return "To be delivered on, ${formatDate(deliveryDate)}";
    }
  }

  String formatDate(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final myOrders = ref.watch(myOrdersListProvider);

    return myOrders.when(
      data: (data) {
        if (data.status == "APP00") {
          return Scaffold(
            appBar: AppBar(
              title: const Text('My Orders'),
              forceMaterialTransparency: true,
            ),
            backgroundColor: Colors.transparent,
            body: Container(
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).highlightColor,
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
              child: ListView.builder(
                itemCount: data.message!.length,
                itemBuilder: (context, index) {
                  String? orderStatusDate = getDeliveryDate(
                      data.message![index].orderDetails!.orderPlacedDate,
                      data.message![index].orderDetails!.orderDateModified,
                      data.message![index].orderDetails!.orderStatus);
                  String? orderId = data.message![index].orderDetails!.orderId;

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.message![index].items!.length,
                    itemBuilder: (context, indexItem) {
                      var item = data.message![index].items![indexItem];
                      return SingleOrderCard(
                        imageUrl: item.image,
                        title: orderStatusDate,
                        subtitle: item.itemName ?? 'No Title',
                        orderStatus:
                            data.message![index].orderDetails!.orderStatus,
                        onPressed: () {
                          getMyOrderDetails(orderId);
                          context
                              .pushNamed("my_order_details", pathParameters: {
                            "orderId": orderId!,
                            "productIndex": "$indexItem",
                          });
                        },
                      );
                    },
                  );
                },
              ),
            ),
          );
        } else {
          return Center(
            child: Text(data.errorMessage ?? 'Unknown error'),
          );
        }
      },
      error: (err, stk) => Center(child: Text("$err")),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
