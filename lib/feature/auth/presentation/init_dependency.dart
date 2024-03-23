import 'package:blog_app/core/keys/supabase.dart';
import 'package:blog_app/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/feature/auth/data/repository/auth_repository_implement.dart';
import 'package:blog_app/feature/auth/domain/usercases/signup.dart';
import 'package:blog_app/feature/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocater = GetIt.instance;
Future<void> initDependencies() async {
  final Supabase supabase = await Supabase.initialize(
    url: SupabaseKey.supabaseUrl,
    anonKey: SupabaseKey.supabaseAnonKey,
  );
  _initAuth();

  serviceLocater.registerSingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocater.registerFactory<AuthRemoteDataSourceImplement>(
    () => AuthRemoteDataSourceImplement(
      supabaseClient: serviceLocater<SupabaseClient>(),
    ),
  );
  serviceLocater.registerFactory<AuthRepositoryImpl>(
    () => AuthRepositoryImpl(
      remoteDataSource: serviceLocater<AuthRemoteDataSourceImplement>(),
    ),
  );
  serviceLocater.registerFactory<UserSignUp>(
    () => UserSignUp(
      authRepository: serviceLocater<AuthRepositoryImpl>(),
    ),
  );
  serviceLocater
      .registerSingleton(AuthBloc(userSignUp: serviceLocater<UserSignUp>()));
}
