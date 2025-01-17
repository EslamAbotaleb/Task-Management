import 'package:dartz/dartz.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';

import '../repositories/auth_repository.dart';

class AuthLoginUsecase {
  final AuthenticationLoginRepository repository;
  AuthLoginUsecase(this.repository);

  Future<Either<Failure, LoginEntity>> call(
      {required String userName, required String password}) async {
    return await repository.login(userName: userName, password: password);
  }
}
