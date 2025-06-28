import 'package:bookia/core/Utils/AppColors.dart';
import 'package:bookia/core/Utils/text_styles.dart';
import 'package:flutter/material.dart';

class mainButton extends StatelessWidget {
  const mainButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.BGcolor,
    this.textColor,
    this.borderColor,
    this.height,
    this.width,
    this.borderRadius,
  });
  final double? height;
  final double? width;
  final String text;
  final Function() onPressed;
  final Color? BGcolor;
  final Color? textColor;
  final Color? borderColor;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 56,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          side: borderColor != null
              ? BorderSide(color: borderColor ?? AppColors.dark)
              : null,

          backgroundColor: BGcolor ?? AppColors.primary,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
        ),
        child: Text(
          text,
          style: TextStyles.getTitle(color: textColor ?? AppColors.white),
        ),
      ),
    );
  }
}
