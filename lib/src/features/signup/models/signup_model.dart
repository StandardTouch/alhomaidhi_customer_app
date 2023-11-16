class SignupModel {
  String? firstName;
  String? lastName;
  String? phoneNumber;
  String? email;
  bool isVerificationLoading;

  SignupModel(
      {this.firstName,
      this.lastName,
      this.phoneNumber,
      this.email,
      this.isVerificationLoading = false});

  SignupModel copyWith(
      {String? firstName,
      String? lastName,
      String? phoneNumber,
      String? email,
      bool? isVerificationLoading}) {
    return SignupModel(
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        email: email ?? this.email,
        isVerificationLoading: isVerificationLoading ?? false);
  }
}
