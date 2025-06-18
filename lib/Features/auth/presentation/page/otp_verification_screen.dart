import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';
import 'package:bookia/core/Utils/AppColors.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

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
      appBar: AppBar(automaticallyImplyLeading: false, title: MainBackButton()),
      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "OTP Verification",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            const Text(
              "Enter the verification code sent to your email address.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 25),
            Center(
              child: Pinput(
                length: 4,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primary, width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                submittedPinTheme: defaultPinTheme,
                onCompleted: (pin) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Code"),
                      content: Text("You entered: $pin"),
                    ),
                  );
                },
              ),
            ),
            Gap(35),
            mainButton(
              text: "Verify",
              onPressed: () {
                context.pushTo(Routes.createNewPass);
              },
            ),
          ],
        ),
      ),
    );
  }
}
