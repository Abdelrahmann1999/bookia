import 'package:bookia/core/Utils/AppColors.dart';
import 'package:flutter/material.dart';

class SecendButtun extends StatelessWidget {
  const SecendButtun({
    super.key,
    required this.title,
    required this.onpreesed,
    this.height,
    this.width,
  });
  final String title;
  final Function() onpreesed;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 55,
      child: ElevatedButton(
        onPressed: onpreesed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
