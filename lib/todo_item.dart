class TodoItem {
  int id;
  String title;
  String description;
  DateTime created;

  TodoItem({this.id, this.title, this.description,  this.created});

  static TodoItem fromMap(Map<dynamic, dynamic> data, int id) {
    var title = data['title'] as String;
    var description = data['description'] as String;
    var created = DateTime.fromMillisecondsSinceEpoch(data['created'] as int);
    return TodoItem(
        id: id,
        title: title,
        description: description,
        created: created);
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title ?? '',
      'description': description ?? '',
      'created': created.millisecondsSinceEpoch ?? DateTime.now(),
    };
  }

  @override
  String toString() {
    return 'TodoItem{id: $id, title: $title, description: $description, created: $created}';
  }
}
