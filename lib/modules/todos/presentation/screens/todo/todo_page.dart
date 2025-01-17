import 'package:flutter/material.dart';
import 'package:task_mangement/modules/todos/presentation/screens/todo/widgets/body_todo_widget.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  AppBar _buildAppbar() => AppBar(
          title: const Text(
        'Todos',
        style: TextStyle(color: Colors.white),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: const BodyTodoWidget(),
    );
  }
}
