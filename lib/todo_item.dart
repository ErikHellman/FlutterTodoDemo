class TodoItem {
  String title;
  String description;
  DateTime created;
  bool done;

  TodoItem(this.title, this.description, this.done)
      : this.created = DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'created': created,
      'done': done
    };
  }

  @override
  String toString() {
    return 'TodoItem{title: $title, description: $description, created: $created, done: $done}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoItem &&
          runtimeType == other.runtimeType &&
          title == other.title &&
          description == other.description &&
          created == other.created &&
          done == other.done;

  @override
  int get hashCode =>
      title.hashCode ^ description.hashCode ^ created.hashCode ^ done.hashCode;
}
