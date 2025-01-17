import 'package:dartz/dartz.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';
import 'package:task_mangement/modules/todos/domain/repositories/todo_repository.dart';

class TodoRepositoryImplement implements TodoRepository {
  @override
  Future<Either<Failure, Unit>> addTodo(TodoEntity todo) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> deleteTodo(int id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodosByPaginate({required int skip, required int limit}) {
    // TODO: implement getTodosByPaginate
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateTodo(TodoEntity todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
  
}