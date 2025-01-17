import 'package:dartz/dartz.dart';

import '../../../models/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodosByPaginate({
    required int pageNumber,
    required int limit,
  });

  Future<Unit> deleteTodo(int todoId);
  Future<Unit> updateTodo(TodoModel todo);
  Future<Unit> addTodo(TodoModel todo);
}