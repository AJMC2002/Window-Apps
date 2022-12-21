import 'package:flutter/material.dart';

import 'delete_done_tasks_dialog.dart';
import 'edit_topic_dialog.dart';

class BranchPopupMenu extends StatelessWidget {
  const BranchPopupMenu({
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
        _buildSwitchRequireNotDonePopupMenuItem(),
        _buildSwitchRequireFavoritePopupMenuItem(),
        _buildDeleteDoneTasksPopupMenuItem(context),
        _buildEditTopicPopupMenuItem(context),
      ],
    );
  }

  PopupMenuItem<dynamic> _buildSwitchRequireNotDonePopupMenuItem() {
    return PopupMenuItem(
      onTap: switchRequireNotDone,
      child: ListTile(
        leading: Icon(
          requireNotDone ? Icons.check_circle_outline : Icons.check_circle,
        ),
        title: Text(
          requireNotDone ? 'Показать выполненные' : 'Скрыть выполненные',
        ),
      ),
    );
  }

  PopupMenuItem<dynamic> _buildSwitchRequireFavoritePopupMenuItem() {
    return PopupMenuItem(
      onTap: switchRequireFavorite,
      child: ListTile(
        leading: Icon(
          requireFavorite ? Icons.star_border : Icons.star,
        ),
        title: Text(
          requireFavorite ? 'Все задачи' : 'Только избранные',
        ),
      ),
    );
  }

  PopupMenuItem<dynamic> _buildDeleteDoneTasksPopupMenuItem(
      BuildContext context) {
    return PopupMenuItem(
      onTap: () => _showDialog(
        context,
        DeleteDoneTasksDialog(removeDoneTasks: removeDoneTasks),
      ),
      child: const ListTile(
        leading: Icon(Icons.delete),
        title: Text('Удалить выполненные'),
      ),
    );
  }

  PopupMenuItem<dynamic> _buildEditTopicPopupMenuItem(BuildContext context) {
    return PopupMenuItem(
      onTap: () => _showDialog(
        context,
        EditTopicDialog(topic: topic, editTopic: editTopic),
      ),
      child: const ListTile(
        leading: Icon(Icons.edit),
        title: Text('Редактировать тему'),
      ),
    );
  }

  Future<dynamic> _showDialog(BuildContext context, Widget dialog) {
    /// Since the popup menu uses Navigator.pop(context) after a selection,
    /// the dialog would be popped immediately and won't show up.
    /// Using a Future it can be displayed after the popup menu is popped.
    /// ***
    /// Поскольку всплывающее меню использует Navigator.pop(context) после выбора,
    /// диалоговое окно будет немедленно закрыто и не будет отображаться.
    /// Используя Future, его можно отобразить после закрытия всплывающего меню.
    return Future.delayed(
      Duration.zero,
      () => showDialog(context: context, builder: (context) => dialog),
    );
  }
}
