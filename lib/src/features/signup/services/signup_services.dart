import 'package:Alhomaidhi/src/features/signup/models/signup_response.dart';
import 'package:Alhomaidhi/src/utils/config/dio/dio_client.dart';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<SignupResponseModel> registerNewUser(Object data) async {
  try {
    final jsonResponse = await dioClient.post(APIEndpoints.registerUser,
        data: data,
        options:
            Options(headers: {"Authorization": dotenv.env["SIGNUP_TOKEN"]}));
    final response = SignupResponseModel.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("Error from User Registration $err");
    throw Exception("$err");
  }
}
