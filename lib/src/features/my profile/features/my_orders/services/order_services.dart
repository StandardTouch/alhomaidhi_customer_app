import 'package:Alhomaidhi/src/features/my%20profile/features/my_orders/models/my_orders_list_model.dart';
import 'package:Alhomaidhi/src/utils/config/dio/dio_client.dart';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:Alhomaidhi/src/utils/helpers/auth_helper.dart';
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
    return response;
  } catch (err) {
    logger.e("Error from getMyOrders: $err");
    throw Exception("$err");
  }
}
