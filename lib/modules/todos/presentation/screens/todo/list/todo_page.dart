
import 'package:flutter/material.dart';
import 'package:task_mangement/modules/todos/presentation/screens/todo/widgets/body_todo_widget.dart';
import '../crud/dialog_crud_widget.dart';

class TodosPage extends StatelessWidget {
  const TodosPage({super.key});

  AppBar _buildAppbar(BuildContext context) => AppBar(
        title: const Text(
          'Todos',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const DialogCrudWidget(isUpdateTodo: false,);
                  },
                );
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: const BodyTodoWidget(),
    );
  }
}