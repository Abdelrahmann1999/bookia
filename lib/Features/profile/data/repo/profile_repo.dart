import 'package:bookia/Features/profile/data/model/edit_profile_params.dart';
import 'package:bookia/Features/profile/data/model/edit_profile_response/edit_profile_response.dart';
import 'package:bookia/core/Constants/AppConstants.dart';
import 'package:bookia/core/Services/dio_provider.dart';
import 'package:bookia/core/Services/shared_pref.dart';

class ProfileRepo {
  static Future<bool> logout() async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.logout,
        headers: {"Authorization": "Bearer ${SharedPref.getUserTokin()}"},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<EditProfileResponse?> editProfile(EditProfileParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Appconstants.editProfile,
        data: params.toFormData(),
        headers: {"Authorization": "Bearer ${SharedPref.getUserTokin()}"},
      );
      if (response.statusCode == 200) {
        return EditProfileResponse.fromJson(response.data);
      } else {
        return null;
      }
    } on Exception catch (_) {
      return null;
    }
  }
}
