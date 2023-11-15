import 'package:alhomaidhi_customer_app/src/features/signup/models/signup_model.dart';
import 'package:alhomaidhi_customer_app/src/features/signup/models/signup_response.dart';
import 'package:alhomaidhi_customer_app/src/features/signup/services/signup_services.dart';
import 'package:alhomaidhi_customer_app/src/shared/widgets/top_snackbar.dart';
import 'package:alhomaidhi_customer_app/src/utils/constants/endpoints.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpNotifer extends StateNotifier<SignupModel> {
  SignUpNotifer() : super(SignupModel());

  void updateFistname(String? value) {
    state = state.copyWith(firstName: value);
  }

  void updateLastName(String? value) {
    state = state.copyWith(lastName: value);
  }

  void updatephoneNumber(String? value) {
    state = state.copyWith(phoneNumber: value);
  }

  void updateEmail(String? value) {
    state = state.copyWith(email: value);
  }

  // register a new user
  void registerUser(GlobalKey<FormState> formkey, BuildContext context) async {
    if (formkey.currentState == null) {
      return;
    }
    try {
      if (formkey.currentState!.validate()) {
        formkey.currentState!.save();

        state = state.copyWith(isVerificationLoading: true);
        Object data = {
          "first_name": state.firstName,
          "last_name": state.lastName,
          "phone": state.phoneNumber,
          "email": state.email
        };
        SignupResponseModel response = await registerNewUser(data);
        logger.e(response);
        if (response.status == "APP000") {
          if (!context.mounted) {
            return;
          }
          getSnackBar(
            context: context,
            message: "Account successfully created",
            type: SNACKBARTYPE.success,
          );
          context.go("/login");
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
        state = state.copyWith(isVerificationLoading: false);
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
}

final signUpProvider = StateNotifierProvider<SignUpNotifer, SignupModel>((ref) {
  return SignUpNotifer();
});
