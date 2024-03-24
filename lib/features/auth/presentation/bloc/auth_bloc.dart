import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/features/auth/domain/entities/user.dart';
import 'package:clean/features/auth/domain/usecases/current_user.dart';
import 'package:clean/features/auth/domain/usecases/user_login.dart';
import 'package:clean/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogIn _userLogin;
  final CurrentUser _currentUser;
  // final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogIn userLogIn,
    required CurrentUser currentUser,
    // required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userLogin = userLogIn,
        _currentUser = currentUser,
        // _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUp>(_onAuthSignUp);
    on<AuthLogIn>(_onAuthLogin);
    on<AuthIsUserLoggedIn>(_isUserLoggedIn);
  }

  void _isUserLoggedIn(
    AuthIsUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess(r)),
    );
  }

  void _onAuthSignUp(
    AuthSignUp event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );

    res.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthSuccess(user)),
    );
  }

  void _onAuthLogin(
    AuthLogIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _userLogin(
      UserLogInParams(
        email: event.email,
        password: event.password,
      ),
    );

    res.fold(
      (l) => emit(AuthFailure(l.message)),
      (r) => emit(AuthSuccess(r)),
    );
  }

  // void _emitAuthSuccess(
  //   User user,
  //   Emitter<AuthState> emit,
  // ) {
  //   _appUserCubit.updateUser(user);
  //   emit(AuthSuccess(user));
  // }
}
