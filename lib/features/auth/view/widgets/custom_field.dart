import 'package:flutter/material.dart';

class CustomField extends StatelessWidget {
  const CustomField(
      {super.key,
      required this.hintText,
      required this.controller,
      this.isObscuredText = false});
  final String hintText;
  final TextEditingController controller;
  final bool isObscuredText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
      controller: controller,
      obscureText: isObscuredText,
      decoration: InputDecoration(
        hintText: hintText,
      ),
    );
  }
}
