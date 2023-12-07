import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/models/my_order_details_models.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/models/my_orders_model.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/services/my_order_details_services.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/services/order_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final MyOrdersProvider = FutureProvider<MyOrdersModel>((ref) async {
  MyOrdersModel response = await getMyOrders();
  return response;
});

final MyOrderDetailsProvider =
    FutureProvider<MyOrderDetailsModels>((ref) async {
  MyOrderDetailsModels response = await getMyOrderDetails();
  return response;
});
