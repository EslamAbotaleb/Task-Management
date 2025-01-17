import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mangement/modules/todos/presentation/crud_todo_bloc/bloc/crud_bloc.dart';

class DeleteDialogWidget extends StatelessWidget {
  final int todoId;
  const DeleteDialogWidget({
    Key? key,
    required this.todoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you Sure ?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text(
            "No",
          ),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<CrudBloc>(context).add(
              DeleteTodoEvent(todoId: todoId),
            );
          },
          child: const Text("Yes"),
        ),
      ],
    );
  }
}
