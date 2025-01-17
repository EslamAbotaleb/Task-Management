part of 'todos_bloc.dart';

sealed class TodosEvent extends Equatable {
  const TodosEvent();

  @override
  List<Object> get props => [];
}

class GetAllTodoEvent extends TodosEvent {}

class CheckIfNeedMoreTodoEvent extends TodosEvent {
  final int index;
  const CheckIfNeedMoreTodoEvent({required this.index});

  @override
  List<Object> get props => [index];
}
