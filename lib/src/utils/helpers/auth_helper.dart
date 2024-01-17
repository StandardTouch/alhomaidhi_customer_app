import 'package:alhomaidhi_customer_app/src/shared/models/auth_model.dart';
import 'package:alhomaidhi_customer_app/src/shared/services/auth_service.dart';
import 'package:alhomaidhi_customer_app/src/utils/exceptions/homaidhi_exception.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthDetails {
  final String? token;
  final String? userId;
  final String? masterCustomerId;
  final String? userName;
  AuthDetails({
    required this.token,
    required this.userId,
    required this.masterCustomerId,
    required this.userName,
  });
}

class AuthHelper {
  static Future<bool> isUserLoggedIn() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    final userId = await storage.read(key: "userId");
    try {
      AuthResponseModel response =
          await verifyToken(token ?? "notoken", userId ?? "0");
      if (response.status == "DELAPP00") {
        return true;
      } else {
        return false;
      }
    } catch (err) {
      if (err is HomaidhiException) {
        throw HomaidhiException(status: err.status, message: err.message);
      } else {
        throw Exception(err);
      }
    }
  }

  static Future<AuthDetails> getAuthDetails() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    final userId = await storage.read(key: "userId");
    final masterCustomerId = await storage.read(key: 'masterCustomerId');
    final username = await storage.read(key: "username");
    AuthDetails authDetails = AuthDetails(
      token: token,
      userId: userId,
      masterCustomerId: masterCustomerId,
      userName: username,
    );
    return authDetails;
  }
}
