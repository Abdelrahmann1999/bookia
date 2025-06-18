import 'package:bookia/Components/buttons/main_back_button.dart';
import 'package:bookia/Components/buttons/main_button.dart';
import 'package:bookia/Components/inputs/name_text_form_feild.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CreateNewPassScreen extends StatelessWidget {
  const CreateNewPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false, title: MainBackButton()),

      body: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Create new password", style: TextStyles.getHeadLine1()),
            Gap(15),
            Text(
              "Your new password must be unique from those previously used",
              style: TextStyles.getSmall(),
            ),
            Gap(20),
            nameTextFormFeild(hintText: "New Password"),
            Gap(20),
            nameTextFormFeild(hintText: "Confirm Password"),
            Gap(40),

            mainButton(
              text: "Reset Password",
              onPressed: () {
                context.pushTo(Routes.passwordChanged);
              },
            ),
          ],
        ),
      ),
    );
  }
}
