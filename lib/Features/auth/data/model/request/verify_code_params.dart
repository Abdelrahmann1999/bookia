class CheckOtpParams {
  final String email;
  final String verifyCode;

  CheckOtpParams({required this.email, required this.verifyCode});

  Map<String, dynamic> toJson() {
    return {"email": email, "verify_code": verifyCode};
  }
}
