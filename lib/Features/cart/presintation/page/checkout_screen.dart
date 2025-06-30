import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(22.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(Appassetes.successSvg),
              Gap(35),
              Text("Success !", style: TextStyles.getHeadLine2(fontsize: 35)),
              Gap(10),
              Text(
                " Your order will be delivered soon.\n Thank you for choosing our app!",

                style: TextStyles.getSmall(fontsize: 15),
              ),

              Gap(50),
              mainButton(
                text: "Back To Home",
                onPressed: () {
                  context.pushWithReplacement(Routes.login);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
