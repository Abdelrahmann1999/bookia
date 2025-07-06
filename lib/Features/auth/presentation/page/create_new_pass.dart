import 'dart:developer';

import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/dialogs/loading_dialog.dart';
import 'package:bookia/Components/inputs/name_text_form_feild.dart';
import 'package:bookia/Features/auth/data/model/request/verify_code_params.dart';
import 'package:bookia/Features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/Features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class CreateNewPassScreen extends StatefulWidget {
  const CreateNewPassScreen({super.key, required this.checkOtpParams});
  final CheckOtpParams checkOtpParams;

  @override
  State<CreateNewPassScreen> createState() => _CreateNewPassScreenState();
}

class _CreateNewPassScreenState extends State<CreateNewPassScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    log(
      "Received OTP in Reset Password Screen: ${widget.checkOtpParams.verifyCode}",
    );

    context.read<AuthCubit>().setOtpCode(widget.checkOtpParams.verifyCode);
  }

  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthResetPasswordSuccessState) {
          context.pushToPase(Routes.passwordChanged);
        } else if (state is AuthfailureState) {
          context.pop();
          showMainDialog(context, state.message);
        } else if (state is AuthloadingState) {
          showLoadingDialog(context);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: MainBackButton(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create new password", style: TextStyles.getHeadLine1()),
                  Gap(15),
                  Text(
                    "Your new password must be unique from those previously used",
                    style: TextStyles.getSmall(),
                  ),
                  Gap(20),
                  nameTextFormFeild(
                    hintText: "New Password",
                    controller: cubit.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Enter Your Password";
                      }
                      return null;
                    },
                  ),
                  Gap(20),
                  nameTextFormFeild(
                    hintText: "Confirm Password",
                    controller: cubit.passwordConfirmationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please Confirm Your Password";
                      }
                      return null;
                    },
                  ),
                  Gap(40),
                  mainButton(
                    text: "Reset Password",
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        print("OTP CODE: ${cubit.otpCode}");

                        cubit.resetPassword(
                          verifyCode: cubit.otpCode ?? "",
                          newPassword: cubit.passwordController.text,
                          confirmPassword:
                              cubit.passwordConfirmationController.text,
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
    );
  }
}
