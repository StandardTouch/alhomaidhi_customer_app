import 'package:alhomaidhi_customer_app/src/shared/models/auth_model.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';

Future<AuthResponseModel> verifyToken(String token, String userId) async {
  try {
    final jsonResponse = await dioClient.post(
      APIEndpoints.verifyToken,
      data: {
        "token": token,
        "user_id": userId,
      },
    );
    final response = AuthResponseModel.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("Error from auth_service.dart: $err");
    throw Exception("$err");
  }
}
