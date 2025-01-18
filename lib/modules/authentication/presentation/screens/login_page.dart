import 'package:flutter/material.dart';
import 'package:task_mangement/modules/authentication/presentation/screens/body_login_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const BodyLoginWidget(),
    );
  }
}
