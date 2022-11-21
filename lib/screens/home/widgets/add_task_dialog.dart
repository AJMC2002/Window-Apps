import 'package:flutter/material.dart';

import 'task_list.dart';

class AddTaskDialog extends StatelessWidget {
  AddTaskDialog({
    super.key,
    required this.taskListKey,
  });

  final TaskListKey taskListKey;

  final _formFieldKey = GlobalKey<FormFieldState>();
  final _maxTopicLength = 40;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
          child: Text(
        'Создать задачу',
        style: TextStyle(fontSize: 30),
      )),
      content: TextFormField(
        key: _formFieldKey,
        decoration: const InputDecoration(
          icon: Icon(Icons.add),
          hintText: 'Введите название задачи',
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
            taskListKey.currentState!.addTask(input!);
            Navigator.pop(context);
          }
        },
        onFieldSubmitted: (input) => _formFieldKey.currentState!.save(),
      ),
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
