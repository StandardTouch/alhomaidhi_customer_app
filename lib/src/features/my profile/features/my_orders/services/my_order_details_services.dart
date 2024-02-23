import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/models/my_order_details_models.dart';
import 'package:Alhomaidhi/src/utils/config/dio/dio_client.dart';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:Alhomaidhi/src/utils/helpers/auth_helper.dart';
import 'package:dio/dio.dart';

Future<MyOrderDetailsModels> getMyOrderDetails(String? orderId) async {
  final authDetails = await AuthHelper.getAuthDetails();
  String cleanOrderId(String? orderId) {
    return orderId!.replaceFirst('#', '');
  }

  String? cleanedOrderId = cleanOrderId(orderId);

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
    return response;
  } catch (err) {
    logger.e("Error from getMyOrders: $err");

    throw Exception("$err");
  }
}
