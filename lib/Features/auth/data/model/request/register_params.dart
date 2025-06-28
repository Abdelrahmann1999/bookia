class RegisterParams {
  String? name;
  String? email;
  String? password;
  String? passwordConfirmation;
  String? otp;

  RegisterParams({
    this.name,
    this.email,
    this.password,
    this.passwordConfirmation,
    this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "OTP": otp,
    };
  }
}
