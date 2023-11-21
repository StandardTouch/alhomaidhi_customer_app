import 'package:alhomaidhi_customer_app/src/features/home/models/all_products_response.dart';
import 'package:alhomaidhi_customer_app/src/features/home/models/brand_response.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';
import 'package:dio/dio.dart';

Future<BrandResponse> getAllBrands() async {
  try {
    final userDetails = await AuthHelper.getAuthDetails();
    final jsonResponse = await dioClient.get(APIEndpoints.getBrands,
        options: Options(headers: {
          "Authorization": userDetails.token,
          "user_id": userDetails.userId,
        }));
    final response = BrandResponse.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("Error from getAllBrands: $err");
    throw Exception("$err");
  }
}
