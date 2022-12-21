import 'package:flutter/material.dart';

import '../../app/config.dart';
import '../../models/task.dart';
import 'widgets/appbar/branch_popupmenu.dart';
import 'widgets/task_list/empty_task_list_background.dart';
import 'widgets/task_list/task_list_background.dart';
import 'widgets/task_list/task_list.dart';
import 'widgets/fab/add_task_dialog.dart';

class BranchScreen extends StatefulWidget {
  const BranchScreen({super.key, required this.topic});

  final String topic;

  @override
  State<BranchScreen> createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  String _topic = '';
  final List<Task> _allTasks = [];
  List<Task> _displayedTasks = [];
  bool _requireNotDone = false;
  bool _requireFavorite = false;

  void _editTopic(String newTopic) {
    setState(() {
      _topic = newTopic;
    });
  }

  int _getIndex(String id) {
    return _allTasks.indexWhere((task) => task.id == id);
  }

  void _switchDone(String id) {
    final i = _getIndex(id);
    _allTasks[i] = _allTasks[i].copyWith(isDone: !_allTasks[i].isDone);
    _updateDisplayedTasks();
  }

  void _switchFavorite(String id) {
    final i = _getIndex(id);
    _allTasks[i] = _allTasks[i].copyWith(isFavorite: !_allTasks[i].isFavorite);
    _updateDisplayedTasks();
  }

  void _addTask(String title) {
    _allTasks.add(
      Task(
        id: Config.uuid.v4(),
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
    setState(() {
      Iterable<Task> displayedTasksIt = _allTasks;
      if (_requireNotDone) {
        displayedTasksIt = displayedTasksIt.where((task) => !task.isDone);
      }
      if (_requireFavorite) {
        displayedTasksIt = displayedTasksIt.where((task) => task.isFavorite);
      }
      _displayedTasks = displayedTasksIt.toList();
    });
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
      _addTask('Task $i');
    }
    _updateDisplayedTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: _buildFloatingActionButton(context),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: Text(
        _topic,
        style: const TextStyle(fontSize: 30),
      ),
      actions: [_buildBranchPopupMenu()],
    );
  }

  BranchPopupMenu _buildBranchPopupMenu() {
    return BranchPopupMenu(
      requireNotDone: _requireNotDone,
      switchRequireNotDone: _switchRequireNotDone,
      requireFavorite: _requireFavorite,
      switchRequireFavorite: _switchRequireFavorite,
      removeDoneTasks: _removeDoneTasks,
      topic: _topic,
      editTopic: _editTopic,
    );
  }

  Stack _buildBody() {
    return Stack(
      children: [
        _displayedTasks.isEmpty
            ? const EmptyTaskListBackground()
            : const TaskListBackground(),
        TaskList(
          tasks: _displayedTasks,
          switchDone: _switchDone,
          switchFavorite: _switchFavorite,
          removeTask: _removeTask,
        ),
      ],
    );
  }

  FloatingActionButton _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
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
    );
  }
}
