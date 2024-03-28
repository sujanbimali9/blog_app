import 'dart:developer';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/feature/auth/domain/entity/user.dart';
import 'package:blog_app/feature/auth/domain/usercases/currentuser.dart';
import 'package:blog_app/feature/auth/domain/usercases/usersignup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CurrentUser _currentUser;
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  AuthBloc(
      {required UserSignIn userSignIn,
      required UserSignUp userSignUp,
      required CurrentUser currentUser})
      : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthSignIn>(_onAuthSignIn);
    on<AuthLoggedIn>(_onUserLoggedIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold((l) => emit(AuthFailure(message: l.error)),
        (user) => emit(AuthSuccess(user: user)));
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userSignIn(
      UserSignInParams(
        email: event.email,
        password: event.password,
      ),
    );
    log('message');

    res.fold((l) => emit(AuthFailure(message: l.error)),
        (user) => emit(AuthSuccess(user: user)));
  }

  void _onUserLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) async {
    final result = await _currentUser(NoParms());

    result.fold(
      (l) => emit(
        AuthFailure(message: l.error),
      ),
      (user) {
        emit(
          AuthSuccess(user: user),
        );
      },
    );
  }
}
