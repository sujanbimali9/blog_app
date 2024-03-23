import 'package:blog_app/feature/auth/presentation/pages/signin_page.dart';
import 'package:go_router/go_router.dart';

import '../feature/auth/presentation/pages/login_page.dart';

class AllRoutes {
  static GoRouter router = GoRouter(routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => const SignInScreen(),
    )
  ]);
}
