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
              SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.only(
                    top: Config.floatingActionButtonHeight / 2,
                    left: 20,
                    right: 20,
                  ),
                  color: Colors.grey[50],
                  child: Column(
                    children: [
                      Text(
                        "Создано ${widget.task.datetime.toIso8601String()}",
                      ),
                      ListView.builder(
                          itemCount: widget.task.steps.length,
                          itemBuilder: ((context, index) => Card(
                                child: Row(
                                  children: [
                                    Text("X"),
                                    Text(widget.task.steps[i].name)
                                  ],
                                ),
                              )))
                    ],
                  ),
                ),
              )
            ],
          ),
          Positioned(
            top: 160.0 - Config.floatingActionButtonHeight / 2,
            right: kFloatingActionButtonMargin,
            child: FloatingActionButton(
              onPressed: () => setState(() {
                widget.switchDone(widget.task.id);
              }),
              child: Icon(widget.task.isDone ? Icons.close : Icons.check),
            ),
          ),
        ],
      ),
    );
  }
}
