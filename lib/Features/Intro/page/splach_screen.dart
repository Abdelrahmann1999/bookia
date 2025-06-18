import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:bookia/core/Extensions/navigation.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:bookia/core/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      context.pushWithReplacement(Routes.welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(Appassetes.logoSvg, width: 250),
            Gap(10),

            Text("Order Your Book Now!", style: TextStyles.getTitle()),
          ],
        ),
      ),
    );
  }
}
