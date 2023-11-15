class SignupModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  bool isButtonLoading;
  bool isVerificationLoading;

  SignupModel(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.isButtonLoading = false,
      this.isVerificationLoading = false});

  set setIsRegisterBtnLoading(bool isLoading) {
    isButtonLoading = isLoading;
  }

  SignupModel copyWith(
      {String? firstName,
      String? lastName,
      String? phoneNumber,
      String? email,
      bool? isButtonLoading,
      bool? isVerificationLoading}) {
    return SignupModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        isButtonLoading: isButtonLoading ?? false,
        isVerificationLoading: isVerificationLoading ?? false);
  }
}
