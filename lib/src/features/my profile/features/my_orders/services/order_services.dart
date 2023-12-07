import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/models/my_orders_list_model.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';
import 'package:dio/dio.dart';

Future<MyOrdersListModel> getMyOrders() async {
  final authDetails = await AuthHelper.getAuthDetails();
  try {
    final jsonResponse = await dioClient.get(APIEndpoints.myOrders,
        options: Options(headers: {
          "Authorization": authDetails.token,
          "user_id": authDetails.userId,
        }));
    final response = MyOrdersListModel.fromJson(
      jsonResponse.data,
    );
    logger.i(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("Error from getMyOrders: $err");
    throw Exception("$err");
  }
}
