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
  static const getMyInvoice = "/api/runReport/26";
  static const getSingleProduct = "/wp-json/alhomaidhiapp/v2/retrieve_product";
  static const getCart = "/wp-json/alhomaidhiapp/v2/retrieve_cart";
  static const getProfile = "/wp-json/alhomaidhiapp/v2/get_profile";
  static const updateProfile = "/wp-json/alhomaidhiapp/v2/update_profile";
  static const deleteProfile = "/wp-json/alhomaidhiapp/v2/deactivate_profile";
  static const updateCartItems = "/wp-json/alhomaidhiapp/v2/cart_update";
  static const deleteCartItems = "/wp-json/alhomaidhiapp/v2/delete_cart";
  static const getPreCheckoutToken = "/wp-json/api/v1/mo-jwt";
  static const updateCredentials =
      "/wp-json/alhomaidhiapp/v2/update_credentials";
  static const sendFcmToken = "/wp-json/alhomaidhiapp/v2/notification_token";
}

// logger is used for logging errors
final logger = Logger();
