import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddTaskDialog extends StatefulWidget {
  AddTaskDialog({
    super.key,
    required this.addTask,
  });

  final ValueSetter<String> addTask;

  @override
  State<AddTaskDialog> createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  static const _maxTopicLength = 40;
  final _formFieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 50),
      title: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: Center(
          child: Text(
            'Создать задачу',
            style: TextStyle(fontSize: 30),
          ),
        ),
      ),
      content: TextFormField(
        key: _formFieldKey,
        decoration: const InputDecoration(
          icon: Icon(Icons.add),
          hintText: 'Введите название задачи',
        ),
        maxLength: _maxTopicLength,
        maxLengthEnforcement: MaxLengthEnforcement.none,
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
            widget.addTask(input!);
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
