import 'package:clean/features/auth/domain/entities/user.dart';
import 'package:clean/features/auth/domain/usecases/user_login.dart';
import 'package:clean/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogin;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogIn userLogIn,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogIn,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogIn);
  }

  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    (event, emit) async {
      emit(AuthLoading());
      final res = await _userSignUp(
        UserSignUpParam(
          email: event.email,
          password: event.password,
          name: event.name,
        ),
      );
      res.fold(
        (l) => emit(AuthFailure(l.message)),
        (user) => emit(AuthSuccess(user)),
      );
    };
  }

  void _onAuthLogIn(AuthLogIn event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final res = await _userLogin(
      UserLogInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(
        AuthSuccess(r),
      ),
    );
  }
}
