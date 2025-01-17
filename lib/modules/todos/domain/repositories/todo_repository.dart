import 'package:dartz/dartz.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  // get todos by pagination
  Future<Either<Failure, List<TodoEntity>>> getTodosByPaginate(
      {required int skip, required int limit});
  // Mark: - (Create, Delete, Update)
  Future<Either<Failure, Unit>> deleteTodo(int id);
  Future<Either<Failure, Unit>> updateTodo(TodoEntity todo);
  Future<Either<Failure, Unit>> addTodo(TodoEntity todo);
}
