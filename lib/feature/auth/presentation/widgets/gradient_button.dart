import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:flutter/material.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, required this.onPressed});

  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(8)),
          gradient: LinearGradient(
            colors: [AppPallete.gradient1, AppPallete.gradient2],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          )),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            fixedSize: const Size(400, 60),
            foregroundColor: AppPallete.transparentColor,
            shadowColor: AppPallete.transparentColor,
            backgroundColor: AppPallete.transparentColor),
        child: const Text(
          "Sign Up",
          style: TextStyle(color: Colors.white54),
        ),
      ),
    );
  }
}
