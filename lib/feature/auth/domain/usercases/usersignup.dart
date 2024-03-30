import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entity/user.dart';
import 'package:blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<User, UserSignUpParams> {
  final AuthRepository _authRepository;

  UserSignUp({required AuthRepository authRepository})
      : _authRepository = authRepository;
  @override
  Future<Either<Failure, User>> call(UserSignUpParams parms) {
    return _authRepository.signUpWithEmailAndPassword(
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

class UserSignIn implements UseCase<User, UserSignInParams> {
  final AuthRepository _authRepository;

  UserSignIn({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<Either<Failure, User>> call(UserSignInParams parms) async {
    return await _authRepository.signInWithEmailAndPassword(
        email: parms.email, password: parms.password);
  }
}

class UserSignInParams {
  final String email;
  final String password;

  UserSignInParams({required this.email, required this.password});
}
