import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isObscure;
  const AuthField({
    super.key,
    required this.label,
    required this.controller,
     this.isObscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      validator: (value) {
        if (value!.isEmpty) {
          return "$label is missing";
        }
        return null;
      },
      decoration:
          InputDecoration(border: const OutlineInputBorder(), hintText: label),
    );
  }
}
