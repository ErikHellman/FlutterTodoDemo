class TodoItem {
  int id;
  String title;
  String description;
  DateTime created;
  bool done;

  TodoItem({this.id = 0, this.title, this.description, this.done = false, this.created});

  static TodoItem fromMap(Map<String, dynamic> data) {
    var id = data['id'] as int;
    var title = data['title'] as String;
    var description = data['description'] as String;
    var created = DateTime.fromMillisecondsSinceEpoch(data['created'] as int);
    var done = (data['done'] as int) != 0;
    return TodoItem(
        id: id,
        title: title,
        description: description,
        created: created,
        done: done);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title ?? '',
      'description': description ?? '',
      'created': created.millisecondsSinceEpoch ?? DateTime.now(),
      'done': done ?? false ? 1 : 0
    };
  }


}
