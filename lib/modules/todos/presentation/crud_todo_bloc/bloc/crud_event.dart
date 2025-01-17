part of 'crud_bloc.dart';

sealed class CrudEvent extends Equatable {
  const CrudEvent();

  @override
  List<Object> get props => [];
}

//todo
class AddTodoEvent extends CrudEvent {
  final TodoEntity todo;
  const AddTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class UpdateTodoEvent extends CrudEvent {
  final TodoEntity todo;
  const UpdateTodoEvent({required this.todo});

  @override
  List<Object> get props => [todo];
}

class DeleteTodoEvent extends CrudEvent {
  final int todoId;
  const DeleteTodoEvent({required this.todoId});

  @override
  List<Object> get props => [todoId];
}
