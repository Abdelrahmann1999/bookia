import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class MainBackButton extends StatelessWidget {
  const MainBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.login);
      },
      child: Row(children: [SvgPicture.asset(Appassetes.backSvg)]),
    );
  }
}
