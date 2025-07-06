import 'dart:io';

import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/dialogs/loading_dialog.dart';
import 'package:bookia/Components/inputs/name_text_form_feild.dart';
import 'package:bookia/Features/Intro/widgets/secend_buttun.dart';
import 'package:bookia/Features/profile/data/model/edit_profile_params.dart';
import 'package:bookia/Features/profile/presination/cubit/profile_cubit.dart';
import 'package:bookia/Features/profile/presination/cubit/profile_state.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Services/shared_pref.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  String? imageUrl;
  String? imagePath;

  @override
  void initState() {
    super.initState();
    final userInfo = SharedPref.getUserInfo();
    nameController.text = userInfo.name ?? "";
    phoneController.text = userInfo.phone ?? "";
    addressController.text = userInfo.address ?? "";
    imageUrl = userInfo.image ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            context.pop();
            context.pop();
          } else if (state is ProfileErrorState) {
            context.pop();
            showMainDialog(context, "Something Went Wrong");
          } else if (state is ProfileLodaingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: MainBackButton(),
              title: const Text('Edit Profile'),
              centerTitle: true,
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    imageUI(),
                    const Gap(30),
                    nameTextFormFeild(
                      controller: nameController,
                      hintText: "Full Name",
                    ),
                    const Gap(20),
                    nameTextFormFeild(
                      controller: phoneController,
                      hintText: "Phone",
                    ),
                    const Gap(20),
                    nameTextFormFeild(
                      controller: addressController,
                      hintText: "Address",
                    ),
                    const Gap(50),
                    mainButton(
                      text: "Update Profile",
                      onPressed: () {
                        context.read<ProfileCubit>().editProfile(
                          EditProfileParams(
                            name: nameController.text,
                            phone: phoneController.text,
                            address: addressController.text,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  SizedBox imageUI() {
    return SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (imagePath?.isNotEmpty == true)
            ClipOval(
              child: Image.file(
                File(imagePath!),
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.error),
              ),
            )
          else if (imageUrl?.isNotEmpty == true)
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: imageUrl!,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            )
          else
            const CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 40),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                showUploadBottomSheet(context);
              },
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  Appassetes.cameraSvg,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  UploadImage(bool IsCamera) async {
    ImagePicker imagePicker = ImagePicker();
    var PickedImage = await imagePicker.pickImage(
      source: IsCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (PickedImage != null) {
      setState(() {
        imagePath = PickedImage.path;
      });
      context.read<ProfileCubit>().editProfile(
        EditProfileParams(
          name: nameController.text,
          phone: phoneController.text,
          address: addressController.text,
          image: File(PickedImage.path),
        ),
      );
    }
    Navigator.pop(context);
  }

  showUploadBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SecendButtun(
                  title: "Upload From Camera",
                  onpreesed: () {
                    UploadImage(true);
                  },
                ),
                SizedBox(height: 7),
                SecendButtun(
                  title: "Upload From Gallery",
                  onpreesed: () {
                    UploadImage(false);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
