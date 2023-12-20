String? firstNameValidator(String? value) {
  if (value == null ||
      value.isEmpty ||
      value.trim().length <= 1 ||
      value.trim().length > 50) {
    return 'Must be between 1 and 50 characters long';
  }
  return null;
}

String? lastNameValidator(String? value) {
  if (value == null ||
      value.isEmpty ||
      value.trim().length <= 1 ||
      value.trim().length > 20) {
    return 'Must be between 1 and 20 characters long';
  }
  return null;
}

// todo - change validator to limit 9 before production
String? mobileNumberValidator(String? value) {
  if (value == null || value.isEmpty || value.trim().length != 10) {
    return 'Mobile number should be 9 digits long';
  }
  return null;
}

String? emailValidator(String? value) {
  final bool isEmailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value!);
  if (value == null ||
      value.isEmpty ||
      value.trim().length >= 100 ||
      isEmailValid == false) {
    return 'Please enter a valid email address';
  } else {
    return null;
  }
}

String? pinCodeValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a valid pincode';
  }
  return null;
}
