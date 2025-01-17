import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:task_mangement/core/error/failures.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';
import 'package:task_mangement/modules/todos/domain/usecases/todo_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:task_mangement/modules/todos/presentation/todo_bloc/bloc/todos_bloc.dart'; // For Either and Right/Left

// Mocking the GetTodosByPaginateUseCase
class MockGetTodosByPaginateUseCase extends Mock
    implements GetTodosByPaginateUseCase {}

void main() {
  late MockGetTodosByPaginateUseCase mockGetTodosByPaginateUseCase;
  late TodosBloc todosBloc;

  setUp(() {
    mockGetTodosByPaginateUseCase = MockGetTodosByPaginateUseCase();
    todosBloc =
        TodosBloc(todosByPaginateUseCase: mockGetTodosByPaginateUseCase);
  });

  group('TodosBloc', () {
    final tTodoList = [
      const TodoEntity(id: 1, todo: 'Do something nice for someone you care about"', completed: false),
    ];

    test('emits [LoadingTodoState, LoadedTodosState] when getting todos is successful',
        () async {
      // Arrange: Mock the use case to return a successful result
      when(() => mockGetTodosByPaginateUseCase(pageNumber: 0, limit: 10))
          .thenAnswer((_) async => Right(tTodoList));

      // Act: Add the event to load todos
      todosBloc.add(GetAllTodoEvent());

      // Assert: Check that the correct states are emitted
      await expectLater(
        todosBloc.stream,
        emitsInOrder([LoadingTodoState(), LoadedTodosState(todos: tTodoList)]),
      );

      // Verify the use case was called
      verify(() => mockGetTodosByPaginateUseCase(pageNumber: 0, limit: 10));
    });

    test('emits [LoadingTodoState, ErrorTodoState] when getting todos fails', () async {
      // Arrange: Mock the use case to return a failure
      when(() => mockGetTodosByPaginateUseCase(pageNumber: 0, limit: 10))
          .thenAnswer((_) async => Left(ServerFailure()));

      // Act: Add the event to load todos
      todosBloc.add(GetAllTodoEvent());

      // Assert: Check that the correct states are emitted
      await expectLater(
        todosBloc.stream,
        emitsInOrder([
          LoadingTodoState(),
          const ErrorTodoState(message: 'Try again later!!!')
        ]),
      );
      // Verify the use case was called
      verify(() => mockGetTodosByPaginateUseCase(pageNumber: 0, limit: 10));
    });
  });
}
