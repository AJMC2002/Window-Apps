import 'package:flutter/material.dart';

import 'screens/branch/branch.dart';

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: BranchPage(topic: "Учёба"),
      debugShowCheckedModeBanner: false,
    );
  }
}
