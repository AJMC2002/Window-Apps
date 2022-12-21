import 'package:flutter/material.dart';

import '../screens/branch/branch_page.dart';
import 'config.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const BranchPage(topic: 'Учёба'),
      debugShowCheckedModeBanner: false,
    );
  }
}
