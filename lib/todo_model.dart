import 'package:flutter/material.dart';
import 'package:todo_app/todo_item.dart';

class TodoModel with ChangeNotifier {
  final List<TodoItem> _items = [
    TodoItem('Make Flutter slides', 'Slides needed for introduction to Flutter!', true),
    TodoItem('Groceries', 'Need groceries because of dinner and breakfast', false),
    TodoItem('Cats', 'Feed and brush cats!', true),
  ];
  List<TodoItem> get items => List.unmodifiable(_items);

  void addOrUpdate(TodoItem item) {
    if (!_items.contains(item)) {
      _items.add(item);
    }
    notifyListeners();
  }

  void remove(TodoItem item) {
    _items.remove(item);
    notifyListeners();
  }
}