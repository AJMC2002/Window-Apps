import 'package:flutter/material.dart';

import '../../../models/task.dart';

typedef TaskListKey = GlobalKey<_TaskListState>;

class TaskList extends StatefulWidget {
  const TaskList({
    super.key,
    required this.requireNotDone,
    required this.requireFav,
    required this.checkIsTaskListEmpty,
  });

  final bool requireNotDone;
  final bool requireFav;
  final Function checkIsTaskListEmpty;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final List<Task> _tasks = [];

  void _switchDone(int index) {
    setState(() {
      _tasks[index].switchDone();
    });
  }

  void _switchFav(int index) {
    setState(() {
      _tasks[index].switchFav();
    });
  }

  void addTask(String title) {
    _tasks.add(Task(title));
    _updateValidTasks();
  }

  void _removeTaskAt(int index) {
    _tasks.removeAt(index);
    _updateValidTasks();
  }

  void removeDoneTasks() {
    for (int index = _tasks.length - 1; index >= 0; index--) {
      if (_tasks[index].isDone) {
        _removeTaskAt(index);
      }
    }
  }

  late List<Task> _validTasks;

  void _updateValidTasks() {
    setState(() {
      _validTasks = [];
      for (int i = 0; i < _tasks.length; i++) {
        if (!(widget.requireNotDone && _tasks[i].isDone) &&
            (!widget.requireFav || _tasks[i].isFav)) {
          _tasks[i].index = i;
          _validTasks.add(_tasks[i]);
        }
      }
    });
    widget.checkIsTaskListEmpty(_validTasks.length);
  }

  @override
  void initState() {
    super.initState();
    _updateValidTasks();
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateValidTasks();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(
        top: 30,
        left: 30,
        right: 30,
        bottom: kFloatingActionButtonMargin + 50,
      ),
      itemCount: _validTasks.length,
      itemBuilder: (context, index) => _TaskTile(
        task: _validTasks[index],
        switchDone: _switchDone,
        switchFav: _switchFav,
        removeTaskAt: _removeTaskAt,
      ),
      separatorBuilder: (context, index) => const Divider(
        color: Colors.deepPurpleAccent,
        indent: 25,
        endIndent: 25,
        thickness: 2,
      ),
    );
  }
}

class _TaskTile extends StatefulWidget {
  const _TaskTile({
    required this.task,
    required this.switchDone,
    required this.switchFav,
    required this.removeTaskAt,
  });

  final Task task;
  final Function switchDone;
  final Function switchFav;
  final Function removeTaskAt;

  @override
  State<_TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<_TaskTile> {
  final Icon _favIcon = const Icon(Icons.star_border_purple500_outlined,
      color: Colors.deepPurple);

  final Icon _favIconSelected =
      const Icon(Icons.star, color: Colors.deepPurpleAccent);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: Dismissible(
        key: Key(widget.task.title),
        background: Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: const Padding(
            padding: EdgeInsets.all(15),
            child: SizedBox(
              height: double.infinity,
              child: Icon(Icons.delete, size: 30),
            ),
          ),
        ),
        onDismissed: (direction) => widget.removeTaskAt(widget.task.index),
        child: ListTile(
          title: Text(
            widget.task.title,
            style: const TextStyle(fontSize: 20),
          ),
          minLeadingWidth: 0,
          leading: SizedBox(
            height: double.infinity,
            child: Transform.scale(
              scale: 1.25,
              child: Checkbox(
                value: widget.task.isDone,
                onChanged: (_) => widget.switchDone(widget.task.index),
              ),
            ),
          ),
          trailing: SizedBox(
            height: double.infinity,
            child: IconButton(
              icon: widget.task.isFav ? _favIconSelected : _favIcon,
              iconSize: 30,
              onPressed: () => widget.switchFav(widget.task.index),
            ),
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
      ),
    );
  }
}
