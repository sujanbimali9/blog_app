import 'package:blog_app/core/error/failure.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailAndPassword(
      {required String email, required String name, required String password});
  Future<Either<Failure, String>> signInWithEmailAndPassword(
      {required String email, required String password});
}
