import 'package:blog_app/core/keys/supabase.dart';
import 'package:blog_app/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/feature/auth/data/repository/auth_repository_implement.dart';
import 'package:blog_app/feature/auth/domain/usercases/currentuser.dart';
import 'package:blog_app/feature/auth/domain/usercases/usersignup.dart';
import 'package:blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocater = GetIt.instance;
Future<void> initDependencies() async {
  final Supabase supabase = await Supabase.initialize(
    url: SupabaseKey.supabaseUrl,
    anonKey: SupabaseKey.supabaseAnonKey,
  );
  serviceLocater.registerLazySingleton(() => supabase.client);
  _initAuth();
}

void _initAuth() {
  serviceLocater
    ..registerFactory<AuthRemoteDataSourceImplement>(
      () => AuthRemoteDataSourceImplement(
        supabaseClient: serviceLocater<SupabaseClient>(),
      ),
    )
    ..registerFactory<AuthRepositoryImpl>(
      () => AuthRepositoryImpl(
        remoteDataSource: serviceLocater<AuthRemoteDataSourceImplement>(),
      ),
    )
    ..registerFactory<UserSignUp>(
      () => UserSignUp(
        authRepository: serviceLocater<AuthRepositoryImpl>(),
      ),
    )
    ..registerFactory<UserSignIn>(
      () => UserSignIn(
        authRepository: serviceLocater<AuthRepositoryImpl>(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        authRepository: serviceLocater<AuthRepositoryImpl>(),
      ),
    )
    ..registerSingleton(AuthBloc(
        currentUser: serviceLocater<CurrentUser>(),
        userSignUp: serviceLocater<UserSignUp>(),
        userSignIn: serviceLocater<UserSignIn>()));
}
