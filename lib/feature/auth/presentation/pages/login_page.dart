import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/feature/auth/presentation/widgets/gradient_button.dart';
import 'package:blog_app/feature/auth/presentation/widgets/textfield.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
      key: formkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Sign Up",
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 30,
          ),
          AuthField(
            hint: "Email",
            controller: emailController,
            formKey: formkey,
          ),
          AuthField(
            hint: "Password",
            isPassword: true,
            controller: passwordController,
            formKey: formkey,
          ),
          const SizedBox(height: 20),
          GradientButton(onPressed: () {
            if (formkey.currentState!.validate()) {
              // context.read<AuthBloc>().add(AuthSignIn(email: email, name: name, password: password));
            }
          }),
          const SizedBox(height: 10),
          RichText(
            text: TextSpan(
              text: "Don't have an account? ",
              style: Theme.of(context).textTheme.titleMedium,
              children: [
                TextSpan(
                  mouseCursor: SystemMouseCursors.click,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => GoRouter.of(context).go('/signup'),
                  text: "Sign In",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppPallete.gradient2, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
