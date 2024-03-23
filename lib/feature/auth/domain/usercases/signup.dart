import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usercase.dart';
import 'package:blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';

class UserSignUp implements UseCase<String, UserSignUpParams> {
  final AuthRepository _authRepository;

  UserSignUp({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<Either<Failure, String>> call(UserSignUpParams parms) async {
    return await _authRepository.signUpWithEmailAndPassword(
        email: parms.email, name: parms.name, password: parms.password);
  }
}

class UserSignUpParams {
  final String name;
  final String email;
  final String password;

  UserSignUpParams(
      {required this.name, required this.email, required this.password});
}
