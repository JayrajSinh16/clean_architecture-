import 'package:clean/core/error/failures.dart';
import 'package:clean/core/usecase/usecase.dart';
import 'package:clean/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignUp implements UseCase<String, UserSignUpParam> {
  final AuthRepository authRepository;
  const UserSignUp(this.authRepository);

  @override
  Future<Either<Failure, String>> call(UserSignUpParam param) async {
    return await authRepository.signUpWithEmailPassword(
      name: param.name,
      email: param.email,
      password: param.password,
    );
  }
}

class UserSignUpParam {
  final String email;
  final String password;
  final String name;
  UserSignUpParam({
    required this.email,
    required this.password,
    required this.name,
  });
}
