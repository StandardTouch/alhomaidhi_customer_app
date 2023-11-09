import 'package:alhomaidhi_customer_app/src/features/login/models/login_response.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';

// send login otp

Future<SendOtpResponseModel> sendLoginOtp(String phoneNumber) async {
  try {
    final jsonResponse = await dioClient.post(
      APIEndpoints.loginSendOtp,
      data: {"phone_number": phoneNumber},
    );
    final response = SendOtpResponseModel.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("Error from sendLoginOtp: $err");
    throw Exception("$err");
  }
}

// verify login otp
Future<VerifyOtpResponseModel> verifyLoginOtp(
    String phoneNumber, String otp) async {
  try {
    final jsonResponse = await dioClient.post(
      APIEndpoints.loginVerifyOtp,
      data: {
        "phone_number": phoneNumber,
        "otp_code": otp,
      },
    );
    final response = VerifyOtpResponseModel.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("Error from verifyLoginOtp: $err");
    throw Exception("$err");
  }
}

// resend login otp
Future<SendOtpResponseModel> resendLoginOtp(String phoneNumber) async {
  try {
    final jsonResponse = await dioClient.post(
      APIEndpoints.loginResendOtp,
      data: {"phone_number": phoneNumber},
    );
    final response = SendOtpResponseModel.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    logger.e("Error from resendLoginOtp: $err");
    throw Exception("$err");
  }
}
