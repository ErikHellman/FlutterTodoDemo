import 'package:flutter/material.dart';
import 'package:todo_app/todo_item.dart';

class TodoModel with ChangeNotifier {
  final List<TodoItem> _items = [];

  List<TodoItem> get items => _items;

  void addOrUpdate(TodoItem item) {
    if (!_items.contains(item)) {
      _items.add(item);
    }
    notifyListeners()
  }

  void remove(TodoItem item) {
    _items.remove(item);
    notifyListeners();
  }
}