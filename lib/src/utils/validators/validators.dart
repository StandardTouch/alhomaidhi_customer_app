import 'package:Alhomaidhi/src/utils/helpers/translation_helper.dart';
import 'package:flutter/material.dart';

String? firstNameValidator(BuildContext context, String? value) {
  if (value == null ||
      value.isEmpty ||
      value.trim().length <= 1 ||
      value.trim().length > 50) {
    return TranslationHelper.translation(context)!.firstNameValidator;
  }
  return null;
}

String? lastNameValidator(BuildContext context, String? value) {
  if (value == null ||
      value.isEmpty ||
      value.trim().length <= 1 ||
      value.trim().length > 20) {
    return TranslationHelper.translation(context)!.lastNameValidator;
  }
  return null;
}

// todo - change validator to limit 9 before production
String? mobileNumberValidator(BuildContext context, String? value) {
  if (value == null || value.isEmpty || value.trim().length != 9) {
    return TranslationHelper.translation(context)!.mobileNumberValidator;
  }
  return null;
}

String? emailValidator(BuildContext context, String? value) {
  if (value == null || value.isEmpty || value.trim().length >= 100) {
    return TranslationHelper.translation(context)!.emailValidator;
  } else if (!value.contains('@')) {
    return TranslationHelper.translation(context)!.emailValidator;
  } else if (!value.contains('.')) {
    return TranslationHelper.translation(context)!.emailValidator;
  } else {
    return null;
  }
}

String? pinCodeValidator(BuildContext context, String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a valid pincode';
  }
  return null;
}
