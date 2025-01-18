import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mangement/modules/todos/domain/entities/todo_entity.dart';
import 'package:task_mangement/modules/todos/presentation/crud_todo_bloc/bloc/crud_bloc.dart';

import '../../../../../../core/theme/app_theme.dart';
import 'delete/delete_todo_btn_widget.dart';

class CRUDTodoWidget extends StatefulWidget {
  final bool isUpdateTodo;
  final TodoEntity? todo;
  const CRUDTodoWidget({
    super.key,
    required this.isUpdateTodo,
    this.todo,
  });

  @override
  State<CRUDTodoWidget> createState() => _FormWidgetState();
}

class _FormWidgetState extends State<CRUDTodoWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    if (widget.isUpdateTodo) {
      _todoController.text = widget.todo?.todo ?? "";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(10),
              child: TextFormField(
                controller: _todoController,
                maxLength: null,
                decoration: InputDecoration(
                  hintText: 'Todo',
                  hintStyle: const TextStyle(
                      fontSize: 15.0,
                      color: Color(0xffA9A9A9),
                      fontWeight: FontWeight.w500),
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter todo';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 16.0,
            ),
            widget.isUpdateTodo == true
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      DeleteTodoBtnWidget(
                        todoId: widget.todo?.id ?? 0,
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                          ),
                          onPressed: validateFormThenUpdateOrAddTodo,
                          icon: widget.isUpdateTodo
                              ? const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                          label: Text(
                            widget.isUpdateTodo ? "Edit" : "Add",
                            style: const TextStyle(color: Colors.white),
                          ))
                    ],
                  )
                : ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    onPressed: validateFormThenUpdateOrAddTodo,
                    icon: widget.isUpdateTodo
                        ? const Icon(
                            Icons.edit,
                            color: Colors.white,
                          )
                        : const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                    label: Text(
                      widget.isUpdateTodo ? "Edit" : "Add",
                      style: const TextStyle(color: Colors.white),
                    ))
          ]),
    );
  }

  void validateFormThenUpdateOrAddTodo() {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final todo = TodoEntity(
          id: widget.isUpdateTodo ? (widget.todo?.id ?? 0) : 0,
          todo: _todoController.text);

      if (widget.isUpdateTodo) {
        BlocProvider.of<CrudBloc>(context).add(UpdateTodoEvent(todo: todo));
      } else {
        BlocProvider.of<CrudBloc>(context).add(AddTodoEvent(todo: todo));
      }
    }
  }
}
