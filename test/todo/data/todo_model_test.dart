import 'package:flutter_test/flutter_test.dart';
import 'package:task_mangement/modules/todos/data/models/todo_model.dart';

void main() {
  test('should be a valid Todo model from JSON', () {
    // Arrange
    final Map<String, dynamic> json = {
      'id': 1,
      'todo': 'Todo 1',
      'completed': false,
    };

    // Act
    final result = TodoModel.fromJson(json);

    // Assert
    expect(result, isA<TodoModel>());
    expect(result.id, 1);
    expect(result.todo, 'Todo 1');
    expect(result.completed, false);
  });
}
