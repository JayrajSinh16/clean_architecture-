// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clean/core/error/failures.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/features/auth/domain/entities/user.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserLogIn implements UseCase<User, UserLogInParams> {
  final AuthRepository authRepository;
  const UserLogIn(this.authRepository);
  @override
  Future<Either<Failure, User>> call(UserLogInParams param) async {
    return authRepository.loginWithEmailPassword(
      email: param.email,
      password: param.password,
    );
  }
}

class UserLogInParams {
  final String email;
  final String password;
  UserLogInParams({
    required this.email,
    required this.password,
  });
}
