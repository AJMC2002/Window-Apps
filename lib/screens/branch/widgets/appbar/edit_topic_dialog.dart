import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../app/config.dart';

class EditTopicDialog extends StatefulWidget {
  const EditTopicDialog({
    super.key,
    required this.topic,
    required this.editTopic,
  });

  final String topic;
  final ValueSetter<String> editTopic;

  @override
  State<EditTopicDialog> createState() => _EditTopicDialogState();
}

class _EditTopicDialogState extends State<EditTopicDialog> {
  final _formFieldKey = GlobalKey<FormFieldState>();

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
        initialValue: widget.topic,
        decoration: const InputDecoration(
          icon: Icon(Icons.edit),
          hintText: 'Введите название ветки',
        ),
        maxLength: Config.maxTopicTitleLength,
        maxLengthEnforcement: MaxLengthEnforcement.none,
        validator: (input) {
          if (input?.trim().isEmpty ?? true) {
            return 'Название не может быть пустым';
          } else if (input!.length > Config.maxTopicTitleLength) {
            return 'Слишком длинное название';
          } else {
            return null;
          }
        },
        onSaved: (input) {
          if (_formFieldKey.currentState!.validate()) {
            widget.editTopic(input!);
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
