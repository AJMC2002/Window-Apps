import 'package:flutter/material.dart';

import 'widgets/bg.dart';
import 'widgets/appbar.dart';
import 'widgets/add_task_dialog.dart';
import 'widgets/task_list.dart';

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  //task list key
  final TaskListKey _taskListKey = TaskListKey();

  // flags
  bool _requireNotDone = false;
  bool _requireFav = false;
  // bool _isTaskListEmpty = false;
  final ValueNotifier<bool> _isTaskListEmpty = ValueNotifier(false);

  void _switchRequireNotDone() {
    setState(() {
      _requireNotDone = !_requireNotDone;
    });
  }

  void _switchRequireFav() {
    setState(() {
      _requireFav = !_requireFav;
    });
  }

  void _checkIsTaskListEmpty(int numTasks) {
    _isTaskListEmpty.value = (numTasks == 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
        requireNotDone: _requireNotDone,
        switchRequireNotDone: _switchRequireNotDone,
        requireFav: _requireFav,
        switchRequireFav: _switchRequireFav,
        taskListKey: _taskListKey,
      ),
      body: Stack(children: <Widget>[
        ValueListenableBuilder(
          valueListenable: _isTaskListEmpty,
          builder: ((context, value, child) =>
              value ? const HomeBackground() : Container()),
        ),
        TaskList(
          key: _taskListKey,
          requireNotDone: _requireNotDone,
          requireFav: _requireFav,
          checkIsTaskListEmpty: _checkIsTaskListEmpty,
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Добавить',
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTaskDialog(
            taskListKey: _taskListKey,
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
