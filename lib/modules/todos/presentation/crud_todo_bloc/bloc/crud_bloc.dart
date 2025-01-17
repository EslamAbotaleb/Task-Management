import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/util/constants.dart';
import '../../../domain/usecases/add_todo.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final AddTodoUsecase addTodo;

  CrudBloc({
    required this.addTodo,
  }) : super(CrudInitial()) {
    on<CrudEvent>((event, emit) async {
      if (event is AddTodoEvent) {
        emit(LoadingCrudState());

        final failureOrDoneMessage = await addTodo(event.todo);

        emit(
          _eitherDoneMessageOrErrorState(
              failureOrDoneMessage, ADD_SUCCESS_MESSAGE),
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
