import 'package:dartz/dartz.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/todos/data/datasource/local/abstract/local_abstract.dart';
import 'package:task_mangement/modules/todos/data/datasource/remote/abstract/todo_abstract_remote.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';
import 'package:task_mangement/modules/todos/domain/repositories/todo_repository.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/abstract/network_abstract.dart';
import '../../../../core/util/settings.dart';
import '../models/todo_model.dart';

typedef CRUDTodo = Future<Unit> Function();

class TodoRepositoryImplement implements TodoRepository {
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImplement(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> addTodo(TodoEntity todo) async {
    final TodoModel todoModel = TodoModel(id: todo.id, todo: todo.todo);
    return await _getMessage(() {
      return remoteDataSource.addTodo(todoModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteTodo(int id) async {
    return await _getMessage(() {
      return remoteDataSource.deleteTodo(id);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateTodo(TodoEntity todo) async {
    final TodoModel todoModel = TodoModel(id: todo.id, todo: todo.todo);
    return await _getMessage(() {
      return remoteDataSource.updateTodo(todoModel);
    });
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
        // Save fetched data to local storage for offline use
        await localDataSource.cacheTodos(result);

        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        // Fetch data from local storage if no network is available
        final localResult = await localDataSource.getTodosByPaginate(
          pageNumber: pageNumber,
          limit: limit,
        );
        return Right(localResult);
      } catch (e) {
        return Left(EmptyCacheFailure()); // Handle cache-related errors
      }
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
