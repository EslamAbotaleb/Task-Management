import 'package:flutter/material.dart';
import 'package:task_mangement/modules/authentication/presentation/screens/body_login_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login', style: TextStyle(color: Colors.white),),
      ),
      body: const BodyLoginWidget(),
    );
  }
}
