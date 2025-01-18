import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';

class TodoModel extends TodoEntity {
  const TodoModel({required super.id, required super.todo, super.completed});

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json["id"],
      todo: json["todo"],
      completed: json["completed"] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "todo": todo,
      "completed": completed == true ? 1 : 0,
      "userId": userId,
    };
  }
}
