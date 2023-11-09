import 'package:alhomaidhi_customer_app/src/features/login/models/login_model.dart';
import 'package:alhomaidhi_customer_app/src/features/login/models/login_response.dart';
import 'package:alhomaidhi_customer_app/src/features/login/services/login_services.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/top_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

class LoginNotifier extends StateNotifier<LoginModel> {
  final storage = const FlutterSecureStorage();
  LoginNotifier() : super(LoginModel());

  void updatephoneNumber(String? value) {
    state = state.copyWith(phoneNumber: value);
  }

// send otp start
  void sendOtp(GlobalKey<FormState> _formKey, BuildContext context) async {
    if (_formKey.currentState == null) {
      return;
    }
    try {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        state = state.copyWith(isButtonLoading: true);
        SendOtpResponseModel response =
            await sendLoginOtp(state.getPhoneNumber!);
        if (response.status == "DELAPP00") {
          state = state.copyWith(isOTPVisible: true);
        } else {
          if (!context.mounted) {
            return;
          }
          getSnackBar(
            context: context,
            message: "Uh Oh. An error occurred: ${response.message}",
            type: SNACKBARTYPE.error,
          );
        }
        state = state.copyWith(isButtonLoading: false);
      }
    } catch (err) {
      if (!context.mounted) {
        return;
      }
      getSnackBar(
        context: context,
        message: "Server Error: Please try again later",
        type: SNACKBARTYPE.error,
      );
      state = state.copyWith(isButtonLoading: false);
    }
  }

// send otp end

// verify otp start
  void verifyOtp(BuildContext context, String? otp) async {
    try {
      state = state.copyWith(isButtonLoading: true);
      VerifyOtpResponseModel response =
          await verifyLoginOtp(state.getPhoneNumber!, otp!);
      if (response.status == "DELAPP00") {
        storage.write(key: "token", value: response.message!.token);
        storage.write(key: "userId", value: response.message!.userId);
        if (!context.mounted) {
          return;
        }
        context.go("/home");
      } else {
        if (!context.mounted) {
          return;
        }
        getSnackBar(
          context: context,
          message: "Uh Oh. An error occurred: ${response.message}",
          type: SNACKBARTYPE.error,
        );
      }
      state = state.copyWith(isButtonLoading: false);
    } catch (err) {
      getSnackBar(
        context: context,
        message: "$err",
        type: SNACKBARTYPE.error,
      );
      state = state.copyWith(isButtonLoading: false);
    }
  }
  // verify otp end
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginModel>((ref) {
  return LoginNotifier();
});
