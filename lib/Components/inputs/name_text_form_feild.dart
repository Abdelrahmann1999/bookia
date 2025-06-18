import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class nameTextFormFeild extends StatelessWidget {
  const nameTextFormFeild({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
  });
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        suffixIconConstraints: BoxConstraints(maxWidth: 50),
      ),
      validator: validator,
    );
  }
}
