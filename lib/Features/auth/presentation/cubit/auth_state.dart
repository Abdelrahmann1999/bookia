abstract class AuthState {}

class AuthinitState extends AuthState {}

class AuthloadingState extends AuthState {}

class AuthsuccessState extends AuthState {}

class AuthfailureState extends AuthState {
  final String message;
  AuthfailureState([this.message = "حدث خطأ غير متوقع"]);
}

class AuthVerifyCodeSuccessState extends AuthState {}

class AuthResetPasswordSuccessState extends AuthState {}
