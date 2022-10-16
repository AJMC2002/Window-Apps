import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.purple[100],
        listTileTheme: ListTileThemeData(
          tileColor: Colors.grey[50],
          contentPadding: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        checkboxTheme: const CheckboxThemeData(
          shape: CircleBorder(),
        ),
      ),
      home: const MyHomePage(title: 'Studies'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _taskTitles = ['Task 1', 'Task 2', 'Task 3'];
  final List<bool?> _taskIsSelected = [false, true, false];
  final List<bool> _taskIsFav = [false, true, true];

  final _favIcon = const Icon(Icons.star_border_purple500_outlined,
      color: Colors.deepPurple);
  final _favIconSelected =
      const Icon(Icons.star, color: Colors.deepPurpleAccent);

  void _addTask() {
    setState(() {
      _taskTitles.add(_taskTitles[_taskTitles.length - 1] + '1');
      _taskIsSelected.add(false);
      _taskIsFav.add(false);
    });
  }

  void _popUpMenuOnClick(String value) {
    switch (value) {
      case 'Скрыть выполнение':
        break;
      case 'Только избранные':
        break;
      case 'Удалить выполнение':
        break;
      case 'Редактировать тему':
        break;
    }
  }

  ListTile _newTask(int index) {
    return ListTile(
      leading: Checkbox(
        value: _taskIsSelected[index],
        onChanged: (bool? newValue) {
          setState(
            () {
              _taskIsSelected[index] = newValue;
            },
          );
        },
      ),
      title: Text(
        _taskTitles[index],
        style: const TextStyle(
          fontSize: 20,
        ),
      ),
      trailing: IconButton(
        icon: _taskIsFav[index] ? _favIconSelected : _favIcon,
        onPressed: () {
          setState(() {
            _taskIsFav[index] = !_taskIsFav[index];
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: <Widget>[
          PopupMenuButton<String>(
              onSelected: _popUpMenuOnClick,
              itemBuilder: (BuildContext context) {
                return {
                  'Скрыть выполнение',
                  'Только избранные',
                  'Удалить выполнение',
                  'Редактировать тему',
                }.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              })
        ],
      ),
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          itemCount: _taskTitles.length,
          itemBuilder: (context, index) => _newTask(index),
          separatorBuilder: (context, index) => const Divider(
            color: Colors.purpleAccent,
            indent: 50,
            endIndent: 50,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        tooltip: 'Add',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
