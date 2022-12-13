class Task {
  Task({
    required this.id,
    required this.title,
    this.isDone = false,
    this.isFavorite = false,
  });

  final String id;
  String title;
  bool isDone;
  bool isFavorite;
}
