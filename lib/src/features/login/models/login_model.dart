class LoginModel {
  String? phoneNumber;
  String? otp;
  bool isButtonLoading;
  bool isResendLoading;
  bool? isOTPVisible;
  int? timerDuration = 30;
  bool isVerificationLoading;

  LoginModel({
    this.phoneNumber,
    this.isButtonLoading = false,
    this.isResendLoading = false,
    this.isVerificationLoading = false,
    this.isOTPVisible,
    this.timerDuration,
    this.otp,
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
      bool? isOTPVisible,
      int? timerDuration,
      String? otp,
      bool? isVerificationLoading}) {
    return LoginModel(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isButtonLoading: isButtonLoading ?? false,
      isResendLoading: isResendLoading ?? false,
      isOTPVisible: isOTPVisible ?? this.isOTPVisible,
      timerDuration: timerDuration ?? this.timerDuration,
      otp: otp ?? this.otp,
      isVerificationLoading: isVerificationLoading ?? false,
    );
  }
}
