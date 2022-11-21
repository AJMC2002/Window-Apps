import 'package:flutter/material.dart';

import 'task_list.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.requireNotDone,
    required this.switchRequireNotDone,
    required this.requireFav,
    required this.switchRequireFav,
    required this.taskListKey,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  final bool requireNotDone;
  final Function switchRequireNotDone;
  final bool requireFav;
  final Function switchRequireFav;
  final TaskListKey taskListKey;

  @override
  final Size preferredSize;

  @override
  State<HomeAppBar> createState() => _HomeAppBarState();
}

class _HomeAppBarState extends State<HomeAppBar> {
  String _topic = 'Учёба';

  void _editTopic(String newTopic) {
    setState(() {
      _topic = newTopic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(
        _topic,
        style: const TextStyle(fontSize: 30),
      ),
      actions: <Widget>[
        HomePopUpMenu(
          requireNotDone: widget.requireNotDone,
          switchRequireNotDone: widget.switchRequireNotDone,
          requireFav: widget.requireFav,
          switchRequireFav: widget.switchRequireFav,
          taskListKey: widget.taskListKey,
          topic: _topic,
          editTopic: _editTopic,
        ),
      ],
    );
  }
}

enum _HomePopMenuItem {
  showDone, // Hide/Show Done
  onlyFav, // Only Favourites
  delDone, // Delete Done
  editTopic, // Edit Topic
}

class HomePopUpMenu extends StatelessWidget {
  const HomePopUpMenu({
    super.key,
    required this.requireNotDone,
    required this.switchRequireNotDone,
    required this.requireFav,
    required this.switchRequireFav,
    required this.taskListKey,
    required this.topic,
    required this.editTopic,
  });

  final bool requireNotDone;
  final Function switchRequireNotDone;
  final bool requireFav;
  final Function switchRequireFav;
  final TaskListKey taskListKey;
  final String topic;
  final Function editTopic;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_HomePopMenuItem>(
      tooltip: 'Показать меню',
      color: Colors.grey[50],
      onSelected: (value) => _popUpMenuOnClick(context, value),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: _HomePopMenuItem.showDone,
          child: ListTile(
            leading: const Icon(Icons.check_circle),
            title: Text(
                requireNotDone ? 'Показать выполненные' : 'Скрыть выполненные'),
          ),
        ),
        PopupMenuItem(
          value: _HomePopMenuItem.onlyFav,
          child: ListTile(
            leading: const Icon(Icons.star),
            title: Text(requireFav ? 'Все задачи' : 'Только избранные'),
          ),
        ),
        const PopupMenuItem(
          value: _HomePopMenuItem.delDone,
          child: ListTile(
            leading: Icon(Icons.delete),
            title: Text('Удалить выполненные'),
          ),
        ),
        const PopupMenuItem(
          value: _HomePopMenuItem.editTopic,
          child: ListTile(
            leading: Icon(Icons.edit),
            title: Text('Редактировать тему'),
          ),
        ),
      ],
    );
  }

  void _popUpMenuOnClick(BuildContext context, _HomePopMenuItem value) {
    switch (value) {
      case _HomePopMenuItem.showDone:
        switchRequireNotDone();
        break;
      case _HomePopMenuItem.onlyFav:
        switchRequireFav();
        break;
      case _HomePopMenuItem.delDone:
        showDialog(
          context: context,
          builder: (context) => _DeleteDoneTasksDialog(
            taskListKey: taskListKey,
          ),
        );
        break;
      case _HomePopMenuItem.editTopic:
        showDialog(
          context: context,
          builder: (context) => _EditTopicDialog(
            topic: topic,
            editTopic: editTopic,
          ),
        );
        break;
    }
  }
}

class _DeleteDoneTasksDialog extends StatelessWidget {
  const _DeleteDoneTasksDialog({required this.taskListKey});

  final TaskListKey taskListKey;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Подтвердите удаление')),
      content:
          const Text('Удалить выполненные задачи? Это действие необратимо.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Отмена'),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            taskListKey.currentState!.removeDoneTasks();
            Navigator.pop(context, 'Ок');
          },
          child: const Text('Ок'),
        ),
      ],
    );
  }
}

class _EditTopicDialog extends StatelessWidget {
  _EditTopicDialog({
    required this.topic,
    required this.editTopic,
  });

  final String topic;
  final Function editTopic;

  final _formFieldKey = GlobalKey<FormFieldState>();
  final int _maxTopicLength = 40;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
          child: Text(
        'Редактировать ветку',
        style: TextStyle(fontSize: 30),
      )),
      content: TextFormField(
          key: _formFieldKey,
          initialValue: topic,
          decoration: const InputDecoration(
            icon: Icon(Icons.edit),
            hintText: 'Введите название ветки',
          ),
          buildCounter: (
            context, {
            required currentLength,
            required isFocused,
            maxLength,
          }) =>
              Text('$currentLength/$_maxTopicLength'),
          validator: (input) {
            if (input?.trim().isEmpty ?? true) {
              return 'Название не может быть пустым';
            } else if (input!.length > _maxTopicLength) {
              return 'Слишком длинное название';
            } else {
              return null;
            }
          },
          onSaved: (input) {
            if (_formFieldKey.currentState!.validate()) {
              editTopic(input);
              Navigator.pop(context);
            }
          },
          onFieldSubmitted: (input) => _formFieldKey.currentState!.save()),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () => _formFieldKey.currentState!.save(),
          child: const Text('Ок'),
        ),
      ],
    );
  }
}
