import 'package:flutter/material.dart';
import 'package:task_mangement/core/util/widgets/loading_circle_widget.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';
import 'package:task_mangement/modules/todos/presentation/screens/todo/crud/dialog_crud_widget.dart';

class TodoListWidget extends StatelessWidget {
  final List<TodoEntity> todos;
  final bool isPaginating;

  const TodoListWidget({
    super.key,
    required this.todos,
    required this.isPaginating,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length + (isPaginating ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < todos.length) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            elevation: 2,
            child: ListTile(
              leading: Icon(
                todos[index].completed == true ? Icons.check : Icons.pending,
                color:
                    todos[index].completed == true ? Colors.green : Colors.red,
              ),
              title: Text(
                todos[index].todo,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'ID: ${todos[index].id}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return DialogCrudWidget(
                      isUpdateTodo: true,
                      todoEntity: todos[index],
                    );
                  },
                );
              },
            ),
          );
        } else {
          return const LoadingCircularProgressWidget();
        }
      },
    );
  }
}
