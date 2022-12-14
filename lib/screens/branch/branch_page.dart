import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/task.dart';
import 'widgets/appbar/branch_popupmenu.dart';
import 'widgets/tasklist/empty_task_list.dart';
import 'widgets/fab/add_task_dialog.dart';
import 'widgets/tasklist/task_list.dart';
import 'widgets/tasklist/task_list_background.dart';

class BranchPage extends StatefulWidget {
  const BranchPage({super.key, required this.topic, required this.uuid});

  final String topic;
  final Uuid uuid;

  @override
  State<BranchPage> createState() => _BranchPageState();
}

class _BranchPageState extends State<BranchPage> {
  String _topic = "";
  final List<Task> _allTasks = [];
  List<Task> _displayedTasks = [];
  bool _requireNotDone = false;
  bool _requireFavorite = false;

  void _editTopic(String newTopic) {
    setState(() {});
    _topic = newTopic;
  }

  int _getIndex(String id) {
    return _allTasks.indexWhere((task) => task.id == id);
  }

  void _switchDone(String id) {
    int i = _getIndex(id);
    _allTasks[i] = _allTasks[i].copyWith(isDone: !_allTasks[i].isDone);
    _updateDisplayedTasks();
  }

  void _switchFavorite(String id) {
    int i = _getIndex(id);
    _allTasks[i] = _allTasks[i].copyWith(isFavorite: !_allTasks[i].isFavorite);
    _updateDisplayedTasks();
  }

  void _addTask(String title) {
    _allTasks.add(
      Task(
        id: widget.uuid.v4(),
        title: title,
      ),
    );
    _updateDisplayedTasks();
  }

  void _removeTask(String id) {
    _allTasks.removeWhere((task) => task.id == id);
    _updateDisplayedTasks();
  }

  void _removeDoneTasks() {
    _allTasks.removeWhere((task) => task.isDone);
    _updateDisplayedTasks();
  }

  void _updateDisplayedTasks() {
    Iterable<Task> displayedTasksIt = _allTasks;
    if (_requireNotDone) {
      displayedTasksIt = displayedTasksIt.where((task) => !task.isDone);
    }
    if (_requireFavorite) {
      displayedTasksIt = displayedTasksIt.where((task) => task.isFavorite);
    }
    _displayedTasks = displayedTasksIt.toList();
    setState(() {});
  }

  void _switchRequireNotDone() {
    _requireNotDone = !_requireNotDone;
    _updateDisplayedTasks();
  }

  void _switchRequireFavorite() {
    _requireFavorite = !_requireFavorite;
    _updateDisplayedTasks();
  }

  @override
  void initState() {
    super.initState();
    _topic = widget.topic;
    for (int i = 1; i < 21; i++) {
      _addTask("Task $i");
    }
    _updateDisplayedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          _topic,
          style: const TextStyle(fontSize: 30),
        ),
        actions: <Widget>[
          BranchPopUpMenu(
            requireNotDone: _requireNotDone,
            switchRequireNotDone: _switchRequireNotDone,
            requireFavorite: _requireFavorite,
            switchRequireFavorite: _switchRequireFavorite,
            removeDoneTasks: _removeDoneTasks,
            topic: _topic,
            editTopic: _editTopic,
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          _displayedTasks.isEmpty
              ? const EmptyTaskList()
              : const TaskListBackground(),
          TaskList(
            tasks: _displayedTasks,
            switchDone: _switchDone,
            switchFavorite: _switchFavorite,
            removeTask: _removeTask,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: Colors.purpleAccent,
        hoverColor: Colors.deepPurpleAccent,
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
