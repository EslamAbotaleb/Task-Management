import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:task_mangement/core/error/exceptions.dart';
import 'package:task_mangement/core/util/constants.dart';
import 'package:task_mangement/modules/todos/data/datasource/remote/abstract/todo_abstract_remote.dart';
import 'package:task_mangement/modules/todos/data/models/todo_model.dart';

import 'package:http/http.dart' as http;

import '../../../../../core/util/settings.dart';

class TodoRemoteDataSourceImplementation implements TodoRemoteDataSource {
  final http.Client client;

  TodoRemoteDataSourceImplementation({required this.client});

  @override
  Future<Unit> addTodo(TodoModel todo) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteTodo(int todoId) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateTodo(TodoModel todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }

  @override
  Future<List<TodoModel>> getTodosByPaginate(
      {required int pageNumber, required int limit}) async {
    final skip = pageNumber * limit;
    final response =
        await client.get(Uri.parse("$BASE_URL/todos?limit=$limit&skip=$skip"));
    try {
      final decodedJson = json.decode(response.body) as Map<String, dynamic>;
      final todosJson = decodedJson.values.firstWhere(
        (value) => value is List,
        orElse: () => [],
      ) as List;
      final todoList = todosJson
          .map((jsonTodoModel) => TodoModel.fromJson(jsonTodoModel))
          .toList();
      return todoList;
    } catch (error) {
      logger.d("Error parsing data: $error");
      throw ServerException();
    }
  }
}
