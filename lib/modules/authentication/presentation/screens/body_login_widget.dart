import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mangement/core/util/widgets/loading_circle_widget.dart';
import 'package:task_mangement/modules/authentication/presentation/screens/form_login_widget.dart';

import '../../../../core/util/widgets/message_widget.dart';
import '../../../todos/presentation/screens/todo/todo_page.dart';
import '../bloc/auth/bloc/auth_bloc.dart';

class BodyLoginWidget extends StatelessWidget {
  const BodyLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return const LoadingCircularProgressWidget();
          } else if (state is AuthSuccess) {
            // Navigate to the todos screen after a successful login
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const TodosPage()),
              );
            });
          } else if (state is AuthError) {
            return MessageWidget(message: state.message); // Show error message
          }
          return FormLoginWidget(); // Show the login form when the state is AuthInitial
        },
      ),
    );
  }
}
