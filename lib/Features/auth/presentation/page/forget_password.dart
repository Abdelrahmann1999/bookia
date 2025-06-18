import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/inputs/name_text_form_feild.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: MainBackButton()),
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
            nameTextFormFeild(hintText: "Enter Your Email"),
            Gap(40),
            mainButton(
              text: "Send Code",
              onPressed: () {
                context.pushTo(Routes.otpverification);
              },
            ),
          ],
        ),
      ),
    );
  }
}
