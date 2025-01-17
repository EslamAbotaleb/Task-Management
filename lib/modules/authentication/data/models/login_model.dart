import 'package:task_mangement/modules/authentication/domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  LoginModel({required super.id});
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(id: json["id"]);
  @override
  Map<String, dynamic> toJson() => {"id": id};
}