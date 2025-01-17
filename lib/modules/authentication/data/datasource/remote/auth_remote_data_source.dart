import 'dart:convert';

import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';
import 'package:http/http.dart' as http;

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/util/settings.dart';

abstract class AuthRemoteDataSource {
  Future<LoginEntity> login(
      {required String userName, required String password});
}

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final http.Client clientSide;
  AuthRemoteDataSourceImplementation({required this.clientSide});

  @override
  Future<LoginEntity> login(
      {required String userName, required String password}) async {
    final body = {"username": userName, "password": password};
    final response =
        await clientSide.post(Uri.parse("$BASE_URL/auth/login"), body: body);
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body) as Map<String, dynamic>;
      final loginEntity = LoginEntity.fromJson(decodedJson);
      return loginEntity;
    } else {
      throw ServerException();
    }
  }
}
