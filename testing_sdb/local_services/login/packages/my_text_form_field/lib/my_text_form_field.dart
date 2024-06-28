library my_text_form_field;

import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? errorMessage;
  final FocusNode focusNode;
  final double height;
  final onFieldSubmitted;

  const MyTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.errorMessage,
    required this.focusNode,
    this.height = 60.0,
    this.onFieldSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 20,
      borderRadius: BorderRadius.circular(14),
      shadowColor: Color.fromRGBO(255, 255, 255, 0.5),
      child: SizedBox(
        height: height,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 236, 236, 1)),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromRGBO(238, 236, 236, 1)),
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            fillColor: Colors.white,
            filled: true,
            hintText: hintText,
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
          ),
          focusNode: focusNode,
          onFieldSubmitted: onFieldSubmitted,
        ),
      ),
    );
  }
}
