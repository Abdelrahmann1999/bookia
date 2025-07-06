import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

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
              Text(
                "Password Changed!",
                style: TextStyles.getHeadLine2(fontsize: 30),
              ),
              Gap(10),
              Text(
                "Your password has been changed",
                style: TextStyles.getSmall(fontsize: 15),
              ),

              Text("successfully.", style: TextStyles.getSmall(fontsize: 15)),
              Gap(50),
              mainButton(
                text: "Back To Login",
                onPressed: () {
                  context.pushWithReplacement(
                    Routes.login,
                    extra: {
                      'password': context
                          .read<AuthCubit>()
                          .passwordController
                          .text,
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
