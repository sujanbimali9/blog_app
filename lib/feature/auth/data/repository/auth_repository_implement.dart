import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/feature/auth/data/datasource/auth_remote_data_source.dart';
import 'package:blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final String userid = await remoteDataSource.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(userid);
    } on ServerException catch (e) {
      return left(Failure(error: e.message));
    }
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailAndPassword(
      {required String email,
      required String name,
      required String password}) async {
    try {
      final String userid = await remoteDataSource.signUpWithEmailAndPassword(
        email: email,
        name: name,
        password: password,
      );
      return right(userid);
    } on ServerException catch (e) {
      return left(Failure(error: e.message));
    }
  }
}
