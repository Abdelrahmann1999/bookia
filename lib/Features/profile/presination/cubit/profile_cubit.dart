import 'package:bookia/Features/auth/data/model/response/user_response/user.dart';
import 'package:bookia/Features/profile/data/model/edit_profile_params.dart';
import 'package:bookia/Features/profile/data/repo/profile_repo.dart';
import 'package:bookia/Features/profile/presination/cubit/profile_state.dart';
import 'package:bookia/core/Services/shared_pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitila());


  logout() {
    emit(ProfileLodaingState());

    ProfileRepo.logout().then((value) {
      if (value == true) {
        SharedPref.removeUserData();
        emit(ProfileSuccessState());
      } else {
        emit(ProfileErrorState());
      }
    });
  }
  editProfile(EditProfileParams params) {
    emit(ProfileLodaingState());

    ProfileRepo.editProfile(params).then((value) {
      if (value != null) {
        SharedPref.setUserInfo(value.data ?? User());
        emit(ProfileSuccessState());
      } else {
        emit(ProfileErrorState());
      }
    });
  }
}
  