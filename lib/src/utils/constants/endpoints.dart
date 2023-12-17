import 'package:logger/logger.dart';

class APIEndpoints {
  static const loginSendOtp = "/wp-json/alhomaidhiapp/v2/number_verification";
  static const loginVerifyOtp = "/wp-json/alhomaidhiapp/v2/otp_verification";
  static const verifyToken = "/wp-json/alhomaidhiapp/v2/token_verification";
  static const loginResendOtp = "/wp-json/alhomaidhiapp/v2/resend_otp_request";

  static const getProducts = "/wp-json/alhomaidhiapp/v2/list_products";

  static const getBrands = "/wp-json/alhomaidhiapp/v2/retrieve_brands";
  static const registerUser = "/wp-json/alhomaidhiapp/v2/alhomapp_signup";
  static const myOrders = "/wp-json/alhomaidhiapp/v2/list_orders";
  static const getSingleOrder = "/wp-json/alhomaidhiapp/v2/retrieve_order";
  static const getSingleProduct = "/wp-json/alhomaidhiapp/v2/retrieve_product";
  static const getCart = "/wp-json/alhomaidhiapp/v2/retrieve_cart";
}

// logger is used for error handling
final logger = Logger();
