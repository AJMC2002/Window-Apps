import 'package:flutter/material.dart';

import '../../models/task.dart';
import 'widgets/tasklist/empty_tasklist.dart';
import 'widgets/appbar/appbar.dart';
import 'widgets/fab/add_task_dialog.dart';
import 'widgets/tasklist/tasklist.dart';

class BranchPage extends StatefulWidget {
  BranchPage({super.key, required this.topic});

  String topic;

  @override
  State<BranchPage> createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage> {
  void _editTopic(String newTopic) {
    setState(() {
      widget.topic = newTopic;
    });
  }

  final List<Task> _allTasks = [];

  void _switchDone(String id) {
    setState(() {
      for (var i = 0; i < _allTasks.length; i++) {
        if (_allTasks[i].id == id) {
          _allTasks[i].isDone = !_allTasks[i].isDone;
        }
      }
      _updateValidTasks();
    });
  }

  void _switchFavorite(String id) {
    setState(() {
      for (var i = 0; i < _allTasks.length; i++) {
        if (_allTasks[i].id == id) {
          _allTasks[i].isFavorite = !_allTasks[i].isFavorite;
        }
      }
      _updateValidTasks();
    });
  }

  void _addTask(String title) {
    setState(() {
      _allTasks.add(Task(title: title));
      _updateValidTasks();
    });
  }

  void _removeTask(String id) {
    setState(() {
      _allTasks.removeWhere((task) => task.id == id);
      _updateValidTasks();
    });
  }

  void _removeDoneTasks() {
    setState(() {
      _allTasks.removeWhere((task) => task.isDone);
      _updateValidTasks();
    });
  }

  late final List<Task> _validTasks = [];

  void _updateValidTasks() {
    setState(
      () {
        _validTasks.clear();
        for (int i = 0; i < _allTasks.length; i++) {
          if (!(_requireNotDone && _allTasks[i].isDone) &&
              (!_requireFavorite || _allTasks[i].isFavorite)) {
            _validTasks.add(_allTasks[i]);
          }
        }
      },
    );
  }

  bool _requireNotDone = false;

  void _switchRequireNotDone() {
    setState(() {
      _requireNotDone = !_requireNotDone;
      _updateValidTasks();
    });
  }

  bool _requireFavorite = false;

  void _switchRequireFavorite() {
    setState(() {
      _requireFavorite = !_requireFavorite;
      _updateValidTasks();
    });
  }

  @override
  void initState() {
    super.initState();
    for (int i = 1; i < 21; i++) {
      _allTasks.add(Task(title: 'Task $i'));
    }
    _updateValidTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: BranchAppBar(
        requireNotDone: _requireNotDone,
        switchRequireNotDone: _switchRequireNotDone,
        requireFavorite: _requireFavorite,
        switchRequireFavorite: _switchRequireFavorite,
        removeDoneTasks: _removeDoneTasks,
        topic: widget.topic,
        editTopic: _editTopic,
      ),
      body: Stack(
        children: <Widget>[
          _validTasks.isEmpty ? const EmptyTaskList() : Container(),
          TaskList(
            tasks: _validTasks,
            switchDone: _switchDone,
            switchFavorite: _switchFavorite,
            removeTask: _removeTask,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Добавить',
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTaskDialog(
            addTask: _addTask,
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
