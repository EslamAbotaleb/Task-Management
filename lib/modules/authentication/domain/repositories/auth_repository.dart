import 'package:dartz/dartz.dart';
import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';
import '../../../../core/error/failures.dart';

abstract class AuthenticationLoginRepository {
  Future<Either<Failure, LoginEntity>> login({required String userName, required String password});
}