import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/models/address_request_model.dart';
import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/address/models/address_response_model.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';

Future<AddressResponseModel> getProfileDetails() async {
  final authDetails = await AuthHelper.getAuthDetails();
  try {
    final jsonResponse = await dioClient.get(APIEndpoints.getProfile,
        options: Options(headers: {
          "Authorization": authDetails.token,
          "user_id": authDetails.userId,
        }));
    logger.i(jsonResponse);
    final response = AddressResponseModel.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("from address screen:  $err");
    throw Exception("$err");
  }
}

Future<AddressRequestResponseModel> updateProfileDetails(Object data) async {
  final authDetails = await AuthHelper.getAuthDetails();
  try {
    final jsonResponse = await dioClient.post(APIEndpoints.updateProfile,
        data: data,
        options: Options(headers: {
          "Authorization": authDetails.token,
          "user_id": authDetails.userId,
        }));
    final response = AddressRequestResponseModel.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("Error from address $err");
    throw Exception("$err");
  }
}
