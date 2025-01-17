import 'package:dartz/dartz.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/todos/data/datasource/remote/abstract/todo_abstract_remote.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';
import 'package:task_mangement/modules/todos/domain/repositories/todo_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/abstract/network_abstract.dart';
import '../models/todo_model.dart';

typedef CRUDTodo = Future<Unit> Function();

class TodoRepositoryImplement implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImplement(
      {required this.remoteDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addTodo(TodoEntity todo) async {
    final TodoModel todoModel = TodoModel(id: todo.id, todo: todo.todo);
    return await _getMessage(() {
      return remoteDataSource.addTodo(todoModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteTodo(int id) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, Unit>> updateTodo(TodoEntity todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<TodoEntity>>> getTodosByPaginate(
      {required int pageNumber, required int limit}) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTodosByPaginate(
          pageNumber: pageNumber,
          limit: limit,
        );
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  Future<Either<Failure, Unit>> _getMessage(CRUDTodo crudTodo) async {
    if (await networkInfo.isConnected) {
      try {
        await crudTodo();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
