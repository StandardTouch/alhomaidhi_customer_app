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

String? mobileNumberValidator(String? value) {
  if (value == null || value.isEmpty || value.trim().length != 9) {
    return 'Mobile number should be 9 digits long';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty || value.trim().length >= 100) {
    return 'Please enter a valid email address';
  } else if (!value.contains('@')) {
    return "Email must contain @";
  } else if (!value.contains('.')) {
    return "Email must contain .";
  } else {
    return null;
  }
}
