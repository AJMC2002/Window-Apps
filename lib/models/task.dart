class Task {
  Task(this.title)
      : isDone = false,
        isFav = false;

  int? index;
  String title;
  bool isDone;
  bool isFav;

  void editTitle(String newTitle) {
    title = newTitle;
  }

  void switchDone() {
    isDone = !isDone;
  }

  void switchFav() {
    isFav = !isFav;
  }
}
