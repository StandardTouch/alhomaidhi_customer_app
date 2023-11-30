import 'package:logger/logger.dart';

class APIEndpoints {
  static const loginSendOtp = "/wp-json/alhomaidhiapp/v2/number_verification";
  static const loginVerifyOtp = "/wp-json/alhomaidhiapp/v2/otp_verification";
  static const verifyToken = "/wp-json/alhomaidhiapp/v2/token_verification";
  static const loginResendOtp = "/wp-json/alhomaidhiapp/v2/resend_otp_request";
  static const registerUser = "/wp-json/alhomaidhiapp/v2/alhomapp_signup";
  static const myOrders = "/wp-json/alhomaidhiapp/v2/list_products";
}

// logger is used for error handling
final logger = Logger();
