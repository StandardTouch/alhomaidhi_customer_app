import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/models/my_order_details_models.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<MyOrderDetailsModels> getMyOrderDetails(String? orderId) async {
  final authDetails = await AuthHelper.getAuthDetails();
  print('this is orderid $orderId');
  String cleanOrderId(String? orderId) {
    return orderId!.replaceFirst(
        '#', ''); // Removes the first occurrence of '#' from the string
  }

  String? cleanedOrderId = cleanOrderId(orderId);
  print('this is cleanedorderid $cleanedOrderId');
  try {
    final jsonResponse = await dioClient.get(APIEndpoints.getSingleOrder,
        options: Options(headers: {
          "Authorization": authDetails.token,
          "user_id": authDetails.userId,
        }),
        queryParameters: {'order_id': cleanedOrderId});
    final response = MyOrderDetailsModels.fromJson(
      jsonResponse.data,
    );

    print(jsonResponse);
    return response;
  } catch (err) {
    logger.e("Error from getMyOrders: $err");
    throw Exception("$err");
  }
}
