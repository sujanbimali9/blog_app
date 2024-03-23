part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class AuthSignUp extends AuthEvent {
  AuthSignUp({
    required this.email,
    required this.name,
    required this.password,
  });
  final String email;
  final String name;
  final String password;
}
