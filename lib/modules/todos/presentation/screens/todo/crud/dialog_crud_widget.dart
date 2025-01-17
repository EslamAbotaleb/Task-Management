import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mangement/modules/todos/presentation/screens/todo/list/todo_page.dart';

import '../../../../../../core/util/widgets/loading_circle_widget.dart';
import '../../../../../../core/util/widgets/snackbar_message.dart';
import '../../../../domain/entities/todo_entity.dart';
import '../../../crud_todo_bloc/bloc/crud_bloc.dart';
import 'add_update_form_widget.dart';

class DialogCrudWidget extends StatelessWidget {
  final TodoEntity? todoEntity;
  final bool isUpdateTodo;

  const DialogCrudWidget(
      {super.key, this.todoEntity, required this.isUpdateTodo});

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: AlertDialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.black,
        insetPadding: EdgeInsets.zero,
        title: Align(
          alignment: Alignment.topRight,
          child: GestureDetector(
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.cancel_outlined,
                color: Colors.white,
                size: 30,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: BlocConsumer<CrudBloc, CrudState>(
            listener: (context, state) {
              if (state is MessageCrudState) {
                SnackBarMessage().showSuccessSnackBar(
                    message: state.message, context: context);
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const TodosPage()),
                    (route) => false);
              } else if (state is ErrorCrudState) {
                SnackBarMessage().showErrorSnackBar(
                    message: state.message, context: context);
              }
            },
            builder: (context, state) {
              if (state is LoadingCrudState) {
                return const LoadingCircularProgressWidget();
              }
              return AddUpdateFormWidget(
                isUpdateTodo: isUpdateTodo,
                todo: todoEntity,
              );
            },
          ),
        ),
      ),
    );
  }
}
