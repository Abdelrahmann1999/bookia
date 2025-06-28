
class ResetPasswordParams {
  final String verifyCode;
  final String newPassword;
  final String newPasswordConfirmation;

  ResetPasswordParams({
    required this.verifyCode,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      "verify_code": verifyCode,
      "new_password": newPassword,
      "new_password_confirmation": newPasswordConfirmation,
    };
  }
}
