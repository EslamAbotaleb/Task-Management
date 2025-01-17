import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/util/settings.dart';
import '../../abstract/auth_abstract.dart';

class AuthRemoteDataSourceImplementation implements AuthRemoteDataSource {
  final http.Client clientSide;
  final storage = const FlutterSecureStorage();
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
      await storage.write(key: 'accessToken', value: loginEntity.accessToken);
      await storage.write(key: 'userId', value: "${loginEntity.id}");
      return loginEntity;
    } else {
      throw ServerException();
    }
  }
}
