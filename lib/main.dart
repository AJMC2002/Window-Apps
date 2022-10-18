import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const TaskApp());
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.purple[100],
        listTileTheme: ListTileThemeData(
          tileColor: Colors.grey[50],
        ),
        checkboxTheme: const CheckboxThemeData(
          shape: CircleBorder(),
        ),
      ),
      home: const TaskHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TaskHomePage extends StatefulWidget {
  const TaskHomePage({super.key});

  @override
  State<TaskHomePage> createState() => _TaskHomePageState();
}

class _TaskHomePageState extends State<TaskHomePage> {
  String topic = 'Учёба';
  final _formKey = GlobalKey<FormState>();
  int flag = 0;
  bool feedIsEmpty = true;
  List<String> taskTitles = [];
  List<bool> taskIsDone = [];
  List<bool> taskIsFav = [];

  void popUpMenuOnClick(String value) {
    switch (value) {
      case 'Hide completed':
        setState(() {
          flag += (flag % 2 == 0) ? 1 : -1;
        });
        break;
      case 'Only favourites':
        setState(() {
          flag += flag < 2 ? 2 : -2;
        });
        break;
      case 'Delete completed':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Center(child: Text('Подтвердите удаление')),
            content: const Text(
                'Удалить выполненные задачи? Это действие необратимо.'),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Отмена'),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    for (int i = taskTitles.length - 1; i >= 0; i--) {
                      if (taskIsDone[i]) {
                        taskTitles.removeAt(i);
                        taskIsDone.removeAt(i);
                        taskIsFav.removeAt(i);
                      }
                    }
                  });
                  Navigator.pop(context, 'Ок');
                },
                child: const Text('Ок'),
              ),
            ],
          ),
        );
        break;
      case 'Edit topic':
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Center(
                child: Text(
              'Редактировать ветку',
              style: TextStyle(fontSize: 30),
            )),
            content: Form(
              key: _formKey,
              child: TextFormField(
                decoration: const InputDecoration(
                  icon: Icon(Icons.edit),
                  hintText: 'Введите название ветки',
                ),
                initialValue: topic,
                maxLength: 40,
                validator: (String? input) {
                  if (input != null && input.isNotEmpty) {
                    if (input.length > 40) {
                      return 'Слишком длинное название';
                    } else {
                      return null;
                    }
                  } else {
                    return 'Название не может быть пустым';
                  }
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onSaved: (String? input) {
                  setState(() {
                    topic = input!;
                  });
                },
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Отмена'),
                child: const Text('Отмена'),
              ),
              TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    Navigator.pop(context, 'Ок');
                  }
                },
                child: const Text('Ок'),
              ),
            ],
          ),
        );
        break;
    }
  }

  void callback(bool state) {
    setState(() {
      feedIsEmpty = state;
    });
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Center(
            child: Text(
          'Создать задачу',
          style: TextStyle(fontSize: 30),
        )),
        content: Form(
          key: _formKey,
          child: TextFormField(
            decoration: const InputDecoration(
              icon: Icon(Icons.add),
              hintText: 'Введите название задачи',
            ),
            maxLength: 40,
            validator: (String? input) {
              if (input != null && input.isNotEmpty) {
                if (input.length > 40) {
                  return 'Слишком длинное название';
                } else {
                  return null;
                }
              } else {
                return 'Название не может быть пустым';
              }
            },
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onSaved: (String? input) {
              setState(() {
                taskTitles.add(input!);
                taskIsDone.add(false);
                taskIsFav.add(false);
              });
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Отмена'),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                callback(taskTitles.isEmpty);
                Navigator.pop(context, 'Ок');
              }
            },
            child: const Text('Ок'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          topic,
          style: const TextStyle(fontSize: 30),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
              tooltip: 'Показать меню',
              color: Colors.grey[50],
              onSelected: popUpMenuOnClick,
              itemBuilder: (context) => {
                    {
                      'value': 'Hide completed',
                      'title': flag % 2 != 1
                          ? 'Скрыть выполненные'
                          : 'Показать выполненные',
                      'icon': const Icon(Icons.check_circle)
                    },
                    {
                      'value': 'Only favourites',
                      'title': flag < 2 ? 'Только избранные' : 'Все задачи',
                      'icon': const Icon(Icons.star)
                    },
                    {
                      'value': 'Delete completed',
                      'title': 'Удалить выполненные',
                      'icon': const Icon(Icons.delete)
                    },
                    {
                      'value': 'Edit topic',
                      'title': 'Редактировать тему',
                      'icon': const Icon(Icons.edit)
                    },
                  }
                      .map(
                        (Map<String, dynamic> item) => PopupMenuItem<String>(
                          value: item['value'],
                          child: ListTile(
                            leading: item['icon'],
                            title: Text(item['title']),
                          ),
                        ),
                      )
                      .toList())
        ],
      ),
      body: feedIsEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SvgPicture.asset(
                        'assets/todolist_background.svg',
                      ),
                      SvgPicture.asset(
                        'assets/todolist.svg',
                      ),
                    ],
                  ),
                  const Flexible(
                    child: Text(
                      'На данный момент задачи отсутствуют',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ],
              ),
            )
          : Center(
              child: TaskList(
                flag: flag,
                taskTitles: taskTitles,
                taskIsDone: taskIsDone,
                taskIsFav: taskIsFav,
                callback: callback,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Добавить',
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList({
    super.key,
    required this.flag,
    required this.taskTitles,
    required this.taskIsDone,
    required this.taskIsFav,
    required this.callback,
  });

  final int flag;
  final List<String> taskTitles;
  final List<bool> taskIsDone;
  final List<bool> taskIsFav;
  final Function callback;

  final favIcon = const Icon(Icons.star_border_purple500_outlined,
      color: Colors.deepPurple);
  final favIconSelected =
      const Icon(Icons.star, color: Colors.deepPurpleAccent);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool flagChecker(int index) {
    bool isDone = widget.taskIsDone[index];
    bool isFav = widget.taskIsFav[index];
    return widget.flag == 0 ||
        (widget.flag == 1 && !isDone) ||
        (widget.flag == 2 && isFav) ||
        (widget.flag == 3 && !isDone && isFav);
  }

  ClipRect taskBuilder(int index) {
    return ClipRect(
      clipBehavior: Clip.hardEdge,
      child: Dismissible(
        background: Container(
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: Colors.red,
            border: Border.all(color: Colors.black),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Transform.scale(
              scale: 1.2,
              child: const Icon(Icons.delete),
            ),
          ),
        ),
        key: UniqueKey(),
        onDismissed: (DismissDirection direction) {
          setState(() {
            widget.taskTitles.removeAt(index);
            widget.taskIsDone.removeAt(index);
            widget.taskIsFav.removeAt(index);
            widget.callback(widget.taskTitles.isEmpty);
          });
        },
        child: ListTile(
          leading: Transform.scale(
            scale: 1.2,
            child: Checkbox(
              value: widget.taskIsDone[index],
              onChanged: (bool? newValue) {
                setState(
                  () {
                    widget.taskIsDone[index] = newValue!;
                  },
                );
              },
            ),
          ),
          title: Text(
            widget.taskTitles[index],
            style: const TextStyle(fontSize: 20),
          ),
          trailing: Transform.scale(
            scale: 1.2,
            child: IconButton(
              icon: widget.taskIsFav[index]
                  ? widget.favIconSelected
                  : widget.favIcon,
              onPressed: () {
                setState(() {
                  widget.taskIsFav[index] = !widget.taskIsFav[index];
                });
              },
            ),
          ),
          contentPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<int> validIdx = [];
    for (var i = 0; i < widget.taskTitles.length; i++) {
      if (flagChecker(i)) {
        validIdx.add(i);
      }
    }
    return ListView.separated(
        padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
        itemCount: validIdx.length,
        // flagChecker(index) ? taskBuilder(index) : Container()
        itemBuilder: (context, index) => taskBuilder(validIdx[index]),
        separatorBuilder: (context, index) => const Divider(
              color: Colors.deepPurpleAccent,
              indent: 25,
              endIndent: 25,
              thickness: 2,
            ));
  }
}
