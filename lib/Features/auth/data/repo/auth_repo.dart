import 'package:bookia/Features/auth/data/model/request/register_params.dart';
import 'package:bookia/Features/auth/data/model/request/verify_code_params.dart';
import 'package:bookia/Features/auth/data/model/reset_password_params/reset_password_params.dart';
import 'package:bookia/Features/auth/data/model/reset_password_params/reset_password_response.dart';
import 'package:bookia/Features/auth/data/model/response/user_response/user_response.dart';
import 'package:bookia/core/Constants/AppConstants.dart';
import 'package:bookia/core/Services/dio_provider.dart';

class AuthRepo {
  static Future<UserResponse?> register(RegisterParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.register,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        return UserResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<UserResponse?> login(RegisterParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.login,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<UserResponse?> forgetPassword(RegisterParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.forgetPassword,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return UserResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }

  static Future<bool> verifyOtp(CheckOtpParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.verifyOTP,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<ResetPasswordResponse?> resetPassword(
    ResetPasswordParams params,
  ) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.resetPassword,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        print("Status code: ${response.statusCode}");
        print("Response body: ${response.data}");
        return ResetPasswordResponse.fromJson(response.data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
