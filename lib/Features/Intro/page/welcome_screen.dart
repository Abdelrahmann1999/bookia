import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Extensions/mediaQuery.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            Appassetes.welcomePG,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: [
                  Gap(context.height * .16),

                  SvgPicture.asset(Appassetes.logoSvg, width: 250),
                  Gap(10),

                  Text("Order Your Book Now!", style: TextStyles.getTitle()),
                  Spacer(),
                  mainButton(
                    text: "Login",
                    onPressed: () {
                      context.pushTo(Routes.login);
                    },
                  ),
                  Gap(15),
                  mainButton(
                    text: "Register",
                    onPressed: () {
                      context.pushTo(Routes.register);
                    },
                    BGcolor: AppColors.white,
                    textColor: AppColors.black,
                    borderColor: AppColors.black,
                  ),

                  Gap(context.height * .1),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
