import 'package:logger/logger.dart';

class APIEndpoints {
  static const loginSendOtp = "/wp-json/alhomaidhiapp/v2/number_verification";
  static const loginVerifyOtp = "/wp-json/alhomaidhiapp/v2/otp_verification";
  static const verifyToken = "/wp-json/alhomaidhiapp/v2/token_verification";
  static const loginResendOtp = "/wp-json/alhomaidhiapp/v2/resend_otp_request";
  static getProducts(
      {required String? sortBy,
      required String? search,
      required int pageNo,
      required int productsPerPage}) {
    return "/wp-json/alhomaidhiapp/v2/list_products?sort_by=$sortBy&search=$search&page=$pageNo&per_page=$productsPerPage";
  }
}

// logger is used for error handling
final logger = Logger();
