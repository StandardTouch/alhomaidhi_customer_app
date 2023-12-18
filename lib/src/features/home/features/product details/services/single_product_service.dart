import 'package:alhomaidhi_customer_app/src/features/home/features/product%20details/models/single_product_model.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';
import 'package:dio/dio.dart';

Future<SingleProductModel> getProductDetails(String productId) async {
  try {
    final authDetails = await AuthHelper.getAuthDetails();
    final jsonResponse = await dioClient.get(APIEndpoints.getSingleProduct,
        options: Options(
          headers: {
            "Authorization": authDetails.token,
            "user_id": authDetails.userId,
          },
        ),
        queryParameters: {
          "product_id": productId,
        });
    final response = SingleProductModel.fromJson(jsonResponse.data);
    if (response.status != "APP00") {
      throw HomaidhiException(
          status: response.status!, message: response.errorMessage!);
    } else {
      return response;
    }
  } catch (err) {
    logger.e("Error from sendLoginOtp: $err");
    if (err is HomaidhiException) {
      throw HomaidhiException(
        status: err.status,
        message: err.message,
      );
    } else {
      throw Exception(err);
    }
  }
}
