import 'package:clean/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UseCase<SuccessType,Param> {
  Future<Either<Failure,SuccessType>> call(Param param);
}
class NoParams{}