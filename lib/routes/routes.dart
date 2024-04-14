import 'package:blog_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:blog_app/feature/auth/presentation/pages/signin_page.dart';
import 'package:blog_app/feature/home/presentation/pages/add_blog.dart';
import 'package:blog_app/feature/home/presentation/pages/blog_home.dart';
import 'package:blog_app/feature/home/presentation/pages/blog_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../feature/auth/presentation/pages/login_page.dart';

class AllRoutes {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
          path: '/',
          builder: (context, stat) {
            return BlocSelector<AppUserCubit, AppUserState, bool>(
              selector: (state) {
                return state is AppUserLoggedIn;
              },
              builder: (context, isLoggedin) {
                return isLoggedin ? const HomePage() : const LoginScreen();
              },
            );
          }),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: '/addblog',
        builder: (context, state) => const AddBlog(),
      ),
      GoRoute(
        path: '/blogview/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          return BlogView(id: id!);
        },
      ),
    ],
  );
}

class Goto {
  static String login = '/login';
  static String signup = '/signup';
  static String home = '/home';
  static String addblog = '/addblog';
  static String blogView = '/blogview';
}
