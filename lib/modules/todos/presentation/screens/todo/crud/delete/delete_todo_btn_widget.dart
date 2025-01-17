import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mangement/core/util/widgets/loading_circle_widget.dart';
import 'package:task_mangement/modules/todos/presentation/crud_todo_bloc/bloc/crud_bloc.dart';
import 'package:task_mangement/modules/todos/presentation/screens/todo/list/todo_page.dart';

import '../../../../../../../core/util/widgets/snackbar_message.dart';
import 'delete_dialog_widget.dart';

class DeleteTodoBtnWidget extends StatelessWidget {
  final int todoId;
  const DeleteTodoBtnWidget({
    Key? key,
    required this.todoId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(
          Colors.redAccent,
        ),
      ),
      onPressed: () => deleteDialog(context, todoId),
      icon: const Icon(
        Icons.delete_outline,
        color: Colors.white,
      ),
      label: const Text(
        "Delete",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void deleteDialog(BuildContext context, int postId) {
    showDialog(
        context: context,
        builder: (context) {
          return BlocConsumer<CrudBloc, CrudState>(
            listener: (context, state) {
              if (state is MessageCrudState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);

                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const TodosPage(),
                    ),
                    (route) => false);
              } else if (state is ErrorCrudState) {
                Navigator.of(context).pop();
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingCrudState) {
                return const AlertDialog(
                  title: LoadingCircularProgressWidget(),
                );
              }
              return DeleteDialogWidget(todoId: todoId);
            },
          );
        });
  }
}
