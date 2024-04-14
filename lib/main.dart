import 'package:blog_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:blog_app/core/theme/theme.dart';
import 'package:blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/feature/auth/presentation/init_dependency.dart';
import 'package:blog_app/feature/home/presentation/blog_bloc/blog_bloc.dart';
import 'package:blog_app/feature/home/presentation/home_bloc/allblog_bloc.dart';
import 'package:blog_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocater<AppUserCubit>(),
      ),
      BlocProvider(
        create: (_) => serviceLocater<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocater<AllBlogBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocater<BlogBloc>(),
      )
    ],
    child: const MainApp(),
  ));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkThemeMode,
      routerDelegate: AllRoutes.router.routerDelegate,
      routeInformationParser: AllRoutes.router.routeInformationParser,
      routeInformationProvider: AllRoutes.router.routeInformationProvider,
    );
  }
}
