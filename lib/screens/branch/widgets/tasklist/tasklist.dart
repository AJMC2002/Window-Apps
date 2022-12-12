import 'package:flutter/material.dart';

import '../../../../models/task.dart';
import 'task_tile.dart';

class TaskList extends StatelessWidget {
  const TaskList({
    super.key,
    required this.tasks,
    required this.switchDone,
    required this.switchFavorite,
    required this.removeTask,
  });

  final List<Task> tasks;
  final ValueSetter<String> switchDone;
  final ValueSetter<String> switchFavorite;
  final Function removeTask;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 30,
        left: 30,
        right: 30,
        bottom: kFloatingActionButtonMargin + 50,
      ),
      itemCount: tasks.length,
      itemBuilder: (context, index) => TaskTile(
        task: tasks[index],
        switchDone: switchDone,
        switchFavorite: switchFavorite,
        removeTask: removeTask,
      ),
      separatorBuilder: (context, index) => const SizedBox(height: 10),
    );
  }
}
