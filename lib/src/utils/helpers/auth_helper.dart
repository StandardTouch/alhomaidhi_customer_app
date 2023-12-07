import 'package:alhomaidhi_customer_app/src/shared/models/auth_model.dart';
import 'package:alhomaidhi_customer_app/src/shared/services/auth_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthDetails {
  final String? token;
  final String? userId;
  AuthDetails({required this.token, required this.userId});
}

class AuthHelper {
  static Future<bool> isUserLoggedIn() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    final userId = await storage.read(key: "userId");
    AuthResponseModel response =
        await verifyToken(token ?? "notoken", userId ?? "0");
    if (response.status == "DELAPP00") {
      return true;
    } else {
      return false;
    }
  }

  static Future<AuthDetails> getAuthDetails() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: "token");
    final userId = await storage.read(key: "userId");
    AuthDetails authDetails = AuthDetails(token: token, userId: userId);
    return authDetails;
  }
}
