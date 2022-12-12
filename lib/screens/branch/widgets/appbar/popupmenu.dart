import 'package:flutter/material.dart';

import 'delete_done_tasks_dialog.dart';
import 'edit_topic_dialog.dart';

enum _BranchPopMenuItem {
  toggleHideDone, // Hide/Show Done
  toggleHideNonFavorite, // Hide/Show Non-Favorites
  delDone, // Delete Done
  editTopic, // Edit Topic
}

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
    return PopupMenuButton<_BranchPopMenuItem>(
      tooltip: 'Показать меню',
      color: Colors.grey[50],
      onSelected: (value) => _popUpMenuOnClick(context, value),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: _BranchPopMenuItem.toggleHideDone,
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
          value: _BranchPopMenuItem.toggleHideNonFavorite,
          child: ListTile(
            leading: Icon(
              requireFavorite ? Icons.star_border : Icons.star,
            ),
            title: Text(
              requireFavorite ? 'Все задачи' : 'Только избранные',
            ),
          ),
        ),
        const PopupMenuItem(
          value: _BranchPopMenuItem.delDone,
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Удалить выполненные'),
          ),
        ),
        const PopupMenuItem(
          value: _BranchPopMenuItem.editTopic,
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Редактировать тему'),
          ),
        ),
      ],
    );
  }

  void _popUpMenuOnClick(BuildContext context, _BranchPopMenuItem value) {
    switch (value) {
      case _BranchPopMenuItem.toggleHideDone:
        switchRequireNotDone();
        break;
      case _BranchPopMenuItem.toggleHideNonFavorite:
        switchRequireFavorite();
        break;
      case _BranchPopMenuItem.delDone:
        showDialog(
          context: context,
          builder: (context) =>
              DeleteDoneTasksDialog(removeDoneTasks: removeDoneTasks),
        );
        break;
      case _BranchPopMenuItem.editTopic:
        showDialog(
          context: context,
          builder: (context) => EditTopicDialog(
            topic: topic,
            editTopic: editTopic,
          ),
        );
        break;
    }
  }
}