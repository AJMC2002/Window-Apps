import 'package:flutter/material.dart';
import 'screens/home/home.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.purple[100],
        listTileTheme: ListTileThemeData(
          tileColor: Colors.grey[50],
        ),
        checkboxTheme: const CheckboxThemeData(
          shape: CircleBorder(),
        ),
      ),
      home: const TaskHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

