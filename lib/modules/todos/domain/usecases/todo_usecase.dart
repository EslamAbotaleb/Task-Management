import 'package:dartz/dartz.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';
import 'package:task_mangement/modules/todos/domain/repositories/todo_repository.dart';

import '../../../../core/error/failures.dart';

class GetTodosByPaginateUseCase {
  final TodoRepository repository;

  GetTodosByPaginateUseCase({required this.repository});

  Future<Either<Failure, List<TodoEntity>>> call({
    required int pageNumber,
    required int limit,
  }) async {
    return await repository.getTodosByPaginate(
      limit: limit,
      pageNumber: pageNumber,
    );
  }
}
