class LoginModel {
  String? phoneNumber;
  bool isButtonLoading;
  bool isResendLoading;
  bool? isOTPVisible;
  LoginModel({
    this.phoneNumber,
    this.isButtonLoading = false,
    this.isResendLoading = false,
    this.isOTPVisible,
  });

  set setPhoneNumber(String phoneNumber) {
    phoneNumber = phoneNumber;
  }

  String? get getPhoneNumber {
    return phoneNumber;
  }

  set setIsSendLoading(bool isLoading) {
    isButtonLoading = isLoading;
  }

  set setIsResendLoading(bool isLoading) {
    isResendLoading = isLoading;
  }

  // Add a copyWith method to create a new instance with updated fields
  LoginModel copyWith(
      {String? phoneNumber,
      bool? isButtonLoading,
      bool? isResendLoading,
      bool? isOTPVisible}) {
    return LoginModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isButtonLoading: isButtonLoading ?? false,
      isResendLoading: isResendLoading ?? false,
      isOTPVisible: isOTPVisible ?? this.isOTPVisible,
    );
  }
}
