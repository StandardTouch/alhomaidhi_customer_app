import 'package:alhomaidhi_customer_app/src/features/home/features/all%20products/models/all_products_response.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';
import 'package:dio/dio.dart';

Future<AllProductsResponse> getAllProducts({
  required int pageNo,
  String? search,
  String? sortBy,
  int? brandId,
}) async {
  try {
    final userDetails = await AuthHelper.getAuthDetails();
    final jsonResponse = await dioClient.get(
        // APIEndpoints.getProducts(
        //   sortBy: sortBy,
        //   search: search,
        //   pageNo: pageNo,
        //   productsPerPage: 100,
        //   brandFilter: brandId,
        // ),
        APIEndpoints.getProducts,
        options: Options(
          headers: {
            "Authorization": userDetails.token,
            "user_id": userDetails.userId,
          },
        ),
        queryParameters: {
          "sort_by": sortBy,
          "search": search,
          "page": pageNo,
          "per_page": 100,
          "brand_filter": brandId,
        });
    final response = AllProductsResponse.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("Error from getAllProducts: $err");
    throw Exception("$err");
  }
}
