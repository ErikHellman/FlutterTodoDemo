class TodoItem {
  String title;
  String description;
  DateTime created;
  bool done;

  TodoItem(this.title, this.description, this.done)
      : this.created = DateTime.now();
}
