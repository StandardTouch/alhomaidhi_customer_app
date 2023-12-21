import 'package:alhomaidhi_customer_app/src/features/my%20profile/features/delete_profile/models/delete_profile_request_model.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';

Future<DeleteProfileRequestResponseModel> deleteProfileRequest() async {
  final authDetails = await AuthHelper.getAuthDetails();
  try {
    final jsonResponse = await dioClient.post(APIEndpoints.deleteProfile,
        options: Options(headers: {
          "Authorization": authDetails.token,
          "user_id": authDetails.userId,
        }));
    final response =
        DeleteProfileRequestResponseModel.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("Error from address $err");
    throw Exception("$err");
  }
}
