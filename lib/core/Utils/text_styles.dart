import 'package:bookia/core/Utils/AppColors.dart';
import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle getHeadLine1({
    Color? color,
    double? fontsize,
    FontWeight? fontweight,
  }) {
    return TextStyle(
      fontSize: fontsize ?? 30,
      fontWeight: fontweight ?? FontWeight.normal,
      color: color ?? AppColors.dark,
    );
  }

  static TextStyle getHeadLine2({
    Color? color,
    double? fontsize,
    FontWeight? fontweight,
  }) {
    return TextStyle(
      fontSize: fontsize ?? 24,
      fontWeight: fontweight ?? FontWeight.normal,
      color: color ?? AppColors.dark,
    );
  }

  static TextStyle getTitle({
    Color? color,
    double? fontsize,
    FontWeight? fontweight,
  }) {
    return TextStyle(
      fontSize: fontsize ?? 20,
      fontWeight: fontweight ?? FontWeight.normal,
      color: color ?? AppColors.dark,
    );
  }

  static TextStyle getBody({
    Color? color,
    double? fontsize,
    FontWeight? fontweight,
  }) {
    return TextStyle(
      fontSize: fontsize ?? 16,
      fontWeight: fontweight ?? FontWeight.normal,
      color: color ?? AppColors.dark,
    );
  }

  static TextStyle getSmall({
    Color? color,
    double? fontsize,
    FontWeight? fontweight,
  }) {
    return TextStyle(
      fontSize: fontsize ?? 14,
      fontWeight: fontweight ?? FontWeight.normal,
      color: color ?? AppColors.grey,
    );
  }
}
