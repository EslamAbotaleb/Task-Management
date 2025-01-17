import 'package:dartz/dartz.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';
import 'package:task_mangement/modules/authentication/domain/repositories/auth_repository.dart';

import '../datasource/remote/auth_remote_data_source.dart';

class AuthLoginRepositoryImplement implements AuthenticationLoginRepository {
  final AuthRemoteDataSource authenticationDataSource;

  AuthLoginRepositoryImplement({required this.authenticationDataSource});

  @override
  Future<Either<Failure, LoginEntity>> login(
      {required String userName, required String password}) {
    throw UnimplementedError();
  }
}
