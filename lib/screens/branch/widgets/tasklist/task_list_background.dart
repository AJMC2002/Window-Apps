import 'package:flutter/material.dart';

import 'task_list_config.dart';

class TaskListBackground extends StatelessWidget {
  const TaskListBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: TaskListConfig.taskListBackgroundPadding,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:
          MediaQuery.of(context).size.height ~/ TaskListConfig.taskTileHeight +
              1,
      itemBuilder: (context, index) => Container(
        width: MediaQuery.of(context).size.width,
        height: TaskListConfig.taskTileHeight +
            (TaskListConfig.taskTileSeparation +
                    TaskListConfig.taskTileDivisorHeight) /
                2,
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.deepPurpleAccent.shade100,
              width: TaskListConfig.taskTileDivisorHeight,
            ),
          ),
        ),
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: (TaskListConfig.taskTileSeparation -
                TaskListConfig.taskTileDivisorHeight) /
            2,
      ),
    );
  }
}
