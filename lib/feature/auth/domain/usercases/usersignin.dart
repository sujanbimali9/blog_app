import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feature/auth/domain/entity/user.dart';
import 'package:blog_app/feature/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignin implements UseCase<User, UserLoginParam> {
  final AuthRepository authRepository;

  UserSignin({required this.authRepository});

  @override
  Future<Either<Failure, User>> call(UserLoginParam parms) async {
    return await authRepository.signInWithEmailAndPassword(
        email: parms.email, password: parms.password);
  }
}

class UserLoginParam {
  final String email;
  final String password;

  UserLoginParam({required this.email, required this.password});
}
