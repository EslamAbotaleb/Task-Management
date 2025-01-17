import '../../domain/entities/login_entity.dart';

abstract class AuthRemoteDataSource {
  Future<LoginEntity> login(
      {required String userName, required String password});
}
