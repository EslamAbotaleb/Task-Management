import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({required super.id, required super.todo, super.completed});
  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
      id: json["id"], todo: json["todo"], completed: json["completed"]);
  Map<String, dynamic> toJson() => {
        "id": id,
        "todo": todo,
        "completed": completed,
        "userId": userId,
      };
}
