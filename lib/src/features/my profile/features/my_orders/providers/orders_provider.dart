import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/models/my_order_details_models.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/models/my_orders_list_model.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/services/my_order_details_services.dart';
import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/services/order_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myOrdersListProvider = FutureProvider<MyOrdersListModel>((ref) async {
  MyOrdersListModel response = await getMyOrders();
  return response;
});

final myOrderDetailsProvider =
    FutureProvider.family<MyOrderDetailsModels, String>((ref, orderId) async {
  return await getMyOrderDetails(orderId);
});
