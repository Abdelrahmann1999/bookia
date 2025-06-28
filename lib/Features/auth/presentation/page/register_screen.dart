import 'dart:developer';

import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/dialogs/loading_dialog.dart';
import 'package:bookia/Components/inputs/name_text_form_feild.dart';
import 'package:bookia/Features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/Features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Extensions/validation.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthsuccessState) {
            context.pushToPase(Routes.main);
          } else if (state is AuthfailureState) {
            context.pop();
            showMainDialog(context, "Something Went Wrong");
          } else if (state is AuthloadingState) {
            showLoadingDialog(context);
          }
        },

        builder: (context, state) {
          var cubit = context.read<AuthCubit>();
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: MainBackButton(),
            ),
            bottomNavigationBar: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?", style: TextStyles.getBody()),

                  TextButton(
                    onPressed: () {
                      context.pushWithReplacement(Routes.login);
                    },
                    child: Text("Login Now", style: TextStyle(fontSize: 17)),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(22.0),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Hello! Register to get\nstarted",
                            style: TextStyles.getHeadLine1(),
                          ),
                        ],
                      ),
                      Gap(30),
                      nameTextFormFeild(
                        controller: cubit.nameController,
                        hintText: "Username",
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                        },
                      ),

                      Gap(15),
                      nameTextFormFeild(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your Email";
                          } else if (!isEmailValid(value)) {
                            return "Please Enter a Valid Email";
                          }
                          return null;
                        },

                        controller: cubit.emailController,
                        hintText: "Email",
                      ),
                      Gap(15),

                      nameTextFormFeild(
                        obsecureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }
                        },
                        controller: cubit.passwordController,
                        hintText: "Password",
                      ),
                      Gap(15),
                      nameTextFormFeild(
                        obsecureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please Confirm Your Password";
                          }
                        },
                        controller: cubit.passwordConfirmationController,
                        hintText: "Confirm Password",
                      ),
                      Gap(60),
                      mainButton(
                        text: "Register",
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.register();
                          }
                        },
                        textColor: AppColors.white,
                        BGcolor: AppColors.primary,
                      ),
                      Gap(35),

                      Gap(21),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
