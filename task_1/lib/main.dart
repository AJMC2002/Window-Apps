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
  final List<String> _taskTitles =[];
  final List<bool?> _taskIsSelected=[];
  final List<bool> _taskIsFav=[];

  final _favIcon = const Icon(Icons.star_border_purple500_outlined,
      color: Colors.deepPurple);
  final _favIconSelected =
      const Icon(Icons.star, color: Colors.deepPurpleAccent);

  void _addTask() {
    setState(() {
      _taskTitles.add('Test task #N');
      _taskIsSelected.add(false);
      _taskIsFav.add(false);
    });
  }

  void _popUpMenuOnClick(String value) {
    switch (value) {
      case 'Скрыть выполненные':
        break;
      case 'Только избранные':
        break;
      case 'Удалить выполненные':
        break;
      case 'Редактировать тему':
        break;
    }
  }

  ListTile _newTask(int index) {
    return ListTile(
      leading: Transform.scale(
        scale: 1.2,
        child: Checkbox(
          value: _taskIsSelected[index],
          onChanged: (bool? newValue) {
            setState(
              () {
                _taskIsSelected[index] = newValue;
              },
            );
          },
        ),
      ),
      title: Text(
        _taskTitles[index],
        style: const TextStyle(fontSize: 20),
      ),
      trailing: Transform.scale(
        scale: 1.2,
        child: IconButton(
          icon: _taskIsFav[index] ? _favIconSelected : _favIcon,
          onPressed: () {
            setState(() {
              _taskIsFav[index] = !_taskIsFav[index];
            });
          },
        ),
      ),
      contentPadding: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 30),
        ),
        actions: <Widget>[
          PopupMenuButton<String>(
              color: Colors.grey[50],
              onSelected: _popUpMenuOnClick,
              itemBuilder: (context) => {
                    {
                      'value': 'Hide completed',
                      'title': 'Скрыть выполненные',
                      'icon': const Icon(Icons.check_circle)
                    },
                    {
                      'value': 'Only selected',
                      'title': 'Только избранные',
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
      body: Center(
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 30, left: 30, right: 30),
          itemCount: _taskTitles.length,
          itemBuilder: (context, index) => _newTask(index),
          separatorBuilder: (context, index) => const Divider(
            color: Colors.deepPurpleAccent,
            indent: 25,
            endIndent: 25,
            thickness: 2,
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
