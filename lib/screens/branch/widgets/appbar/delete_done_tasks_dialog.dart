import 'package:flutter/material.dart';

class DeleteDoneTasksDialog extends StatelessWidget {
  const DeleteDoneTasksDialog({required this.removeDoneTasks});

  final VoidCallback removeDoneTasks;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(child: Text('Подтвердите удаление')),
      content:
          const Text('Удалить выполненные задачи? Это действие необратимо.'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            removeDoneTasks();
            Navigator.pop(context);
          },
          child: const Text('Ок'),
        ),
      ],
    );
  }
}
