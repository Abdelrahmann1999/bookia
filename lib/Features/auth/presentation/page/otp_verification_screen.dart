import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/dialogs/loading_dialog.dart';
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
import 'package:pinput/pinput.dart';
import 'package:bookia/core/Utils/AppColors.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String otpCode = "";
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 70,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return BlocProvider.value(
      value: context.read<AuthCubit>(),

      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          var cubit = context.read<AuthCubit>();
          if (state is AuthVerifyCodeSuccessState) {
            context.pushReplacement(
              Routes.createNewPass,
              extra: CheckOtpParams(
                email: cubit.emailController.text,
                verifyCode: otpCode,
              ),
            );
          } else if (state is AuthfailureState) {
            context.pop();
            showMainDialog(context, state.message);
          } else if (state is AuthloadingState) {
            showLoadingDialog(context);
          }
        },

        builder: (context, state) {
          var cubit = context.read<AuthCubit>();
          return Scaffold(
            bottomNavigationBar: SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Didn’t received code?", style: TextStyles.getBody()),

                  TextButton(
                    onPressed: () {},

                    child: Text("Resend", style: TextStyle(fontSize: 17)),
                  ),
                ],
              ),
            ),
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: MainBackButton(),
            ),
            body: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "OTP Verification",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Enter the verification code sent to your email address.",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 25),
                    Center(
                      child: Pinput(
                        keyboardType: TextInputType.number,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: defaultPinTheme.copyWith(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: AppColors.primary,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        submittedPinTheme: defaultPinTheme,
                        onChanged: (value) {
                          setState(() {
                            otpCode = value;
                          });
                        },
                      ),
                    ),
                    Gap(35),
                    mainButton(
                      text: "Verify",
                      onPressed: () {
                        if (otpCode.length == 6) {
                          cubit.verifyOtp(
                            CheckOtpParams(
                              email: cubit.emailController.text,
                              verifyCode: otpCode,
                            ),
                          );
                        } else {
                          showMainDialog(
                            context,
                            "Please enter a valid 4-digit code",
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
