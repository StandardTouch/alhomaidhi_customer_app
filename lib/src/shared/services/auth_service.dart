import 'dart:io';

import 'package:alhomaidhi_customer_app/src/shared/models/auth_model.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:alhomaidhi_customer_app/src/utils/helpers/auth_helper.dart';
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

Future<Map<String, dynamic>> getPreCheckoutToken(
    String userName, String password) async {
  try {
    final response = await dioClient.post(
      APIEndpoints.getPreCheckoutToken,
      data: {
        "username": userName,
        "password": password,
      },
    );
    if (response.statusCode == HttpStatus.ok) {
      return response.data;
    } else {
      throw HomaidhiException(status: "APP122", message: "Invalid credentials");
    }
  } on DioException catch (err) {
    logger.e("Invalid Credentials Passed", error: err);
    throw DioException(requestOptions: err.requestOptions);
  }
}

Future<Map<String, dynamic>> getCredentials() async {
  try {
    final authDetails = await AuthHelper.getAuthDetails();
    final response = await dioClient.get(
      APIEndpoints.getCredentials,
      options: Options(
        headers: {
          "Authorization": authDetails.token,
          "user_id": authDetails.userId,
        },
      ),
    );
    if (response.statusCode == HttpStatus.ok) {
      if (response.data["status"] == "APP00") {
        return {
          "username": authDetails.userName,
          "password": response.data["message"],
        };
      } else {
        throw DioException(requestOptions: response.requestOptions);
      }
    } else {
      throw DioException(
        requestOptions: response.requestOptions,
      );
    }
  } on DioException catch (err) {
    logger.e("Something Seems to be wrong", error: err);
    throw DioException(requestOptions: err.requestOptions);
  }
}
