import 'package:flutter/material.dart';

import '../../../models/task.dart';

class TaskTile extends StatefulWidget {
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
  State<TaskTile> createState() => TaskTileState();
}

class TaskTileState extends State<TaskTile> {
  static const _favoriteIcon = Icon(
    Icons.star_border_purple500_outlined,
    color: Colors.deepPurple,
  );
  static const _favoriteIconSelected = Icon(
    Icons.star,
    color: Colors.deepPurpleAccent,
  );

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.task.id),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => widget.removeTask(widget.task.id),
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
                  scale: 1.25,
                  child: Checkbox(
                    shape: const CircleBorder(),
                    value: widget.task.isDone,
                    onChanged: (_) => widget.switchDone(widget.task.id),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  widget.task.title,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: IconButton(
                  icon: widget.task.isFavorite
                      ? _favoriteIconSelected
                      : _favoriteIcon,
                  iconSize: 30,
                  onPressed: () => widget.switchFavorite(widget.task.id),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
