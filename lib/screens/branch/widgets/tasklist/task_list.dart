import 'package:flutter/material.dart';

import '../../../../models/task.dart';
import 'task_list_config.dart';
import 'task_tile.dart';

class TaskList extends StatelessWidget {
  TaskList({
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
      padding: TaskListConfig.taskListPadding,
      itemCount: tasks.length,
      itemBuilder: (context, index) => TaskTile(
        task: tasks[index],
        switchDone: switchDone,
        switchFavorite: switchFavorite,
        removeTask: removeTask,
      ),
      separatorBuilder: (context, index) =>
          const SizedBox(height: TaskListConfig.taskTileSeparation),
    );
  }
}
