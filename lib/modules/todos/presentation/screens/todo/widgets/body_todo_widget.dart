import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mangement/modules/todos/presentation/screens/todo/widgets/todo_list_widget.dart';

import '../../../../../../core/util/widgets/loading_circle_widget.dart';
import '../../../../../../core/util/widgets/message_widget.dart';
import '../../../todo_bloc/bloc/todos_bloc.dart';

class BodyTodoWidget extends StatelessWidget {
  const BodyTodoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<TodosBloc, TodosState>(
        builder: (context, state) {
          if (state is LoadingTodoState) {
            return const LoadingCircularProgressWidget();
          } else if (state is LoadedTodosState) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification &&
                    scrollNotification.metrics.pixels ==
                        scrollNotification.metrics.maxScrollExtent) {
                  context
                      .read<TodosBloc>()
                      .add(CheckIfNeedMoreTodoEvent(index: state.todos.length));
                }
                return false;
              },
              child: TodoListWidget(
                todos: state.todos,
                isPaginating: state.isLoadingMore,
              ),
            );
          } else if (state is ErrorTodoState) {
            return MessageWidget(message: state.message);
          }
          return const LoadingCircularProgressWidget();
        },
      ),
    );
  }
}
