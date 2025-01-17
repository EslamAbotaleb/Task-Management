import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final int id;
  final String todo;
  final bool? completed;
  final int? userId;

  const TodoEntity(
      {required this.id, required this.todo, this.completed, this.userId});
      
  @override
  List<Object?> get props => [id, todo];
}
