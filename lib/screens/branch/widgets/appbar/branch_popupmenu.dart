import 'package:flutter/material.dart';

import 'delete_done_tasks_dialog.dart';
import 'edit_topic_dialog.dart';

class BranchPopUpMenu extends StatelessWidget {
  const BranchPopUpMenu({
    super.key,
    required this.requireNotDone,
    required this.switchRequireNotDone,
    required this.requireFavorite,
    required this.switchRequireFavorite,
    required this.removeDoneTasks,
    required this.topic,
    required this.editTopic,
  });

  final bool requireNotDone;
  final VoidCallback switchRequireNotDone;
  final bool requireFavorite;
  final VoidCallback switchRequireFavorite;
  final VoidCallback removeDoneTasks;
  final String topic;
  final ValueSetter<String> editTopic;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      tooltip: 'Показать меню',
      color: Colors.grey[50],
      itemBuilder: (context) => [
        PopupMenuItem(
          onTap: switchRequireNotDone,
          child: ListTile(
            leading: Icon(
              requireNotDone ? Icons.check_circle_outline : Icons.check_circle,
            ),
            title: Text(
              requireNotDone ? 'Показать выполненные' : 'Скрыть выполненные',
            ),
          ),
        ),
        PopupMenuItem(
          onTap: switchRequireFavorite,
          child: ListTile(
            leading: Icon(
              requireFavorite ? Icons.star_border : Icons.star,
            ),
            title: Text(
              requireFavorite ? 'Все задачи' : 'Только избранные',
            ),
          ),
        ),
        PopupMenuItem(
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => showDialog(
              context: context,
              builder: (context) =>
                  DeleteDoneTasksDialog(removeDoneTasks: removeDoneTasks),
            ),
          ),
          child: const ListTile(
            leading: Icon(Icons.delete),
            title: Text('Удалить выполненные'),
          ),
        ),
        PopupMenuItem(
          onTap: () => Future.delayed(
            const Duration(seconds: 0),
            () => showDialog(
              context: context,
              builder: (context) => EditTopicDialog(
                topic: topic,
                editTopic: editTopic,
              ),
            ),
          ),
          child: const ListTile(
            leading: Icon(Icons.edit),
            title: Text('Редактировать тему'),
          ),
        ),
      ],
    );
  }
}
