import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/feature/auth/data/model/usermodel.dart';
import 'package:blog_app/feature/auth/domain/entity/user.dart';
import 'package:blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, User>> currentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUserData();
      if (user != null) {
        return left(Failure(error: "User not logged in"));
      } else {
        return right(user!);
      }
    } on ServerException catch (e) {
      return left(Failure(error: e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    return _getUser(
        () async => await remoteDataSource.signInWithEmailAndPassword(
              email: email,
              password: password,
            ));
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailAndPassword(
      {required String email,
      required String name,
      required String password}) async {
    return _getUser(
        () async => await remoteDataSource.signUpWithEmailAndPassword(
              email: email,
              name: name,
              password: password,
            ));
  }

  Future<Either<Failure, User>> _getUser(
      Future<UserModel> Function() fn) async {
    try {
      final User userid = await fn();
      return right(userid);
    } on supabase.AuthException catch (e) {
      return left(Failure(error: e.message));
    } on ServerException catch (e) {
      return left(Failure(error: e.message));
    }
  }
}
