import 'package:flutter/material.dart';

class nameTextFormFeild extends StatelessWidget {
  const nameTextFormFeild({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.obsecureText = false,
  });
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obsecureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obsecureText,
      keyboardType: keyboardType,
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
