part of 'todos_bloc.dart';

sealed class TodosState extends Equatable {
  const TodosState();

  @override
  List<Object> get props => [];
}

final class TodosInitial extends TodosState {}

//Loading
class LoadingTodoState extends TodosState {}

//Loaded
class LoadedTodosState extends TodosState {
  final List<TodoEntity> todos;
  final bool isLoadingMore; // New flag to indicate footer loading

  const LoadedTodosState({required this.todos, this.isLoadingMore = false});
  @override
  List<Object> get props => [todos, isLoadingMore];
}

//Error
class ErrorTodoState extends TodosState {
  final String message;
  const ErrorTodoState({required this.message});
  @override
  List<Object> get props => [message];
}
