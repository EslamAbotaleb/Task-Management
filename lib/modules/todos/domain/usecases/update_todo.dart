import 'package:dartz/dartz.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';

import '../../../../core/error/failures.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoUsecase {
  final TodoRepository repository;

  UpdateTodoUsecase(this.repository);

  Future<Either<Failure, Unit>> call(TodoEntity todo) async {
    return await repository.updateTodo(todo);
  }
}
