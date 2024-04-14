import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  const AuthField(
      {super.key,
      required this.hint,
      required this.formKey,
      required this.controller,
      this.isPassword = false});
  final String hint;
  final bool isPassword;
  final GlobalKey<FormState> formKey;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 7.5),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        onTapOutside: (event) {},
        decoration: InputDecoration(
          hintText: hint,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return "$hint is missing";
          }
          return null;
        },
      ),
    );
  }
}
