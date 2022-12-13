import 'package:flutter/material.dart';

import '../../models/task.dart';

class TODOPage extends StatefulWidget {
  const TODOPage({super.key, required this.task});

  final Task task;

  @override
  State<TODOPage> createState() => _TODOPageState();
}

class _TODOPageState extends State<TODOPage> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
