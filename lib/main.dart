import 'package:flutter/material.dart';
import 'package:task_mangement/core/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home:  Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
