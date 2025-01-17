import 'package:dartz/dartz.dart';
import 'package:task_mangement/modules/todos/domain/repositories/todo_repository.dart';

import '../../../../core/error/failures.dart';

class DeleteTodoUsecase {
  final TodoRepository repository;

  DeleteTodoUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deleteTodo(postId);
  }
}