import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';

part 'todos_event.dart';
part 'todos_state.dart';

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  TodosBloc() : super(TodosInitial()) {
    on<TodosEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
