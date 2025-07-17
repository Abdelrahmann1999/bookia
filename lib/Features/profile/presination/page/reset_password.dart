import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/dialogs/loading_dialog.dart';
import 'package:bookia/Components/inputs/name_text_form_feild.dart';
import 'package:bookia/Features/profile/presination/cubit/profile_cubit.dart';
import 'package:bookia/Features/profile/presination/cubit/profile_state.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final _formKey = GlobalKey<FormState>();

  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            showMainDialog(context, 'Password reset successfully');
          } else if (state is ProfileErrorState) {
            Navigator.pop(context);
            showMainDialog(context, 'Failed to reset password');
          }
          if (state is ProfileLodaingState) {
            showLoadingDialog(context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Reset Password'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'New password',
                      style: TextStyles.getTitle(
                        fontsize: 24,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 30),
                    nameTextFormFeild(
                      hintText: "Current password",
                      controller: currentPasswordController,
                      obsecureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your current Password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    nameTextFormFeild(
                      hintText: "New password",
                      controller: newPasswordController,
                      obsecureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your Password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    nameTextFormFeild(
                      hintText: "Confirm password",
                      controller: confirmPasswordController,
                      obsecureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your Password";
                        }
                        if (value != newPasswordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    const Spacer(),
                    mainButton(
                      text: "Reset Password",
                      onPressed: () {
                        final isValid = _formKey.currentState?.validate();
                        if (isValid == true) {
                          context.read<ProfileCubit>().changePassword(
                            currentPasswordController.text,
                            newPasswordController.text,
                            confirmPasswordController.text,
                          );
                        }
                        
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
}
