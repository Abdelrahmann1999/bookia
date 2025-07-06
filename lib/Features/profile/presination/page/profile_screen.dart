import 'package:bookia/Components/dialogs/loading_dialog.dart';
import 'package:bookia/Features/profile/presination/cubit/profile_cubit.dart';
import 'package:bookia/Features/profile/presination/cubit/profile_state.dart';
import 'package:bookia/Features/profile/presination/widgets/profile_header.dart';
import 'package:bookia/Features/profile/presination/widgets/profile_tile.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            context.pop();
            context.pushToPase(Routes.login);
          } else if (state is ProfileErrorState) {
            context.pop();
            showMainDialog(context, "Something Went Wrong");
          } else if (state is ProfileLodaingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            toolbarHeight: 80,
            title: Text("Profile"),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  context.read<ProfileCubit>().logout();
                },
                icon: SvgPicture.asset(Appassetes.logoutSvg),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                profileHeader(),
                Gap(30),
                Column(
                  children: [
                    profileTile(label: "My Orders", Ontap: () {}),
                    Gap(10),
                    profileTile(
                      label: "Edit Profile",
                      Ontap: () {
                        context.pushTo(Routes.editProfile);
                      },
                    ),
                    Gap(10),
                    profileTile(label: "Reset Password", Ontap: () {}),
                    Gap(10),
                    profileTile(label: "FAQ", Ontap: () {}),
                    Gap(10),
                    profileTile(label: "Contact Us", Ontap: () {}),
                    Gap(10),
                    profileTile(label: "Privacy & Terms", Ontap: () {}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
