import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/my_orders/models/my_orders_list_model.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<MyOrdersListModel> getMyOrders() async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: "token");
  final userId = await storage.read(key: "userId");
  try {
    final jsonResponse = await dioClient.get(APIEndpoints.myOrders,
        options: Options(headers: {
          "Authorization":
              "1592276139jRzNFQLTqUScUiI2m9qpjeYkLxzjVlKFVXxzkQWmqDN6t4iQJc",
          "user_id": 40,
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
