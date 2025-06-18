import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/inputs/name_text_form_feild.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: MainBackButton()),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don’t have an account?", style: TextStyles.getBody()),

            TextButton(
              onPressed: () {
                context.pushWithReplacement(Routes.register);
              },
              child: Text("Register Now", style: TextStyle(fontSize: 17)),
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
                    "Welcome back! Glad\nto see you, Again!",
                    style: TextStyles.getHeadLine1(),
                  ),
                ],
              ),
              Gap(30),
              nameTextFormFeild(hintText: "Enter Your Email"),
              Gap(15),
              nameTextFormFeild(
                hintText: "Enter Your Password",
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    Appassetes.eyeLogoSvg,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              Gap(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      context.pushTo(Routes.forgetPassword);
                    },
                    child: Text(
                      "Forget Password ?",
                      style: TextStyles.getTitle(
                        fontsize: 18,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              Gap(60),
              mainButton(
                text: "Login",
                onPressed: () {},
                textColor: AppColors.white,
                BGcolor: AppColors.primary,
              ),
              Gap(35),
              Row(
                children: [
                  Expanded(child: Divider()),
                  Gap(20),
                  Text(
                    "Or Login with",
                    style: TextStyles.getTitle(
                      fontsize: 16,
                      color: AppColors.darkGrey,
                    ),
                  ),
                  Gap(20),
                  Expanded(child: Divider()),
                ],
              ),
              Gap(21),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(Appassetes.facebookLogoSvg),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),

                    child: SvgPicture.asset(Appassetes.googleLogoSvg),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(Appassetes.appleLogoSvg),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
