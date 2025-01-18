import '../../../models/todo_model.dart';

abstract class TodoLocalDataSource {
  Future<void> addTodo(TodoModel todo);
  Future<void> deleteTodo(int id);
  Future<void> updateTodo(TodoModel todo);
  Future<List<TodoModel>> getTodosByPaginate({
    required int pageNumber,
    required int limit,
  });
  Future<void> cacheTodos(List<TodoModel> todos);
}
