import 'dart:async';

import 'package:Alhomaidhi/src/features/login/models/login_model.dart';
import 'package:Alhomaidhi/src/features/login/models/login_response.dart';
import 'package:Alhomaidhi/src/features/login/services/login_services.dart';
import 'package:Alhomaidhi/src/shared/providers/auth_provider.dart';
import 'package:Alhomaidhi/src/shared/widgets/top_snackbar.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
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

  void updateOtp(String? value) {
    state = state.copyWith(otp: value);
  }

// send otp start
  void sendOtp(GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState == null) {
      return;
    }
    try {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        state = state.copyWith(isButtonLoading: true);
        SendOtpResponseModel response =
            await sendLoginOtp(state.getPhoneNumber!);
        if (response.status == "DELAPP00") {
          state = state.copyWith(isOTPVisible: true, timerDuration: 10);
          startTimer();
        } else {
          if (!context.mounted) {
            return;
          }
          getSnackBar(
            context: context,
            message:
                "${TranslationHelper.translation(context)!.uhOhAnErrorOccurred}: ${response.message}",
            type: SNACKBARTYPE.error,
          );
        }
      }
    } catch (err) {
      if (!context.mounted) {
        return;
      }
      getSnackBar(
        context: context,
        message:
            TranslationHelper.translation(context)!.serverErrorPleaseTryLater,
        type: SNACKBARTYPE.error,
      );
    } finally {
      state = state.copyWith(isButtonLoading: false);
    }
  }

// send otp end

// verify otp start
  void verifyOtp(BuildContext context, WidgetRef ref) async {
    try {
      state = state.copyWith(isVerificationLoading: true);
      VerifyOtpResponseModel response =
          await verifyLoginOtp(state.getPhoneNumber!, state.otp!);
      if (response.status == "DELAPP00") {
        storage.write(key: "token", value: response.message!.token);
        storage.write(key: "userId", value: response.message!.userId);
        storage.write(
            key: "masterCustomerId", value: response.message!.masterCustomerId);
        storage.write(key: "username", value: response.message!.username);
        storage.write(key: "full_name", value: response.message!.fullName);
        ref.read(authProvider.notifier).logIn();

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
          // storing error message ion username variable
          message:
              "${TranslationHelper.translation(context)!.uhOhAnErrorOccurred}: ${response.message!.username}",
          type: SNACKBARTYPE.error,
        );
      }
    } catch (err) {
      getSnackBar(
        context: context,
        message: "$err",
        type: SNACKBARTYPE.error,
      );
    } finally {
      state = state.copyWith(
        isVerificationLoading: false,
        isOTPVisible: false,
        phoneNumber: "",
      );
      // fixed bug
    }
  }
  // verify otp end

  void startTimer() {
    const duration = Duration(seconds: 1);
    Timer.periodic(duration, (timer) {
      if (state.timerDuration == 0) {
        timer.cancel();
      } else {
        state = state.copyWith(timerDuration: (state.timerDuration! - 1));
        // timerDuration = timerDuration - 1;
      }
    });
  }

  // resend otp start
  void resendOtp(BuildContext context) async {
    try {
      state = state.copyWith(isResendLoading: true);
      SendOtpResponseModel response = await sendLoginOtp(state.getPhoneNumber!);
      if (response.status == "DELAPP00") {
        if (!context.mounted) {
          return;
        }
        getSnackBar(
          context: context,
          message: TranslationHelper.translation(context)!.otpIsSent,
          type: SNACKBARTYPE.success,
        );
        // start timer for resending otp
        state = state.copyWith(timerDuration: 30);
        startTimer();
      } else {
        if (!context.mounted) {
          return;
        }
        getSnackBar(
          context: context,
          message:
              "${TranslationHelper.translation(context)!.uhOhAnErrorOccurred}: ${response.message}",
          type: SNACKBARTYPE.error,
        );
      }
      state = state.copyWith(isResendLoading: false);
    } catch (err) {
      if (!context.mounted) {
        return;
      }
      getSnackBar(
        context: context,
        message:
            TranslationHelper.translation(context)!.serverErrorPleaseTryLater,
        type: SNACKBARTYPE.error,
      );
      state = state.copyWith(isResendLoading: false);
    }
  }
  // resend otp end
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginModel>((ref) {
  return LoginNotifier();
});
