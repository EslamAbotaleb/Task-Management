import 'package:dartz/dartz.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';
import 'package:task_mangement/modules/todos/domain/repositories/todo_repository.dart';

import '../../../../core/error/failures.dart';

class AddTodoUsecase {
  final TodoRepository repository;

  AddTodoUsecase(this.repository);

  Future<Either<Failure, Unit>> call(TodoEntity todo) async {
    return await repository.addTodo(todo);
  }
}
