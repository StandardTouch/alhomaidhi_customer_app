import 'package:alhomaidhi_customer_app/src/features/login/models/send%20otp/send_otp_response.dart';
import 'package:alhomaidhi_customer_app/src/features/login/services/send_login_otp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final sendLoginOtpProvider =
    FutureProvider.family<SendOtpResponseModel, String>(
  (ref, phoneNumber) async {
    final response = await sendLoginOtp(phoneNumber);
    return response;
  },
);
