import 'package:Alhomaidhi/src/utils/helpers/auth_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<bool> {
  AuthNotifier() : super(false); // The initial state is 'not logged in'

  // Method to check user authentication
  Future<void> checkUserAuth() async {
    final isLoginResponse = await AuthHelper.checkUserAuth();
    state = isLoginResponse; // Update the state
  }

  void logIn() {
    state = true; // User is logged in
  }

  void logOut() {
    state = false; // User is logged out
}
}

// Define a provider for AuthNotifier
final authProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  return AuthNotifier();
});
