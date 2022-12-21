import 'package:flutter/material.dart';

import '../../app/config.dart';
import '../../models/task.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({
    super.key,
    required this.task,
    required this.switchDone,
  });

  final Task task;
  final ValueSetter<String> switchDone;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: true,
                expandedHeight: 160.0,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(widget.task.title),
                  background: Container(color: Colors.purple),
                ),
              ),
            ],
          ),
          Positioned(
            top: 160.0 - Config.floatingActionButtonHeight / 2,
            right: kFloatingActionButtonMargin,
            child: FloatingActionButton(
              onPressed: () => setState(() {
                widget.switchDone(widget.task.id);
              }),
              child: Icon(widget.task.isDone ? Icons.check : Icons.close),
            ),
          )
        ],
      ),
    );
  }
}
