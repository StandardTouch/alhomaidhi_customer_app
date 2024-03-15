import 'package:Alhomaidhi/src/features/signup/models/signup_model.dart';
import 'package:Alhomaidhi/src/features/signup/models/signup_response.dart';
import 'package:Alhomaidhi/src/features/signup/services/signup_services.dart';
import 'package:Alhomaidhi/src/shared/widgets/top_snackbar.dart';
import 'package:Alhomaidhi/src/utils/constants/endpoints.dart';
import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
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
            message: TranslationHelper.translation(context)!
                .accountSuccessFullyCreated,
            type: SNACKBARTYPE.success,
          );
          context.go("/login");
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

        state = state.copyWith(isVerificationLoading: false);
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
      state = state.copyWith(isVerificationLoading: false);
    }
  }
}

final signUpProvider = StateNotifierProvider<SignUpNotifer, SignupModel>((ref) {
  return SignUpNotifer();
});
