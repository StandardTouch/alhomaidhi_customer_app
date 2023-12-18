import 'package:logger/logger.dart';

class APIEndpoints {
  static const loginSendOtp = "/wp-json/alhomaidhiapp/v2/number_verification";
  static const loginVerifyOtp = "/wp-json/alhomaidhiapp/v2/otp_verification";
  static const verifyToken = "/wp-json/alhomaidhiapp/v2/token_verification";
  static const loginResendOtp = "/wp-json/alhomaidhiapp/v2/resend_otp_request";
  // static getProducts({
  //   required String? sortBy,
  //   required String? search,
  //   required int pageNo,
  //   required int productsPerPage,
  //   required String? brandFilter,
  // }) {
  //   return "/wp-json/alhomaidhiapp/v2/list_products?sort_by=$sortBy&search=$search&page=$pageNo&per_page=$productsPerPage&brand_filter=$brandFilter";
  // }
  static const getProducts = "/wp-json/alhomaidhiapp/v2/list_products";

  static const getBrands = "/wp-json/alhomaidhiapp/v2/retrieve_brands";
  static const registerUser = "/wp-json/alhomaidhiapp/v2/alhomapp_signup";
  static const myOrders = "/wp-json/alhomaidhiapp/v2/list_orders";
  static const getSingleOrder = "/wp-json/alhomaidhiapp/v2/retrieve_order";
  static const getProfile = "/wp-json/alhomaidhiapp/v2/get_profile";
  static const updateProfile = "/wp-json/alhomaidhiapp/v2/update_profile";
}

// logger is used for error handling
final logger = Logger();
