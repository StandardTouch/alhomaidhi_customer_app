import 'package:alhomaidhi_customer_app/src/features/login/models/send%20otp/send_otp_response.dart';
import 'package:alhomaidhi_customer_app/src/utils/config/dio/dio_client.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';

Future<SendOtpResponseModel> sendLoginOtp(String phoneNumber) async {
  try {
    final jsonResponse = await dioClient.post(
      APIEndpoints.loginSendOtp,
      data: {"phone_number": phoneNumber},
    );
    final response = SendOtpResponseModel.fromJson(jsonResponse.data);
    return response;
  } catch (err) {
    throw Exception("Error from send_login_otp.dart: $err");
  }
}
