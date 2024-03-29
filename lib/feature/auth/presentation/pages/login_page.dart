import 'package:blog_app/core/common/widget/loader.dart';
import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/snackbar.dart';
import 'package:blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feature/auth/presentation/widgets/gradient_button.dart';
import 'package:blog_app/feature/auth/presentation/widgets/textfield.dart';
import 'package:blog_app/routes/routes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        body: BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure) {
          showSnackBar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Loading();
        } else {
          return Form(
            key: formkey,
            child: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
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
                    GradientButton(
                        text: 'Login',
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            context.read<AuthBloc>().add(AuthSignIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim()));
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
                              ..onTap =
                                  () => GoRouter.of(context).go(Goto.signup),
                            text: "Login",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: AppPallete.gradient,
                                    fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    ));
  }
}
