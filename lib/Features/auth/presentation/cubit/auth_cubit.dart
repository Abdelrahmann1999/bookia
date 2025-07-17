import 'package:bookia/Features/auth/data/model/request/register_params.dart';
import 'package:bookia/Features/auth/data/model/request/verify_code_params.dart';
import 'package:bookia/Features/auth/data/model/reset_password_params/reset_password_params.dart';
import 'package:bookia/Features/auth/data/model/response/user_response/user.dart';
import 'package:bookia/Features/auth/data/repo/auth_repo.dart';
import 'package:bookia/Features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/core/Services/shared_pref.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthinitState());

  String? userEmail;
  String? otpCode;

  void setOtpCode(String code) {
    otpCode = code;
  }

  void setEmail(String email) {
    userEmail = email;
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final otpController = TextEditingController();

  RegisterParams params = RegisterParams();

  register() {
    params.name = nameController.text;
    params.password = passwordController.text;
    params.passwordConfirmation = passwordConfirmationController.text;
    params.email = emailController.text;
    emit(AuthloadingState());
    try {
      AuthRepo.register(params).then((value) {
        if (value != null) {
          SharedPref.setUserInfo(value.data?.user ?? User());
          SharedPref.setUserTokin(value.data?.token ?? "");
          emit(AuthsuccessState());
        } else {
          emit(AuthfailureState());
        }
      });
    } on Exception catch (_) {
      print("error");
    }
  }

  login() {
    params.password = passwordController.text;
    params.email = emailController.text;
    emit(AuthloadingState());
    try {
      AuthRepo.login(params).then((value) {
        // cash user info
        if (value != null) {
          SharedPref.setUserInfo(value.data?.user ?? User());
          SharedPref.setUserTokin(value.data?.token ?? "");
          emit(AuthsuccessState());
        } else {
          emit(AuthfailureState());
        }
      });
    } on Exception catch (_) {
      print("error");
    }
  }

  forgetPassword() {
    params.email = emailController.text;
    emit(AuthloadingState());

    AuthRepo.forgetPassword(params)
        .then((value) {
          if (value != null) {
            SharedPref.setUserInfo(value.data?.user ?? User());
            SharedPref.setUserTokin(value.data?.token ?? "");
            emit(AuthsuccessState());
          } else {
            emit(
              AuthfailureState("لم يتم العثور على حساب بهذا البريد الإلكتروني"),
            );
          }
        })
        .catchError((error) {
          if (error is DioException) {
            print("🔴 DioException: ${error.response?.statusCode}");
            print("🔴 Response Data: ${error.response?.data}");

            final message =
                error.response?.data["message"] ??
                error.response?.data["error"] ??
                "حدث خطأ غير متوقع";

            emit(AuthfailureState(message));
          } else {
            emit(AuthfailureState("حدث خطأ غير متوقع"));
          }
        });
  }

  Future<void> verifyOtp(CheckOtpParams params) async {
    emit(AuthloadingState());

    final result = await AuthRepo.verifyOtp(params);

    if (result) {
      emit(AuthVerifyCodeSuccessState());
    } else {
      emit(AuthfailureState("رمز التحقق غير صحيح"));
    }
  }

  Future<void> resetPassword({
    required String verifyCode,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(AuthloadingState());
    try {
      final params = ResetPasswordParams(
        verifyCode: verifyCode,
        newPassword: newPassword,
        newPasswordConfirmation: confirmPassword,
      );

      final result = await AuthRepo.resetPassword(params);
      print("Reset API Result: $result");

      if (result != null) {
        emit(AuthResetPasswordSuccessState());
      } else {
        emit(AuthfailureState("فشل في إعادة تعيين كلمة المرور"));
      }
    } catch (e) {
      print("Reset Error: $e");
      emit(AuthfailureState("حدث خطأ أثناء إعادة التعيين"));
    }
  }
}
