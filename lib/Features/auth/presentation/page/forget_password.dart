import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/dialogs/loading_dialog.dart';
import 'package:bookia/Components/inputs/name_text_form_feild.dart';
import 'package:bookia/Features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/Features/auth/presentation/cubit/auth_state.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Extensions/validation.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthsuccessState) {
            var cubit = context.read<AuthCubit>();
            cubit.setEmail(cubit.emailController.text.trim());

            context.pushToPase(Routes.otpverification);
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
                  Text("Remember Password?", style: TextStyles.getBody()),

                  TextButton(
                    onPressed: () {
                      context.pushWithReplacement(Routes.login);
                    },
                    child: Text("Login", style: TextStyle(fontSize: 17)),
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Forgot Password?", style: TextStyles.getHeadLine1()),
                    Gap(15),
                    Text(
                      "Don't worry! It occurs. Please enter the email address linked with your account.",
                      style: TextStyles.getSmall(),
                    ),
                    Gap(20),
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

                      hintText: "Enter Your Email",
                    ),
                    Gap(40),
                    mainButton(
                      text: "Send Code",
                      onPressed: () {
                        if (cubit.formKey.currentState!.validate()) {
                          cubit.setEmail(cubit.emailController.text.trim());
                          cubit.forgetPassword();
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
