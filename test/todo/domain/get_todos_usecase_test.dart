import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart'; // Add this import for Either and Right
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';
import 'package:task_mangement/modules/todos/domain/repositories/todo_repository.dart';
import 'package:task_mangement/modules/todos/domain/usecases/todo_usecase.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late GetTodosByPaginateUseCase useCase;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    useCase = GetTodosByPaginateUseCase(mockTodoRepository);
  });

  group('GetTodosUseCase', () {
    final tTodoList = [
      const TodoEntity(id: 1, todo: 'Todo 1', completed: false),
    ];

    test('should return a list of todos from the repository', () async {
      // Arrange: Mock the repository method to return a Future<Either<Failure, List<TodoEntity>>>
      when(() =>
              mockTodoRepository.getTodosByPaginate(pageNumber: 3, limit: 10))
          .thenAnswer((_) async => Right(tTodoList));

      // Act
      final result = await useCase(pageNumber: 3, limit: 10);

      // Assert
      expect(
          result, Right(tTodoList)); // Expect the result to be wrapped in Right
      verify(() =>
          mockTodoRepository.getTodosByPaginate(pageNumber: 3, limit: 10));
    });

    test('should return a failure when the repository fails', () async {
      // Arrange: Mock the repository method to return a Failure in the Left side of Either
      when(() =>
              mockTodoRepository.getTodosByPaginate(pageNumber: 3, limit: 10))
          .thenAnswer(
              (_) async => Left(ServerFailure())); // Use Left for failure

      // Act
      final result = await useCase(pageNumber: 3, limit: 10);

      // Assert
      expect(result,
          Left(ServerFailure())); // Expect the result to be Left with a failure
      verify(() =>
          mockTodoRepository.getTodosByPaginate(pageNumber: 3, limit: 10));
    });
  });
}
