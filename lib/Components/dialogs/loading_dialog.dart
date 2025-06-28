import 'package:bookia/core/Constants/AppAssete.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

enum DialogType { success, error }

showLoadingDialog(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    barrierColor: Colors.black.withValues(alpha: 0.3),
    context: context,
    builder: (context) => Lottie.asset(Appassetes.bookLoadin),
  );
}

showMainDialog(
  BuildContext context,
  String message, [
  DialogType type = DialogType.error,
]) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: type == DialogType.success ? Colors.green : Colors.red,
      content: Text(message),
    ),
  );
}
