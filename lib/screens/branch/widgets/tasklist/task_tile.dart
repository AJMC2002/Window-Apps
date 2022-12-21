import 'package:flutter/material.dart';

import '../../../../models/task.dart';
import 'task_tile_icons.dart';

class TaskTile extends StatelessWidget {
  const TaskTile({
    super.key,
    required this.task,
    required this.switchDone,
    required this.switchFavorite,
    required this.removeTask,
  });

  final Task task;
  final ValueSetter<String> switchDone;
  final ValueSetter<String> switchFavorite;
  final Function removeTask;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => removeTask(task.id),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.all(15),
        child: const Icon(Icons.delete, size: 30),
      ),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Transform.scale(
                  scale: 1.3,
                  child: Checkbox(
                    shape: const CircleBorder(),
                    activeColor: Colors.deepPurple,
                    value: task.isDone,
                    onChanged: (_) => switchDone(task.id),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  task.title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: task.isFavorite
                      ? TaskTileIcons.favoriteIconSelected
                      : TaskTileIcons.favoriteIcon,
                  iconSize: 30,
                  isSelected: task.isFavorite,
                  onPressed: () => switchFavorite(task.id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
