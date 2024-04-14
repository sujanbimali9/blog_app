import 'package:blog_app/core/common/cubit/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entity/user.dart';
import 'package:blog_app/feature/auth/domain/usercases/currentuser.dart';
import 'package:blog_app/feature/auth/domain/usercases/usersignin.dart';
import 'package:blog_app/feature/auth/domain/usercases/usersignup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CurrentUser _currentUser;
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final AppUserCubit _appUserCubit;
  AuthBloc(
      {required UserSignIn userSignIn,
      required UserSignUp userSignUp,
      required CurrentUser currentUser,
      required AppUserCubit appUserCubit})
      : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthLoggedIn>(_onUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(message: l.error)),
      (user) => _onAuthSuccess(user, emit),
    );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(message: l.error)),
      (user) => _onAuthSuccess(user, emit),
    );
  }

  void _onUserLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) async {
    final result = await _currentUser(NoParms());

    result.fold(
      (l) => emit(
        AuthFailure(message: l.error),
      ),
      (user) => _onAuthSuccess(user, emit),
    );
  }

  void _onAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
