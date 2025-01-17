import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';

abstract class AuthRemoteDataSource {
  Future<LoginEntity>
}