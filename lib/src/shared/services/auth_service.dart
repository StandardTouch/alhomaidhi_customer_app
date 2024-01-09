import 'package:alhomaidhi_customer_app/src/shared/models/auth_model.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:dio/dio.dart';

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
    logger.d(response);
    return response;
  } catch (err) {
    if (err is DioException) {
      logger.e("Error exception type: ${err.type}");
      if (err.type ==
              DioExceptionType
                  .connectionError || //no internet = connection error
          err.type == DioExceptionType.cancel ||
          err.type == DioExceptionType.connectionTimeout) {
        throw HomaidhiException(status: "NONET", message: "No Net");
        // todo:  show screen
      }
    }
    logger.e("Error from auth_service.dart: $err");
    throw Exception("$err");
  }
}
