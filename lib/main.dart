import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_mangement/core/theme/app_theme.dart';
import 'package:task_mangement/modules/authentication/presentation/bloc/auth/bloc/auth_bloc.dart';
import 'package:task_mangement/modules/authentication/presentation/screens/login_page.dart';
import 'package:task_mangement/modules/todos/presentation/screens/todo/todo_page.dart';
import 'core/util/settings.dart';
import 'dependency_container/dependency_injection.dart' as di;
import 'modules/todos/presentation/todo_bloc/bloc/todos_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  final bool isLoggedIn = await checkUserLoggedIn();
  runApp(TaskManagementApp(
    isLoggedIn: isLoggedIn,
  ));
}

class TaskManagementApp extends StatelessWidget {
  final bool isLoggedIn;
  const TaskManagementApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<TodosBloc>()..add(GetAllTodoEvent())),
        BlocProvider(create: (_) => di.sl<AuthBloc>()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: isLoggedIn ? const TodosPage() : const LoginPage()),
    );
  }
}
