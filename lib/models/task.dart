import 'package:uuid/uuid.dart';

var _uuid = const Uuid();

class Task {
  Task({
    required this.title,
    this.isDone = false,
    this.isFavorite = false,
  });

  final String id = _uuid.v4();
  String title;
  bool isDone;
  bool isFavorite;
}
