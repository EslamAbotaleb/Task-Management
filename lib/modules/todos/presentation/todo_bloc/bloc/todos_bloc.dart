import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/util/constants.dart';
import '../../../domain/usecases/todo_usecase.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  final GetTodosByPaginateUseCase todosByPaginateUseCase;
  bool isLastPage = false;
  bool isLoadingMore = false;
  int pageNumber = 0;
  final int numberOfTodoPerRequest = 10;
  List<TodoEntity> todos = [];
  final int nextPageTrigger = 3;

  TodosBloc({required this.todosByPaginateUseCase}) : super(TodosInitial()) {
    on<TodosEvent>((event, emit) async {
      if (event is GetAllTodoEvent) {
        if (pageNumber == 0) {
          emit(LoadingTodoState());
        } else {
          // Pagination: Keep old content and show footer loader
          emit(LoadedTodosState(todos: todos, isLoadingMore: true));
        }
        final Either<Failure, List<TodoEntity>> result =
            await todosByPaginateUseCase(
                pageNumber: pageNumber, limit: numberOfTodoPerRequest);
        result.fold(
          (failure) {
            emit(ErrorTodoState(message: _mapFailtureToMessage(failure)));
          },
          (postList) {
            if (postList.isEmpty) {
              isLastPage = true;
            } else {
              pageNumber++; // Increment page number for the next request
              todos.addAll(postList);
            }
            emit(LoadedTodosState(todos: todos, isLoadingMore: false));
          },
        );
      }
      if (event is CheckIfNeedMoreTodoEvent) {
        if (event.index >= todos.length - nextPageTrigger && !isLastPage) {
          add(GetAllTodoEvent()); // Trigger fetching the next page
        }
      }
    });
  }
  String _mapFailtureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Try again later!!!";
    }
  }
}
