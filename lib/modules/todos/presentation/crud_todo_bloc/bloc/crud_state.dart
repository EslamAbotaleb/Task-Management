part of 'crud_bloc.dart';

sealed class CrudState extends Equatable {
  const CrudState();

  @override
  List<Object> get props => [];
}

final class CrudInitial extends CrudState {}

class LoadingCrudState extends CrudState {}

class ErrorCrudState extends CrudState {
  final String message;

  const ErrorCrudState({required this.message});

  @override
  List<Object> get props => [message];
}

class MessageCrudState extends CrudState {
  final String message;

  const MessageCrudState({required this.message});

  @override
  List<Object> get props => [message];
}
