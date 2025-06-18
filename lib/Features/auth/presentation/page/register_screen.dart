import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/inputs/name_text_form_feild.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: MainBackButton()),
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
              nameTextFormFeild(hintText: "Username"),

              Gap(15),
              nameTextFormFeild(hintText: "Email"),
              Gap(15),

              nameTextFormFeild(hintText: "Password"),
              Gap(15),
              nameTextFormFeild(hintText: "Confirm Password"),
              Gap(60),
              mainButton(
                text: "Register",
                onPressed: () {},
                textColor: AppColors.white,
                BGcolor: AppColors.primary,
              ),
              Gap(35),

              Gap(21),
            ],
          ),
        ),
      ),
    );
  }
}
