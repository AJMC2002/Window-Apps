import 'package:flutter/material.dart';

class EditTopicDialog extends StatelessWidget {
  EditTopicDialog({
    required this.topic,
    required this.editTopic,
  });

  final String topic;
  final ValueSetter<String> editTopic;

  final _formFieldKey = GlobalKey<FormFieldState>();
  final int _maxTopicLength = 40;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          'Редактировать ветку',
          style: TextStyle(fontSize: 30),
        ),
      ),
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
            editTopic(input!);
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
