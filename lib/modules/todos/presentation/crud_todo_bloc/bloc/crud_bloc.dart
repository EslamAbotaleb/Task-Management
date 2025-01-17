import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/util/constants.dart';
import '../../../domain/usecases/add_todo.dart';
import '../../../domain/usecases/delete_todo.dart';
import '../../../domain/usecases/update_todo.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final AddTodoUsecase addTodo;
  final DeleteTodoUsecase deleteTodo;
  final UpdateTodoUsecase updateTodo;

  CrudBloc(
      {required this.addTodo,
      required this.deleteTodo,
      required this.updateTodo})
      : super(CrudInitial()) {
    on<CrudEvent>((event, emit) async {
      if (event is AddTodoEvent) {
        emit(LoadingCrudState());
        final failureOrDoneMessage = await addTodo(event.todo);
        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
        );
      } else if (event is UpdateTodoEvent) {
        emit(LoadingCrudState());

        final failureOrDoneMessage = await updateTodo(event.todo);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, UPDATE_SUCCESS_MESSAGE),
        );
      } else if (event is DeleteTodoEvent) {
        emit(LoadingCrudState());

        final failureOrDoneMessage = await deleteTodo(event.todoId);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, DELETE_SUCCESS_MESSAGE),
        );
      }
    });
  }
  CrudState _eitherDoneMessageOrErrorState(
      Either<Failure, Unit> either, String message) {
    return either.fold(
      (failure) => ErrorCrudState(
        message: _mapFailureToMessage(failure),
      ),
      (_) => MessageCrudState(message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure _:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
